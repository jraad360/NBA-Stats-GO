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
        let dateString = json["date"].string!.split(separator: ".")
        self.init(
            date: ISO8601DateFormatter().date(from: String(dateString[0]) + "Z")!,
            homeTeam: try Team(id: json["home_team_id"].int!),
            playoffs: json["postseason"].bool!)
    }
}
