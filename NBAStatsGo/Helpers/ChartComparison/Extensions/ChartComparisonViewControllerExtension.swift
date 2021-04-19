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
        var playerOneStat: Double = comparisonStatTranslation(careerAverages: firstPlayerCareerStats!, category: StatCategory.allCases[indexPath.row])
        var playerTwoStat: Double = comparisonStatTranslation(careerAverages: secondPlayerCareerStats!, category: StatCategory.allCases[indexPath.row])
        // set stats to 0 if they are NaN
        if playerOneStat.isNaN {
            playerOneStat = 0
        }
        if playerTwoStat.isNaN {
            playerTwoStat = 0
        }
        cell.playerOneStatLabel.text = playerOneStat.isNaN ? "0.0" : String(playerOneStat)
        cell.playerTwoStatLabel.text = playerTwoStat.isNaN ? "0.0" : String(playerTwoStat)
        cell.statName.text = StatCategory.allCases[indexPath.row].label
        cell.statBar.backgroundColor = .systemBlue
        var cellWidth = 0.0
        if (playerOneStat == 0 && playerTwoStat == 0) {
            cellWidth = 343 * 1/2
        } else if (playerOneStat.isNaN) {
            cellWidth = 0.0
        } else if (playerTwoStat.isNaN) {
            cellWidth = 343
        } else {
            cellWidth = 343 * playerOneStat / (playerOneStat + playerTwoStat)
        }
        if (!tableCellAdjustedBoolean[indexPath.row]) {
            let newFrame = CGRect(x: cell.adjustedStatBar.frame.origin.x, y: cell.adjustedStatBar.frame.origin.y, width: CGFloat(cellWidth), height: cell.adjustedStatBar.frame.size.height)
            tableCellAdjustedBoolean[indexPath.row] = true
            tableCellAdjustedWidth[indexPath.row] = (playerOneStat + playerTwoStat) == 0 ?
                343 * CGFloat(0.5) :
                (343 * CGFloat(playerOneStat) / (CGFloat(playerOneStat) + CGFloat(playerTwoStat)))
            cell.adjustedStatBar.frame = newFrame
        } else {
            cell.adjustedStatBar.frame.size.width = tableCellAdjustedWidth[indexPath.row]
        }
        return cell
    }
    
    // Sets the height for each row at 55
    func tableView(_ tableView: UITableView, heightForRowAt indexPath:  IndexPath) -> CGFloat {
        return 55
    }
    
    // Gets the stat value corresponding to the label displayed for each stat category
    func comparisonStatTranslation(careerAverages: PlayerSeasonAverageStats, category: StatCategory) -> Double  {
        switch (category.label) {
        case "Minutes":
            return careerAverages.min.rounded2()
        case "Points":
            return careerAverages.pts.rounded2()
        case "Assists":
            return careerAverages.ast.rounded2()
        case "Rebounds":
            return careerAverages.reb.rounded2()
        case "Defensive Rebounds":
            return careerAverages.dreb.rounded2()
        case "Offensive Rebounds":
            return careerAverages.oreb.rounded2()
        case "Steals":
            return careerAverages.stl.rounded2()
        case "Block":
            return careerAverages.blk.rounded2()
        case "Field Goals Attempted":
            return careerAverages.fga.rounded2()
        case "Field Goals Made":
            return careerAverages.fgm.rounded2()
        case "Field Goal Percentage":
            return careerAverages.fgpct.rounded2(toPlaces: 3)
        case "3-Point Field Goals Attempted":
            return careerAverages.fg3a.rounded2()
        case "3-Point Field Goals Made":
            return careerAverages.fg3m.rounded2()
        case "3-Point Field Goal Percentage":
            return careerAverages.fg3pct.rounded2(toPlaces: 3)
        case "Free Throws Attempted":
            return careerAverages.fta.rounded2()
        case "Free Throws Made":
            return careerAverages.ftm.rounded2()
        case "Free Throw Percentage":
            return careerAverages.ftpct.rounded2(toPlaces: 3)
        case "Turnovers":
            return careerAverages.turnover.rounded2()
        case "Personal Fouls":
            return careerAverages.pf.rounded2()
        default:
            return careerAverages.pf.rounded2()
        }
    }
}
