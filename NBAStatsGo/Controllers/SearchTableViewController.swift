//
//  SearchTableViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

// Search Bar
var playerSearchBar: UISearchBar?

// NBA Players
var players = [[Player]]()

// Currently viewed player
var currViewedPlayer: Player?

class SearchTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        playerSearchBar = initSearchBar()
    }
}
