//
//  Game.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation
import SwiftyJSON

struct Game {
    let date: Date
    let homeTeam: Team
    let playoffs: Bool
    
    init(date: Date, homeTeam: Team, playoffs: Bool) {
        self.date = date
        self.homeTeam = homeTeam
        self.playoffs = playoffs
    }
    
    init(json: JSON) throws {
        self.init(
            date: ISO8601DateFormatter().date(from: json["date"].string!)!,
            homeTeam: try Team(json: json["city"]),
            playoffs: json["conference"].bool!)
    }
}
