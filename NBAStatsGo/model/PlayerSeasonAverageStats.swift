//
//  PlayerSeasonAverageStats.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation
import SwiftyJSON

struct PlayerSeasonAverageStats {
    let playerId: Int
//    let team: Team
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
        playerId: Int,
//        team: Team,
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
        
        self.playerId = playerId
//        self.team = team
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
        var season = String(json["season"].int!)
        let nextYear = Int(season)! + 1
        season += "-\(nextYear)"
        
        self.init(
            playerId: json["player_id"].int!,
//            team: try Team(json: json["team"]),
            season: season,
            gp: json["games_played"].int!,
            min: PlayerSeasonAverageStats.convertMinutesToDouble(json["min"].string!),
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
    
    init(seasons: [PlayerSeasonAverageStats]) {
        
        self.playerId = seasons[0].playerId
        self.season = "Career"

        var totalGp = 0
        var totalMin = 0.0
        var totalPts = 0.0
        var totalAst = 0.0
        var totalReb = 0.0
        var totalDreb = 0.0
        var totalOreb = 0.0
        var totalStl = 0.0
        var totalBlk = 0.0
        var totalFga = 0.0
        var totalFgm = 0.0
        var totalFg3a = 0.0
        var totalFg3m = 0.0
        var totalFta = 0.0
        var totalFtm = 0.0
        var totalTurnover = 0.0
        var totalPf = 0.0
        
        for season in seasons {
            totalGp += season.gp
            totalMin += season.min * Double(season.gp)
            totalPts += season.pts * Double(season.gp)
            totalAst += season.ast * Double(season.gp)
            totalReb += season.reb * Double(season.gp)
            totalDreb += season.dreb * Double(season.gp)
            totalOreb += season.oreb * Double(season.gp)
            totalStl += season.stl * Double(season.gp)
            totalBlk += season.blk * Double(season.gp)
            totalFga += season.fga * Double(season.gp)
            totalFgm += season.fgm * Double(season.gp)
            totalFg3a += season.fg3a * Double(season.gp)
            totalFg3m += season.fg3m * Double(season.gp)
            totalFta += season.fta * Double(season.gp)
            totalFtm += season.ftm * Double(season.gp)
            totalTurnover += season.turnover * Double(season.gp)
            totalPf += season.pf * Double(season.gp)
        }
        
        self.gp = totalGp

        self.min = totalMin / Double(totalGp)
        self.pts = totalPts / Double(totalGp)
        self.ast = totalAst / Double(totalGp)
        self.reb = totalReb / Double(totalGp)
        self.dreb = totalDreb / Double(totalGp)
        self.oreb = totalOreb / Double(totalGp)
        self.stl = totalStl / Double(totalGp)
        self.blk = totalBlk / Double(totalGp)
        self.fga = totalFga / Double(totalGp)
        self.fgm = totalFgm / Double(totalGp)
        self.fg3a = totalFg3a / Double(totalGp)
        self.fg3m = totalFg3m / Double(totalGp)
        self.fta = totalFta / Double(totalGp)
        self.ftm = totalFtm / Double(totalGp)
        self.turnover = totalTurnover / Double(totalGp)
        self.pf = totalPf / Double(totalGp)
        
        self.fgpct = totalFgm / totalFga
        self.fg3pct = totalFg3m / totalFg3a
        self.ftpct = totalFtm / totalFta
        
    }
    
    // TODO: move somewhere else
    static func convertMinutesToDouble(_ minuteString: String) -> Double {
        let components = minuteString.components(separatedBy: ":")
        
        let minutes = Int(components[0])!
        let seconds = Int(components[1])!
        
        return Double(minutes) + Double(seconds)/60
    }
    
}
