//
//  NBAStatsGoTests.swift
//  NBAStatsGoTests
//
//  Created by Jorge Alejandro Raad on 4/6/21.
//

import XCTest
@testable import NBAStatsGo

class NBAStatsGoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetPlayers() throws {
        let apiManager = BallDontLieAPIManager()
        let players = try apiManager.getPlayers(filters: ["name": ""])
        print(players)
    }
    
    func testGetCareerStats() throws {
        let apiManager = BallDontLieAPIManager()
        let players = try apiManager.getPlayers(filters: ["name": "LeBron"])
        let seasons = try apiManager.getCareerStats(for: players[0])
        print(seasons)
    }
    
    func testGetCareerHighs() throws {
        let apiManager = BallDontLieAPIManager()
        let players = try apiManager.getPlayers(filters: ["name": "LeBron"])
        let careerHigh = try apiManager.getCareerHigh(for: players[0], in: .pts)
    }
    
    func testCallingApiAsync() {

    }
    
    
    func load() {

    }


}
