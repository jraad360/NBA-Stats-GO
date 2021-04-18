//
//  PlayerStatsSpreadsheetViewExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/16/21.
//

import UIKit
import SpreadsheetView

extension PlayerStatsViewController: SpreadsheetViewDataSource, SpreadsheetViewDelegate {
    
    // Set the cell to be a PlayerStatsCell with text based on whether cell is...
    // A header cell - predefined column names
    // A data cell - based on the appropriate season and stat category
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: PlayerStatsCell.identifier, for: indexPath) as! PlayerStatsCell
        var text = ""
        if (indexPath.row == 0) {
            text = getHeaderText(column: indexPath.section)
        } else {
            text = getStatText(column: indexPath.section, row: indexPath.row - 1)
        }
        cell.initCell(text: text, header: indexPath.row == 0)
        return cell
    }
    
    // Make the first column (season) slightly wider (80) to accomodate more text
    // All other columns are data so width only needs to be 50
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if (column == 0) {
            return 80
        }
        return 50
    }
    
    // Each row has a height of 30
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow column: Int) -> CGFloat {
        30
    }
    
    // Total of 21 columns corresponding to each of the appropriate 21 stat categories
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        21
    }
    
    // Number of rows based on number of seasons played + header row
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        currViewedSeasonAvgs!.count + 1
    }
    
    // Season column is frozen
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    // Return the appropriate column name based on column number
    func getHeaderText(column: Int) -> String {
        switch (column) {
        case 0:
            return "Season"
        case 1:
            return "GP"
        case 2:
            return "MIN"
        case 3:
            return "PTS"
        case 4:
            return "OREB"
        case 5:
            return "DREB"
        case 6:
            return "REB"
        case 7:
            return "AST"
        case 8:
            return "STL"
        case 9:
            return "BLK"
        case 10:
            return "FGM"
        case 11:
            return "FGA"
        case 12:
            return "FG%"
        case 13:
            return "3PM"
        case 14:
            return "3PA"
        case 15:
            return "3P%"
        case 16:
            return "FTM"
        case 17:
            return "FTA"
        case 18:
            return "FT%"
        case 19:
            return "TO"
        case 20:
            return "PF"
        default:
            return "N/A"
        }
    }
    
    // Return the appropriate data stat based on row and column number
    func getStatText(column: Int, row: Int) -> String {
        switch (column) {
        case 0:
            return currViewedSeasonAvgs![row].season
        case 1:
            return String(currViewedSeasonAvgs![row].gp)
        case 2:
            return String(currViewedSeasonAvgs![row].min)
        case 3:
            return String(currViewedSeasonAvgs![row].pts)
        case 4:
            return String(currViewedSeasonAvgs![row].oreb)
        case 5:
            return String(currViewedSeasonAvgs![row].dreb)
        case 6:
            return String(currViewedSeasonAvgs![row].reb)
        case 7:
            return String(currViewedSeasonAvgs![row].ast)
        case 8:
            return String(currViewedSeasonAvgs![row].stl)
        case 9:
            return String(currViewedSeasonAvgs![row].blk)
        case 10:
            return String(currViewedSeasonAvgs![row].fgm)
        case 11:
            return String(currViewedSeasonAvgs![row].fga)
        case 12:
            return String(currViewedSeasonAvgs![row].fgpct)
        case 13:
            return String(currViewedSeasonAvgs![row].fg3m)
        case 14:
            return String(currViewedSeasonAvgs![row].fg3a)
        case 15:
            return String(currViewedSeasonAvgs![row].fg3pct)
        case 16:
            return String(currViewedSeasonAvgs![row].ftm)
        case 17:
            return String(currViewedSeasonAvgs![row].fta)
        case 18:
            return String(currViewedSeasonAvgs![row].ftpct)
        case 19:
            return String(currViewedSeasonAvgs![row].turnover)
        case 20:
            return String(currViewedSeasonAvgs![row].pf)
        default:
            return "N/A"
        }
    }
}
