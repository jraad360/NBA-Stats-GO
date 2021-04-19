//
//  BallDontLieAPIManager.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation
import SwiftyJSON

class BallDontLieAPIManager: APIManager {
    let apiPath = "https://balldontlie.io/api/v1/"
    let minimumYear = 1979
    let maximumYear = Calendar.current.component(.year, from: Date())
    let pageSize = 100
    
    // MARK: Stats APIs
    
    /**
     Uses balldontlie.io's API to retrieve a list of all NBA players in history
     */
    func getPlayers(filters: [String : String]) throws -> [Player] {
        let path = apiPath + "players"
        var totalCount = 0
        var currentPage = 0
        var players = [Player]()
        
        
        let name = filters["name"] ?? ""
        
        // id's of players that have been added to list
        var ids = Set<Int>()
        
        repeat {
            do {
                let json = try callAPI(path: path, queryParameters: [
                                        "per_page": String(pageSize),
                                        "page": String(currentPage),
                                        "search": name])
                let retrievedPlayers = try json["data"].map { try Player(json: $1) }
                
                // check that player's id has not been added before appending to list
                for player in retrievedPlayers {
                    if !ids.contains(player.id) {
                        players.append(player)
                        ids.insert(player.id)
                    }
                }
                currentPage += 1
                totalCount = json["meta"]["total_count"].int ?? 0
                let totalPages = json["meta"]["total_pages"].int ?? currentPage
                DispatchQueue.main.async {
                    if (currProgress?.progress != 1) {
                        currProgress?.setProgress(Float(currentPage)/Float(totalPages), animated: true)
                    }
                }
            } catch APIError.tooManyRequests {
                do {
                    print("Sleeping to avoid getting rate-limited")
                    sleep(10)
                }
            }
        } while (currentPage - 1)*pageSize <= totalCount

        return players.sorted()
    }
    
    /**
     Uses balldontlie.io's API to retrieve a list of an NBA player's season-by-season averages for their entire career
     */
    func getCareerStats(for player: Player) throws -> [PlayerSeasonAverageStats] {
        let path = apiPath + "season_averages"
        var seasons = [PlayerSeasonAverageStats]()
        
        let careerRange = try getCareerRange(for: player)
        
        var currentYear = careerRange.lowerBound
        for year in careerRange {
            do {
                print(year)
                let json = try callAPI(path: path, queryParameters: [
                                        "season": String(year),
                                        "player_ids[]": String(player.id)])
                if !json["data"].isEmpty && json["data"].count != 0 {
                    seasons.append(try PlayerSeasonAverageStats(json: json["data"][0]))
                }
                currentYear += 1
                DispatchQueue.main.async {
                    if (currProgress?.progress != 1) {
                        currProgress?.setProgress(Float(currentYear)/Float(careerRange.upperBound - careerRange.lowerBound), animated: true)
                    }
                }

            } catch APIError.tooManyRequests {
                do {
                    print("Sleeping to avoid getting rate-limited")
                    sleep(10)
                }
            }
        }
        
        return seasons
    }
    
    /**
     Uses balldontlie.io's API to find a player's career high in a given statistical category
     */
    func getCareerHigh(for player: Player, in statCategory: StatCategory) throws -> String {
        var careerHigh: Double = 0
        
        var gameStats = [PlayerGameStats]()
        let path = apiPath + "stats"
        var totalCount = 0
        var currentPage = 0
        repeat {
            do {
                let json = try callAPI(path: path, queryParameters: [
                                        "per_page": String(pageSize),
                                        "page": String(currentPage),
                                        "player_ids[]": String(player.id)])
                let games = json["data"]
                for game in games {
                    let valueJSON = game.1[statCategory.rawValue]
                    if !valueJSON.exists() || valueJSON.double == nil {
                        continue
                    }
                    let value = valueJSON.double ?? 0.0
                    if value > careerHigh {
                        careerHigh = value
                    }
                    gameStats.append(try PlayerGameStats(json: game.1))
                }
                currentPage += 1
                totalCount = json["meta"]["total_count"].int ?? 0
                let totalPages = json["meta"]["total_pages"].int ?? currentPage
                DispatchQueue.main.async {
                    if (currProgress?.progress != 1) {
                        currProgress?.setProgress(Float(currentPage)/Float(totalPages), animated: true)
                    }
                }
            } catch APIError.tooManyRequests {
                do {
                    print("Sleeping to avoid getting rate-limited")
                    sleep(10)
                }
            }
        } while (currentPage)*pageSize < totalCount
        
        switch statCategory {
            case .fgpct, .fg3pct, .ftpct:
                return "\(careerHigh)%"
            default:
                return Int(careerHigh).description
        }
    }
    
