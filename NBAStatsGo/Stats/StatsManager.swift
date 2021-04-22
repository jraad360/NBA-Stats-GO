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
    
    /**
     Upon initialization, the StatsManager loads any player and stats data that has been stored locally.
     */
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
    
    /**
     Gets a list of players from the APIManager
     - Parameter filters: a dictionary mapping the field a player is to be filtered by to its value
     - Returns a list of players that match the given filters
     */
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
    
    /**
     Uses the APIManager to get the season averages for every season in a player's career
     - Parameter player: the player for which the career stats are desired
     - Returns a list of PlayerSeasonAverageStats, representing the season averages for all the seasons in a player's career
     */
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
    
    /**
     Uses the APIManager to go through all the games of the given player to provide the career high for the given stat category
     - Parameter player: the player for which the career high is desired
     - Parameter statCategory: the stat category for which the highest value in the player's career is desired
     - Returns a String containing the highest number of the stat category the player has achieved in his career
     */
    func getCareerHigh(for player: Player, in statCategory: StatCategory) throws -> String {
        return try apiManager.getCareerHigh(for: player, in: statCategory)
    }
    
    /**
     Retrieves all players from locally saved JSON file
     - Returns an array of all the Players that have been bundled with the app
     */
    func getPlayersFromFile() throws -> [Player] {
        var players = [Player]()
        
        /// If there has been data saved since the user began using the app, read from there. Otherwise read the initial players from the bundled file.
        do {
            players = try jsonReader.read(from: playersFileName, structType: [Player].self)
        } catch {
            players = []
            let jsonData = jsonReader.readBundledFile(forName: "players")
            let json = jsonData != nil ? try JSON(data: jsonData!) : JSON()
            
            /// id's of players that have been added to list
            var ids = Set<Int>()
            
            let retrievedPlayers = try json["data"].map { try Player(json: $1) }
            
            /// remove repeated players
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
