//
//  PlayerGameStats.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation
import SwiftyJSON

struct PlayerGameStats {
    let player: Player
    let team: Team
    let game: Game

    let min: Int
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
    
    init(
        player: Player,
        team: Team,
        game: Game,
        min: Int,
        pts: Int,
        ast: Int,
        reb: Int,
        dreb: Int,
        oreb: Int,
        stl: Int,
        blk: Int,
        fga: Int,
        fgm: Int,
        fgpct: Double,
        fg3a: Int,
        fg3m: Int,
        fg3pct: Double,
        fta: Int,
        ftm: Int,
        ftpct: Double,
        turnover: Int,
        pf: Int) {
        
        self.player = player
        self.team = team
        self.game = game

        self.min = min
        self.pts = pts
        self.ast = ast
        self.reb = reb
        self.dreb = dreb
        self.oreb = oreb
        self.stl = stl
        self.blk = blk
        self.fga = fga
        self.fgm = fgm
        self.fgpct = fgpct
        self.fg3a = fg3a
        self.fg3m = fg3m
        self.fg3pct = fg3pct
        self.fta = fta
        self.ftm = ftm
        self.ftpct = ftpct
        self.turnover = turnover
        self.pf = pf
    }
    
    init(json: JSON) throws {
        let min = json["min"].string != nil ? Int(json["min"].string!.split(separator: ":")[0])! : 0
        self.init(
            player: try Player(json: json["player"]),
            team: try Team(json: json["team"]),
            game: try Game(json: json["game"]),
            min: min,
            pts: json["pts"].int ?? 0,
            ast: json["ast"].int ?? 0,
            reb: json["reb"].int ?? 0,
            dreb: json["dreb"].int ?? 0,
            oreb: json["oreb"].int ?? 0,
            stl: json["stl"].int ?? 0,
            blk: json["blk"].int ?? 0,
            fga: json["fga"].int ?? 0,
            fgm: json["fgm"].int ?? 0,
            fgpct: json["fg_pct"].double ?? 0.0,
            fg3a: json["fg3a"].int ?? 0,
            fg3m: json["fg3m"].int ?? 0,
            fg3pct: json["fg3_pct"].double ?? 0.0,
            fta: json["fta"].int ?? 0,
            ftm: json["ftm"].int ?? 0,
            ftpct: json["ft_pct"].double ?? 0.0,
            turnover: json["turnover"].int ?? 0,
            pf: json["pf"].int ?? 0)
    }
}
