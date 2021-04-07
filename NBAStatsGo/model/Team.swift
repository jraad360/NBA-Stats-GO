//
//  Team.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation
import SwiftyJSON

struct Team {
    let abbreviation: String
    let city: String
    let conference: String
    let division: String
    let fullName: String
    let name: String
    
    init(abbreviation: String, city: String, conference: String, division: String, fullName: String, name: String) {
        self.abbreviation = abbreviation
        self.city = city
        self.conference = conference
        self.division = division
        self.fullName = fullName
        self.name = name
    }
    
    init(json: JSON) throws {
        self.init(
            abbreviation: json["abbreviation"].string!,
            city: json["city"].string!,
            conference: json["conference"].string!,
            division: json["division"].string!,
            fullName: json["full_name"].string!,
            name: json["name"].string!)
    }
}
