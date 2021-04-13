//
//  ChartComparisonViewControllerExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/9/21.
//

import UIKit

extension ChartComparisonViewController: UITableViewDelegate, UITableViewDataSource {
    // Number of Sections for table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows in a particular section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StatCategory.allCases.count
    }
    
    // Rendering of a generic UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartStatCell", for: indexPath) as! ChartComparisonCell
        let playerOneStat: Double = comparisonStatTranslation(careerAverages: firstPlayerCareerStats!, category: StatCategory.allCases[indexPath.row])
        let playerTwoStat: Double = comparisonStatTranslation(careerAverages: secondPlayerCareerStats!, category: StatCategory.allCases[indexPath.row])
        cell.playerOneStatLabel.text = String(playerOneStat)
        cell.playerTwoStatLabel.text = String(playerTwoStat)
        cell.statName.text = StatCategory.allCases[indexPath.row].label
        cell.statBar.backgroundColor = .systemBlue
        if (!tableCellAdjustedBoolean[indexPath.row]) {
            let newFrame = CGRect(x: cell.adjustedStatBar.frame.origin.x, y: cell.adjustedStatBar.frame.origin.y, width: 343 * CGFloat(playerOneStat) / (CGFloat(playerOneStat) + CGFloat(playerTwoStat)), height: cell.adjustedStatBar.frame.size.height)
            tableCellAdjustedBoolean[indexPath.row] = true
            tableCellAdjustedWidth[indexPath.row] = 343 * CGFloat(playerOneStat) / (CGFloat(playerOneStat) + CGFloat(playerTwoStat))
            cell.adjustedStatBar.frame = newFrame
        } else {
            cell.adjustedStatBar.frame.size.width = tableCellAdjustedWidth[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath:  IndexPath) -> CGFloat {
        return 55
    }
    
    func comparisonStatTranslation(careerAverages: PlayerSeasonAverageStats, category: StatCategory) -> Double  {
        switch (category.label) {
        case "Minutes":
            return careerAverages.min
        case "Points":
            return careerAverages.pts
        case "Assists":
            return careerAverages.ast
        case "Rebounds":
            return careerAverages.reb
        case "Defensive Rebounds":
            return careerAverages.dreb
        case "Offensive Rebounds":
            return careerAverages.oreb
        case "Steals":
            return careerAverages.stl
        case "Block":
            return careerAverages.blk
        case "Field Goals Attempted":
            return careerAverages.fga
        case "Field Goals Made":
            return careerAverages.fgm
        case "Field Goal Percentage":
            return careerAverages.fgpct
        case "3-Point Field Goals Attempted":
            return careerAverages.fg3a
        case "3-Point Field Goals Made":
            return careerAverages.fg3m
        case "3-Point Field Goal Percentage":
            return careerAverages.fg3pct
        case "Free Throws Attempted":
            return careerAverages.fta
        case "Free Throws Made":
            return careerAverages.ftm
        case "Free Throw Percentage":
            return careerAverages.ftpct
        case "Turnovers":
            return careerAverages.turnover
        case "Personal Fouls":
            return careerAverages.pf
        default:
            return careerAverages.pf
        }
    }
}
