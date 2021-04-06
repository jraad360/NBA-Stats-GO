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
