//
//  StatCategory.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

enum StatCategory: String, CaseIterable, Codable {
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
