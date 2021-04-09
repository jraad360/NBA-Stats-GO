//
//  Initializers.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/30/21.
//

import UIKit

// Initializers for Table Components including:
// Search Bar
extension SearchTableViewController: UISearchBarDelegate {
    
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
        // Replace hardcoded line with the lines below once API call is made
//        firstPlayerLabel.text = firstPlayer!.firstName + " " + firstPlayer!.lastName
//        secondPlayerLabel.text = secondPlayer!.firstName + " " + secondPlayer!.lastName
        firstPlayerLabel.text = "Giannis Antetokounmpo"
        secondPlayerLabel.text = "Lebron James"
        
        firstPlayerLabel.numberOfLines = 0
        secondPlayerLabel.numberOfLines = 0
    }
}
