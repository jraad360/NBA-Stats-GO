//
//  PlayerSeasonAverageStats.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

struct PlayerSeasonAverageStats {
    let player: Player
    let team: Team
    let season: String
    let gp: Int

    let min: Double
    let pts: Double
    let ast: Double
    let reb: Double
    let dreb: Double
    let oreb: Double
    let stl: Double
    let blk: Double
    let fga: Double
    let fgm: Double
    let fgpct: Double
    let fg3a: Double
    let fg3m: Double
    let fg3pct: Double
    let fta: Double
    let ftm: Double
    let ftpct: Double
    let turnover: Double
    let pf: Double
}
