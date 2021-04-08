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
    
    func getPlayers(filters: [String : String]) throws -> [Player] {
        let path = apiPath + "players"
        let name = filters["name"]!
        let json = try callAPI(path: path, queryParameters: ["search": name])
        
        let currentPage = try json["meta"]["current_page"].int!
        let totalPages = try json["meta"]["total_pages"].int!
        let perPage = try json["meta"]["per_page"].int!
        let totalCount = try json["meta"]["total_count"].int!
        
        let players = try json["data"].map { try Player(json: $1) }
        
        return players
    }
    
    func getCareerStats(for player: Player) throws -> [PlayerSeasonAverageStats] {
        let path = apiPath + "season_averages"
        var seasons = [PlayerSeasonAverageStats]()
        
        for year in minimumYear...maximumYear {
            let json = try callAPI(path: path, queryParameters: [
                                    "season": String(year),
                                    "player_ids[]": String(player.id)])
            if !json["data"].isEmpty && json["data"].count != 0 {
                seasons.append(try PlayerSeasonAverageStats(json: json["data"][0]))
            }
        }
        
        return seasons
    }
    
    func getCareerHigh(for player: Player, in statCategory: StatCategory) throws -> [String] {
        var gameStats = [PlayerGameStats]()
        let path = apiPath + "stats"
        var totalCount = 0
        var currentPage = 0
        repeat {
            let json = try callAPI(path: path, queryParameters: [
                                    "per_page": String(pageSize),
                                    "page": String(currentPage),
                                    "player_ids[]": String(player.id)])
            let games = json["data"]
            for game in games {
                gameStats.append(try PlayerGameStats(json: game.1))
            }
            totalCount = json["meta"]["total_count"].int!
            currentPage += 1
        } while (currentPage)*pageSize < totalCount
        print(gameStats.count)
        print(totalCount)
        return []
    }
    
    func callAPI(path: String, queryParameters: [String: String]) throws -> JSON {
        // TODO: handle invalid URL
        let url = getURL(path: path, queryParameters: queryParameters)
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var result: Data? = nil
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Handle HTTP request error
            } else if let data = data {
                // Handle HTTP request response
            } else {
                // Handle unexpected error
            }
            result = data
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture)

        let json = try JSON(data: result!)
        
        return json
    }
    
    func getURL(path: String, queryParameters: [String: String]) -> URL {
        let queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        var urlComponents = URLComponents(string: path)!
        
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
    
    
}
