//
//  Player.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation
import SwiftyJSON

struct Player: Comparable, Codable {
    static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.getLastFirstNames() < rhs.getLastFirstNames()
    }
    
    func getLastFirstNames() -> String {
        // based on assumption that player will have at least one name
        if lastName == "" {
            return firstName
        } else if firstName == "" {
            return lastName
        } else {
            return "\(lastName), \(firstName)"
        }
    }
    
    func getFirstLastNames() -> String {
        // based on assumption that player will have at least one name
        if lastName == "" {
            return firstName
        } else if firstName == "" {
            return lastName
        } else {
            return "\(firstName) \(lastName)"
        }
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.lastName == rhs.lastName && lhs.firstName == rhs.firstName
    }
    
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
        var height: String? = nil
        let heightFeet = json["height_feet"].int
        let heightInches = json["height_inches"].int
        if heightFeet != nil && heightFeet != nil {
            height = "\(heightFeet!)'\(heightInches!)\""
        }
        let position = json["position"].string == nil || json["position"].string == "" ? nil : json["position"].string
        self.init(
            id: json["id"].int!,
            firstName: json["first_name"].string!,
            lastName: json["last_name"].string!,
            position: position,
            height: height,
            weight: json["weight_pounds"].int,
            team: team)
    }
}
