//
//  PlayerStatsSpreadsheetViewExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/16/21.
//

import UIKit
import SpreadsheetView

extension PlayerStatsViewController: SpreadsheetViewDataSource, SpreadsheetViewDelegate {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: PlayerStatsCell.identifier, for: indexPath) as! PlayerStatsCell
        cell.initCell(text: "Hello", header: indexPath.row == 0)
        return cell
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if (column == 0) {
            return 75
        }
        return 50
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow column: Int) -> CGFloat {
        30
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        21
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        currViewedSeasonAvgs!.count + 1
    }
    
    
}
