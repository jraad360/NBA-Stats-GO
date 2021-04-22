//
//  APIManager.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

/**
 This protocol defines what APIs can be called by the StatsManager. Aside from defining a clear contract between the StatsManager and the APIManager, this protocol hides the API-specific implementation of these functions, so it would be easy to replace the BallDontLieAPIManager with another APIManager in case we choose to change the API being used by the app.
 */
protocol APIManager {
    
    /**
     Uses an API to retrieve a list of all NBA players in history
     - Parameter filters: filters used to search for specific players
     - Returns an array of NBA Players that match the given search parameters
     */
    func getPlayers(filters: [String:String]) throws -> [Player]
    
    /**
     Uses an API to retrieve a list of an NBA player's season-by-season averages for their entire career
     - Parameter player: the player whose stats are being requested
     - Returns an array of season averages for a player's entire career
     */
    func getCareerStats(for player: Player) throws -> [PlayerSeasonAverageStats]
    
    /**
     Uses an API to find a player's career high in a given statistical category
     - Parameter player: the NBA player whose career high is requested
     - Parameter statCategory: the statistical category in which to search for the highest value
     - Returns the career high (the highest value a player has recorded over every game in their career) in the given statistical category for the given player
     */
    func getCareerHigh(for player: Player, in statCategory: StatCategory) throws -> String
}
