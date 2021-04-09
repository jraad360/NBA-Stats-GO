//
//  StatCategory.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

enum StatCategory: String, CaseIterable {
    case min = "Minutes"
    case pts = "Points"
    case ast = "Assists"
    case reb = "Rebounds"
    case dreb = "Defensive Rebounds"
    case oreb = "Offensive Rebounds"
    case stl = "Steals"
    case blk = "Block"
    case fga = "Field Goals Attempted"
    case fgm = "Field Goals Made"
    case fgpct = "Field Goal Percentage"
    case fg3a = "3-Point Field Goals Attempted"
    case fg3m = "3-Point Field Goals Made"
    case fg3pct = "3-Point Field Goal Percentage"
    case fta = "Free Throws Attempted"
    case ftm = "Free Throws Made"
    case ftpct = "Free Throw Percentage"
    case turnover = "Turnovers"
    case pf = "Personal Fouls"
}
