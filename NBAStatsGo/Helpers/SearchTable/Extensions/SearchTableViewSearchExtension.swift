//
//  SearchTableViewSearchExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/17/21.
//

import UIKit

extension SearchTableViewController: UISearchBarDelegate {
    
    // Searching based on whenever the search text changes
    // Search text applies to first name and last name
    // Case is not sensitive (Uppercase/Lowercase treated the same)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // If search text is empty, just return all NBA Players
        // Otherwise, check if search text applies to the relevant fields
        searchString = searchText
        if searchText == "" {
            filteredPlayers = [Player]()
            transformData(transformingPlayers: allPlayers)
        }
        else {
            filteredPlayers = [Player]()
            for player in allPlayers {
                if player.getFirstLastNames().lowercased().contains(searchText.lowercased()) || player.getLastFirstNames().lowercased().contains(searchText.lowercased()) {
                    filteredPlayers.append(player)
                }
            }
            transformData(transformingPlayers: filteredPlayers)
        }
        tableView.reloadData()
    }
    
    // Dismiss the search bar when table view is being touched/dragged
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        playerSearchBar!.endEditing(true)
    }
        
    // Dismiss the search bar keyboard if "Search" is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        playerSearchBar!.endEditing(true)
    }
}
