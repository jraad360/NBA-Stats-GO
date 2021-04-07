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
    
    func getPlayers(filters: [String : String]) throws -> [Player] {
        let path = apiPath + "players"
        let name = filters["name"]!
        let json = try callAPI(path: path, queryParameters: ["search": name])
        
        let currentPage = try json["meta"]["current_page"]
        let totalPages = try json["meta"]["total_pages"]
        let perPage = try json["meta"]["per_page"]
        let totalCount = try json["meta"]["total_count"]
        
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
