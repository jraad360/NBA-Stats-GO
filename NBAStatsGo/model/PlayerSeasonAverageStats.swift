//
//  PlayerSeasonAverageStats.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation
import SwiftyJSON

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
    
    init(
        player: Player,
        team: Team,
        season: String,
        gp: Int,
        min: Double,
        pts: Double,
        ast: Double,
        reb: Double,
        dreb: Double,
        oreb: Double,
        stl: Double,
        blk: Double,
        fga: Double,
        fgm: Double,
        fgpct: Double,
        fg3a: Double,
        fg3m: Double,
        fg3pct: Double,
        fta: Double,
        ftm: Double,
        ftpct: Double,
        turnover: Double,
        pf: Double) {
        
        self.player = player
        self.team = team
        self.season = season
        self.gp = gp

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
        var season = json["season"].string!
        let nextYear = Int(season)! + 1
        season += "-\(nextYear)"
        
        self.init(
            player: try Player(json: json["player"]),
            team: try Team(json: json["team"]),
            season: season,
            gp: json["games_played"].int!,
            min: json["min"].double!,
            pts: json["pts"].double!,
            ast: json["ast"].double!,
            reb: json["reb"].double!,
            dreb: json["dreb"].double!,
            oreb: json["oreb"].double!,
            stl: json["stl"].double!,
            blk: json["blk"].double!,
            fga: json["fga"].double!,
            fgm: json["fgm"].double!,
            fgpct: json["fg_pct"].double!,
            fg3a: json["fg3a"].double!,
            fg3m: json["fg3m"].double!,
            fg3pct: json["fg3_pct"].double!,
            fta: json["fta"].double!,
            ftm: json["ftm"].double!,
            ftpct: json["ft_pct"].double!,
            turnover: json["turnover"].double!,
            pf: json["pf"].double!)
    }
}
