//
//  Game.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation
import SwiftyJSON

struct Game: Codable {
    let date: Date
    let season: String
    let homeTeam: Team
    let playoffs: Bool
    
    init(date: Date, season: String, homeTeam: Team, playoffs: Bool) {
        self.date = date
        self.season = season
        self.homeTeam = homeTeam
        self.playoffs = playoffs
    }
    
    init(json: JSON) throws {
        let dateString = json["date"].string!.split(separator: ".")
        self.init(
            date: ISO8601DateFormatter().date(from: String(dateString[0]) + "Z") ?? Date(),
            season: String(json["season"].int ?? 0),
            homeTeam: try Team(id: json["home_team_id"].int ?? 0),
            playoffs: json["postseason"].bool ?? false)
    }
}
