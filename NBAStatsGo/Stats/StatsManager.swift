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
    let jsonReader: JSONReader = JSONReader()
    
    /// cached dictionary of player id's to their season average stats
    var cachedPlayerSeasonStats = [Int: [PlayerSeasonAverageStats]]()
    
    let playersFileName = "players.json"
    let playerSeasonStatsFileName = "player_season_stats.json"
    
    
    init() {
        do {
            cachedPlayerSeasonStats = try jsonReader.read(from: playerSeasonStatsFileName, structType: [Int: [PlayerSeasonAverageStats]].self)
        } catch {
            print("Error reading cached player data")
        }
    }
    
    func getPlayers(filters: [String:String]) throws -> [Player] {
        let players = try apiManager.getPlayers(filters: filters)
        do {
            try jsonReader.write(object: players, to: playersFileName)
        } catch {
            print("Error writing players to file.")
        }
        return players
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
        
        do {
            players = try jsonReader.read(from: playersFileName, structType: [Player].self)
        } catch {
            players = []
            let jsonData = jsonReader.readBundledFile(forName: "players")
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
        }
        
        return players
    }
}