    func getAllGamesStats(for player: Player) throws -> [PlayerGameStats] {
        var gameStats = [PlayerGameStats]()
        var totalCount = 0
        var currentPage = 0
        repeat {
            let games = try getGamesStats(queryParameters: [
                                        "per_page": String(pageSize),
                                        "page": String(currentPage),
                                        "player_ids[]": String(player.id)])
            gameStats.append(contentsOf: games.gameStats)
            currentPage += 1
            totalCount = games.meta["total_count"].int ?? 0
            let totalPages = games.meta["total_pages"].int ?? currentPage
            DispatchQueue.main.async {
                if (currProgress?.progress != 1) {
                    currProgress?.setProgress(Float(currentPage)/Float(totalPages), animated: true)
                }
            }
        } while (currentPage)*pageSize < totalCount
        
        return gameStats
    }
    
    // MARK: Helper Functions
    
    /**
     Helper method used to call any API via HTTP
     */
    private func callAPI(path: String, queryParameters: [String: String]) throws -> JSON {
        // TODO: handle invalid URL
        let url = getURL(path: path, queryParameters: queryParameters)
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var result: Data? = nil
        
        var httpStatusCode: Int? = nil
        
        session.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                httpStatusCode = httpResponse.statusCode
            }
            result = data
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        
        if httpStatusCode == 429 {
            throw APIError.tooManyRequests
        }

        let json = result != nil ? try JSON(data: result!) : JSON()
        
        return json
    }
    
    private func getGamesStats(queryParameters: [String: String]) throws -> (gameStats: [PlayerGameStats], meta: JSON) {
        var gameStats = [PlayerGameStats]()
        
        let path = apiPath + "stats"
        let json = try callAPI(path: path, queryParameters: queryParameters)
        let games = json["data"]
        for game in games {
            gameStats.append(try PlayerGameStats(json: game.1))
        }
        return (gameStats, json["meta"])
    }
    
    private func getCareerRange(for player: Player) throws -> ClosedRange<Int> {
        let firstPageOfGames = try getGamesStats(queryParameters: [
                                            "per_page": String(pageSize),
                                            "page": String(0),
                                            "player_ids[]": String(player.id)])
        if firstPageOfGames.gameStats.count == 0 {
            return maximumYear...maximumYear
        }
        
        let firstSeason = firstPageOfGames.gameStats[0].game.season
        
        var lastPage = Int(firstPageOfGames.meta["total_pages"].int ?? 1)
        
        if lastPage == 1 {
            return (Int(firstSeason) ?? minimumYear)...(Int(firstSeason) ?? maximumYear)
        }
        
        var lastSeason = String(minimumYear)
        while lastPage > 1 {
            let lastPageOfGames = try getGamesStats(queryParameters: [
                                                "per_page": String(pageSize),
                                                "page": String(lastPage),
                                                "player_ids[]": String(player.id)])
            let firstGameIsPlayoffs = lastPageOfGames.gameStats[0].game.playoffs
            if firstGameIsPlayoffs {
                lastPage -= 1
                continue
            }
            var lastGame = lastPageOfGames.gameStats[0]
            for currentGameStats in lastPageOfGames.gameStats {
                if !lastGame.game.playoffs && currentGameStats.game.playoffs {
                    break
                }
                lastGame = currentGameStats
            }
            lastSeason = lastGame.game.season
            break
        }
        
        if lastSeason < firstSeason {
            return minimumYear...maximumYear
        }
        
        return (Int(firstSeason) ?? minimumYear)...(Int(lastSeason) ?? maximumYear)
    }
    
    private func getURL(path: String, queryParameters: [String: String]) -> URL {
        let queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        var urlComponents = URLComponents(string: path)!
        
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
    
    
}
