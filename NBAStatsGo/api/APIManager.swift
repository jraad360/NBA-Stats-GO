//
//  APIManager.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

protocol APIManager {
    
    func getPlayers(filters: [String:String]) throws -> [Player]
    
    func getCareerStats(for player: Player) throws -> [PlayerSeasonAverageStats]
    
    func getCareerHigh(for player: Player, in statCategory: StatCategory) throws -> String
}
