//
//  StatsManager.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 4/17/21.
//

import Foundation
import SwiftyJSON

class StatsManager {
    let apiManager: APIManager = BallDontLieAPIManager()
    
    
    func getPlayers(filters: [String:String]) throws -> [Player] {
        return try apiManager.getPlayers(filters: filters)
    }
    
    func getCareerStats(for player: Player) throws -> [PlayerSeasonAverageStats] {
        return try apiManager.getCareerStats(for: player)
    }
    
    func getCareerHigh(for player: Player, in statCategory: StatCategory) throws -> String {
        return try apiManager.getCareerHigh(for: player, in: statCategory)
    }
    
    /**
     Retrieves all players from locally saved JSON file
     */
    func getPlayersFromFile() throws -> [Player] {
        var players = [Player]()
        
        let jsonData = readLocalJSONFile(forName: "players")
        let json = jsonData != nil ? try JSON(data: jsonData!) : JSON()
        
        // id's of players that have been added to list
        var ids = Set<Int>()
        
        let retrievedPlayers = try json["data"].map { try Player(json: $1) }
        
        // remove repeated players
        for player in retrievedPlayers {
            if !ids.contains(player.id) {
                players.append(player)
                ids.insert(player.id)
            }
        }
        
        return players
    }
    
    /**
     Retrieves JSON from local file
     */
    private func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
