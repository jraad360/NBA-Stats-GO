//
//  Initializers.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/30/21.
//

import UIKit

// Initializers for Table Components including:
// Search Bar
extension SearchTableViewController {
    
    // Initialize Search Bar
    func initSearchBar() -> (UISearchBar) {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 50.0)
        searchBar.placeholder = "Search NBA Player"
        tableView.tableHeaderView = searchBar
        return searchBar
    }
}

// Initializers for Player Comparison Components including:
// Player Labels
extension ChartComparisonViewController {
    
    // Initialize Labels
    func initLabels() {
        firstPlayerLabel.text = firstPlayer!.getFirstLastNames()
        secondPlayerLabel.text = secondPlayer!.getFirstLastNames()
        firstPlayerLabel.numberOfLines = 0
        secondPlayerLabel.numberOfLines = 0
    }
}

// Initializers for Individual Player Stats Components including:
// Player Labels
extension PlayerStatsViewController {
    
    // Initialize Labels
    func initPlayerLabels() {
        playerName.text = currViewedPlayer!.getFirstLastNames()
        playerName.numberOfLines = 0
        playerHeight.text = "Height: " + (currViewedPlayer!.height ?? "N/A")
        playerPosition.text = "Position: " + (currViewedPlayer!.position ?? "N/A")
        let weight = currViewedPlayer!.weight ?? 0
        if (weight == 0) {
            playerWeight.text = "Weight: N/A"
        } else {
            playerWeight.text = "Weight: " + String(weight)
        }
    }
    
    func initCareerLabels() {
        careerAvgPts.text = String(currViewedCareerAvgs!.pts)
        careerAvgRebs.text = String(currViewedCareerAvgs!.reb)
        careerAvgAsts.text = String(currViewedCareerAvgs!.ast)
        careerAvgBlks.text = String(currViewedCareerAvgs!.blk)
        careerAvgStls.text = String(currViewedCareerAvgs!.stl)
    }
}
