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
        self.init(
            player: try Player(json: json["player"]),
            team: try Team(json: json["team"]),
            game: try Game(json: json["game"]),
            min: json["min"].int!,
            pts: json["pts"].int!,
            ast: json["ast"].int!,
            reb: json["reb"].int!,
            dreb: json["dreb"].int!,
            oreb: json["oreb"].int!,
            stl: json["stl"].int!,
            blk: json["blk"].int!,
            fga: json["fga"].int!,
            fgm: json["fgm"].int!,
            fgpct: json["fg_pct"].double!,
            fg3a: json["fg3a"].int!,
            fg3m: json["fg3m"].int!,
            fg3pct: json["fg3_pct"].double!,
            fta: json["fta"].int!,
            ftm: json["ftm"].int!,
            ftpct: json["ft_pct"].double!,
            turnover: json["turnover"].int!,
            pf: json["pf"].int!)
    }
}
