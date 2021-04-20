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
    var cachedPlayerSeasonAverageStats = [Int: [PlayerSeasonAverageStats]]()
    var cachedPlayerGameStats = [Int: [PlayerSeasonAverageStats]]()
    
    let playersFileName = "players.json"
    let playerSeasonAverageStatsFileName = "player_season_average_stats.json"
    
    
    init() {
        do {
            do {
                cachedPlayerSeasonAverageStats = try self.jsonReader.read(from: self.playerSeasonAverageStatsFileName, structType: [Int: [PlayerSeasonAverageStats]].self)
            } catch {
                let data = self.jsonReader.readBundledFile(forName: "player_season_average_stats")
                cachedPlayerSeasonAverageStats = data != nil ? try JSONDecoder().decode([Int: [PlayerSeasonAverageStats]].self, from: data!) : [:]
            }
        } catch {
            print("Error reading cached player data")
        }
    }
    
    func getPlayers(filters: [String:String]) throws -> [Player] {
        let players = try apiManager.getPlayers(filters: filters)
        DispatchQueue.global(qos: .utility).async {
            do {
                try self.jsonReader.write(object: players, to: self.playersFileName)
            } catch {
                print("Error writing players to file.")
            }
        }
        return players
    }
    
    func getCareerStats(for player: Player) throws -> [PlayerSeasonAverageStats] {
        if self.cachedPlayerSeasonAverageStats[player.id] != nil {
            return self.cachedPlayerSeasonAverageStats[player.id]!
        }
        let seasons = try apiManager.getCareerStats(for: player)
        self.cachedPlayerSeasonAverageStats[player.id] = seasons
        DispatchQueue.global(qos: .utility).async {
            do {
                try self.jsonReader.write(object: self.cachedPlayerSeasonAverageStats, to: self.playerSeasonAverageStatsFileName)
            } catch {
                print("Error writing player season average stats to file.")
            }
        }

        return seasons
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
            
            for (index, player) in retrievedPlayers.enumerated() {
                if !ids.contains(player.id) {
                    players.append(player)
                    ids.insert(player.id)
                }
                DispatchQueue.main.async {
                    if (currProgress?.progress != 1) {
                        currProgress?.setProgress(Float(index + 1)/Float(retrievedPlayers.count), animated: true)
                    }
                }
            }
        }
        players.sort()
        return players
    }
}
