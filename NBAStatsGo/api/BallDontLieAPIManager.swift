//
//  BallDontLieAPIManager.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

class BallDontLieAPIManager: APIManager {
    func getPlayers(filters: [String : String]) throws -> [Player] {
        return []
    }
    
    func getCareerStats(for player: Player) throws -> [PlayerSeasonAverageStats] {
        return []
    }
    
    func getCareerHigh(for player: Player, in statCategory: StatCategory) throws -> [String] {
        return []
    }
    
    
}
