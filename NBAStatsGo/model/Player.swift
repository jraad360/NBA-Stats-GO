//
//  Player.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation
import SwiftyJSON

struct Player {
    let id: Int
    let firstName: String
    let lastName: String
    let position: String?
    let height: String?
    let weight: Int?
    let team: Team
    
    init(id: Int, firstName: String, lastName: String, position: String?, height: String?, weight: Int?, team: Team) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.height = height
        self.weight = weight
        self.team = team
    }
    
    init(json: JSON) throws {
        let team = json["team_id"].exists() ? try Team(id: json["team_id"].int!) : try Team(json: json["team"])
        self.init(
            id: json["id"].int!,
            firstName: json["first_name"].string!,
            lastName: json["last_name"].string!,
            position: json["position"].string,
            height: json["height"].string,
            weight: json["weight"].int,
            team: team)
    }
}
