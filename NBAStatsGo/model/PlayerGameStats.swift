//
//  PlayerGameStats.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

struct PlayerGameStats {
    let player: Player
    let team: Team
    let game: Game

    let min: TimeInterval
    let pts: Int
    let ast: Int
    let reb: Int
    let dreb: Int
    let oreb: Int
    let stl: Int
    let blk: Int
    let fga: Int
    let fgm: Int
    let fgpct: Double
    let fg3a: Int
    let fg3m: Int
    let fg3pct: Double
    let fta: Int
    let ftm: Int
    let ftpct: Double
    let turnover: Int
    let pf: Int

}
