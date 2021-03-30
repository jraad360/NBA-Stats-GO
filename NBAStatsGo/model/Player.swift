//
//  Player.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

struct Player {
    let firstName: String
    let lastName: String
    let position: String?
    let height: String?
    let weight: Int?
    let team: Team
    
    init(firstName: String, lastName: String, position: String?, height: String?, weight: Int?, team: Team) {
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.height = height
        self.weight = weight
        self.team = team
    }
}
