//
//  StatCategory.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

/**
 The StatCategory enum is used to refer to a statistical category. It is used when attempting to retrieve a particular statistical category from a JSON object or when trying to specify what statistical category to calculate a player's career high for
 */
enum StatCategory: String, CaseIterable, Codable {
    
    /// The raw values are equal to the JSON keys for each stat category in the way they appear in the JSON returned by the API
    case min
    case pts
    case ast
    case reb
    case dreb
    case oreb
    case stl
    case blk
    case fga
    case fgm
    case fgpct = "fg_pct"
    case fg3a
    case fg3m
    case fg3pct = "fg3_pct"
    case fta
    case ftm
    case ftpct = "ft_pct"
    case turnover
    case pf
    
    /// This computed property returns the full title for stat category. This can be used to determine what text to display for a stat category on the front-end.
    var label: String {
        switch self {
        case .min:
            return "Minutes"
        case .pts:
            return "Points"
        case .ast:
            return "Assists"
        case .reb:
            return "Rebounds"
        case .dreb:
            return "Defensive Rebounds"
        case .oreb:
            return "Offensive Rebounds"
        case .stl:
            return "Steals"
        case .blk:
            return "Blocks"
        case .fga:
            return "Field Goals Attempted"
        case .fgm:
            return "Field Goals Made"
        case .fgpct:
            return "Field Goal Percentage"
        case .fg3a:
            return "3-Point Field Goals Attempted"
        case .fg3m:
            return "3-Point Field Goals Made"
        case .fg3pct:
            return "3-Point Field Goal Percentage"
        case .fta:
            return "Free Throws Attempted"
        case .ftm:
            return "Free Throws Made"
        case .ftpct:
            return "Free Throw Percentage"
        case .turnover:
            return "Turnovers"
        case .pf:
            return "Personal Fouls"
        }
    }
}
