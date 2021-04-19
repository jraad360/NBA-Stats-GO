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
        searchBar.barTintColor = UIColor(red: 255/255, green: 102/255, blue: 0/255, alpha: 1.0)
        searchBar.searchTextField.backgroundColor = .white
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
    
    // Initialize Images
    func initImages() {
        firstPlayerImageView.image = firstPlayer!.team.getTeamImage() ?? UIImage(named: "nba")
        secondPlayerImageView.image = secondPlayer!.team.getTeamImage() ?? UIImage(named: "nba")
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
    
    // Initialize Career Stats View Labels
    func initCareerLabels() {
        careerAvgPts.text = String(currViewedCareerAvgs!.pts.rounded2())
        careerAvgRebs.text = String(currViewedCareerAvgs!.reb.rounded2())
        careerAvgAsts.text = String(currViewedCareerAvgs!.ast.rounded2())
        careerAvgBlks.text = String(currViewedCareerAvgs!.blk.rounded2())
        careerAvgStls.text = String(currViewedCareerAvgs!.stl.rounded2())
    }
}
