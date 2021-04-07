//
//  BallDontLieAPIManager.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

class BallDontLieAPIManager: APIManager {
    let apiPath = "https://balldontlie.io/api/v1/"
    
    func getPlayers(filters: [String : String]) throws -> [Player] {
        let name = filters["name"]!
        try callAPI(path: apiPath + "players", queryParameters: ["search": name])
        return []
    }
    
    func getCareerStats(for player: Player) throws -> [PlayerSeasonAverageStats] {
        return []
    }
    
    func getCareerHigh(for player: Player, in statCategory: StatCategory) throws -> [String] {
        return []
    }
    
    func callAPI(path: String, queryParameters: [String: String]) throws -> Any {
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

        let json = try JSONSerialization.jsonObject(with: result!, options: []) as! [String:AnyObject]
        
        print(json)
        
        return result
    }
    
    func getURL(path: String, queryParameters: [String: String]) -> URL {
        let queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        var urlComponents = URLComponents(string: path)!
        
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
    
    
}
