//
//  PlayerSeasonAverageStats.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation
import SwiftyJSON

struct PlayerSeasonAverageStats: Codable {
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
        var season = String(json["season"].int ?? 0)
        let nextYear = (Int(season) ?? 0) + 1
        season += "-\(nextYear)"
        
        self.init(
            playerId: json["player_id"].int ?? 0,
//            team: try Team(json: json["team"]),
            season: season,
            gp: json["games_played"].int ?? 0,
            min: PlayerSeasonAverageStats.convertMinutesToDouble(json["min"].string ?? "0:0"),
            pts: json["pts"].double ?? 0.0,
            ast: json["ast"].double ?? 0.0,
            reb: json["reb"].double ?? 0.0,
            dreb: json["dreb"].double ?? 0.0,
            oreb: json["oreb"].double ?? 0.0,
            stl: json["stl"].double ?? 0.0,
            blk: json["blk"].double ?? 0.0,
            fga: json["fga"].double ?? 0.0,
            fgm: json["fgm"].double ?? 0.0,
            fgpct: json["fg_pct"].double ?? 0.0,
            fg3a: json["fg3a"].double ?? 0.0,
            fg3m: json["fg3m"].double ?? 0.0,
            fg3pct: json["fg3_pct"].double ?? 0.0,
            fta: json["fta"].double ?? 0.0,
            ftm: json["ftm"].double ?? 0.0,
            ftpct: json["ft_pct"].double ?? 0.0,
            turnover: json["turnover"].double ?? 0.0,
            pf: json["pf"].double ?? 0.0)
    }
    
    init(seasons: [PlayerSeasonAverageStats]) {
        
        self.playerId =  seasons.count == 0 ? 0 : seasons[0].playerId
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

        self.min = totalGp == 0 ? 0.0 : totalMin / Double(totalGp)
        self.pts = totalGp == 0 ? 0.0 : totalPts / Double(totalGp)
        self.ast = totalGp == 0 ? 0.0 : totalAst / Double(totalGp)
        self.reb = totalGp == 0 ? 0.0 : totalReb / Double(totalGp)
        self.dreb = totalGp == 0 ? 0.0 : totalDreb / Double(totalGp)
        self.oreb = totalGp == 0 ? 0.0 : totalOreb / Double(totalGp)
        self.stl = totalGp == 0 ? 0.0 : totalStl / Double(totalGp)
        self.blk = totalGp == 0 ? 0.0 : totalBlk / Double(totalGp)
        self.fga = totalGp == 0 ? 0.0 : totalFga / Double(totalGp)
        self.fgm = totalGp == 0 ? 0.0 : totalFgm / Double(totalGp)
        self.fg3a = totalGp == 0 ? 0.0 : totalFg3a / Double(totalGp)
        self.fg3m = totalGp == 0 ? 0.0 : totalFg3m / Double(totalGp)
        self.fta = totalGp == 0 ? 0.0 : totalFta / Double(totalGp)
        self.ftm = totalGp == 0 ? 0.0 : totalFtm / Double(totalGp)
        self.turnover = totalGp == 0 ? 0.0 : totalTurnover / Double(totalGp)
        self.pf = totalGp == 0 ? 0.0 : totalPf / Double(totalGp)
        
        self.fgpct = totalFga == 0.0 ? 0.0 : totalFgm / totalFga
        self.fg3pct = totalFg3a == 0.0 ? 0.0 : totalFg3m / totalFg3a
        self.ftpct = totalFta == 0.0 ? 0.0 : totalFtm / totalFta
        
    }
    
    // TODO: move somewhere else
    static func convertMinutesToDouble(_ minuteString: String) -> Double {
        let components = minuteString.components(separatedBy: ":")
        
        let minutes = Int(components[0]) ?? 0
        let seconds = Int(components[1]) ?? 0
        
        return Double(minutes) + Double(seconds)/60
    }
    
}
