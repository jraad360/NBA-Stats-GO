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
     - Parameter filters: filters used to search for specific players
     - Returns an array of NBA Players that match the given search parameters
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
                let json = try HTTPRequest.callAPI(path: path, queryParameters: [
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
     - Parameter player: the player whose stats are being requested
     - Returns an array of season averages for a player's entire career
     */
    func getCareerStats(for player: Player) throws -> [PlayerSeasonAverageStats] {
        let path = apiPath + "season_averages"
        var seasons = [PlayerSeasonAverageStats]()
        
        let careerRange = try getCareerRange(for: player)
        
        var currentYear = careerRange.lowerBound
        for (index, year) in careerRange.enumerated() {
            do {
                print(year)
                let json = try HTTPRequest.callAPI(path: path, queryParameters: [
                                        "season": String(year),
                                        "player_ids[]": String(player.id)])
                if !json["data"].isEmpty && json["data"].count != 0 {
                    seasons.append(try PlayerSeasonAverageStats(json: json["data"][0]))
                }
                currentYear += 1
                DispatchQueue.main.async {
                    if (currProgress?.progress != 1) {
                        currProgress?.setProgress(Float(index + 1)/Float(careerRange.upperBound - careerRange.lowerBound), animated: true)
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
     - Parameter player: the NBA player whose career high is requested
     - Parameter statCategory: the statistical category in which to search for the highest value
     - Returns the career high (the highest value a player has recorded over every game in their career) in the given statistical category for the given player
     */
    func getCareerHigh(for player: Player, in statCategory: StatCategory) throws -> String {
        var careerHigh: Double = 0
        
        var gameStats = [PlayerGameStats]()
        let path = apiPath + "stats"
        var totalCount = 0
        var currentPage = 1
        repeat {
            do {
                let json = try HTTPRequest.callAPI(path: path, queryParameters: [
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
    
    /**
     Uses balldontlie.io's API to return the stats for every individual game in a player's career
     - Parameter player: the NBA player whose stats are requested
     - Returns an array of all the game stats for a player
     */
    func getAllGamesStats(for player: Player) throws -> [PlayerGameStats] {
        var gameStats = [PlayerGameStats]()
        var totalCount = 0
        var currentPage = 1
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
     Helper method used to call the API for individual game stats
     - Parameter queryParameters: the query parameters to attach to the GET call
     */
    private func getGamesStats(queryParameters: [String: String]) throws -> (gameStats: [PlayerGameStats], meta: JSON) {
        var gameStats = [PlayerGameStats]()
        
        let path = apiPath + "stats"
        let json = try HTTPRequest.callAPI(path: path, queryParameters: queryParameters)
        let games = json["data"]
        for game in games {
            gameStats.append(try PlayerGameStats(json: game.1))
        }
        return (gameStats, json["meta"])
    }
    
    /**
     Helper method used to calculate the first and last seasons a player played. To do this, API calls are made to figure out the dates of the first and last games a player played. Since Balldontlie's season_averages API only retrieves season averages for a given season, this helper method reduces the amount of API calls needed to be made. Without this calculation, an API call would need to be made for every season since 1979 in order to get a player's season averages. The function is complicated because games are not always in chronological order. Games played in the 2000s are returned before games played in the 1900s, meaning that it is not possible to determine the first and last seasons of a cross-centennial player without a significant amount of API calls that makes the calculation not worth it. For this reason, if the first game returned is chronologically greater than the last game returned, this optimization is not worth it, and the range from the the first year of stats available to the last season of stats available is returned.
     - Parameter player: the player for which we want to find out the seasons played
     - Returns a range from the player's first year in the league to their last
     */
    private func getCareerRange(for player: Player) throws -> ClosedRange<Int> {
        let firstPageOfGames = try getGamesStats(queryParameters: ["per_page": String(pageSize), "page": String(1), "player_ids[]": String(player.id)])
        if firstPageOfGames.gameStats.count == 0 {
            return maximumYear...maximumYear
        }
        let firstSeason = firstPageOfGames.gameStats[0].game.season
        
        let lastPage = Int(firstPageOfGames.meta["total_pages"].int ?? 1)
        
        if lastPage == 1 {
            return (Int(firstSeason) ?? minimumYear)...(Int(firstSeason) ?? maximumYear)
        }
        
        let lastSeason = try getLastSeason(player: player, lastPage: lastPage)
        
        if lastSeason < firstSeason {
            return minimumYear...maximumYear
        }
        
        return (Int(firstSeason) ?? minimumYear)...(Int(lastSeason) ?? maximumYear)
    }
    
    /**
     This is used to calculate the upper bound for a player's career range. The function is complicated because there are also playoff games appended to the end of the response that must be ignored, resulting  in more API calls that must be made to figure out the last regular season game of a player.
     */
    private func getLastSeason(player: Player, lastPage: Int) throws -> String {
        // last
        var currentPage = lastPage
        
        var lastSeason = String(minimumYear)
        while currentPage > 1 {
            let lastPageOfGames = try getGamesStats(queryParameters: ["per_page": String(pageSize), "page": String(currentPage), "player_ids[]": String(player.id)])
            let firstGameIsPlayoffs = lastPageOfGames.gameStats[0].game.playoffs
            if firstGameIsPlayoffs {
                currentPage -= 1
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
        return lastSeason
    }
    
}
