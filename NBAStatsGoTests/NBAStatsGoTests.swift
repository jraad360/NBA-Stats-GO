//
//  NBAStatsGoTests.swift
//  NBAStatsGoTests
//
//  Created by Jorge Alejandro Raad on 4/6/21.
//

import XCTest
@testable import NBAStatsGo

class NBAStatsGoTests: XCTestCase {
    
    func testGetPlayers() throws {
        let apiManager = BallDontLieAPIManager()
        let players = try apiManager.getPlayers(filters: ["name": ""])
        assert(players.count >= 3454)
    }
    
    func testGetCareerStats() throws {
        let apiManager = BallDontLieAPIManager()
        let players = try apiManager.getPlayers(filters: ["name": "LeBron"])
        let seasons = try apiManager.getCareerStats(for: players[0])
        assert(seasons.count >= 18)
    }
    
    func testGetCareerHigh() throws {
        let apiManager = BallDontLieAPIManager()
        let players = try apiManager.getPlayers(filters: ["name": "LeBron"])
        let careerHigh = try apiManager.getCareerHigh(for: players[0], in: .pts)
        assert(Int(careerHigh) ?? 0 > 60)
    }
    
    func testCareerAverages() throws {
        let apiManager = BallDontLieAPIManager()
        let players = try apiManager.getPlayers(filters: ["name": "LeBron"])
        let seasons = try apiManager.getCareerStats(for: players[0])
        let careerAverages = PlayerSeasonAverageStats(seasons: seasons)
        assert(careerAverages.pts > 20)
    }
    
    
    func testGetAllPlayers() throws {
        let statsManager = StatsManager()
        let players = try statsManager.getAllPlayers()
        assert(players.count >= 3454)
    }


}
