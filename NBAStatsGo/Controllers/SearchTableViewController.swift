//
//  SearchTableViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

var APICaller: BallDontLieAPIManager = BallDontLieAPIManager()

class SearchTableViewController: UITableViewController {
    
    // Search Bar
    var playerSearchBar: UISearchBar?

    // NBA Players
    var players = [[Player]]()
    
    // Global Player List
    var allPlayers = [Player]()
    
    // Selected Player from table
    var selectedPlayer: Player?
    
    // How Search Table was called - default (tab bar is "Tab"), "Statlines", "Comparison"
    var source: String? = "Tab"

    override func viewDidLoad() {
        super.viewDidLoad()
        playerSearchBar = initSearchBar()
        allPlayers = try! APICaller.getPlayers(filters: ["name": ""])
        transformData(transformingPlayers: allPlayers)
        // Setup loading indicator
        // API Call to get all players here
        // Dismiss loading indicator
    }
    
    // Prepare for various segue options including:
    // Going to individual player stats view (PlayerStatsViewController)
    // Unwind to statlines view (StatlinesViewController)
    // Unwind to comparison view (ComparisonViewController)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "viewPlayerStats" {
                let playerStatsViewController = segue.destination as! PlayerStatsViewController
                playerStatsViewController.currViewedPlayer = selectedPlayer
            } else if identifier == "statlinesSearch" {
                let statlinesViewController = segue.destination as! StatlinesViewController
                statlinesViewController.currStatlinesPlayer = selectedPlayer
            } else if identifier == "comparisonSearch" {
                let comparisonViewController = segue.destination as! ComparisonViewController
                if (source == "ComparisonOne") {
                    comparisonViewController.currCompareFirstPlayer = selectedPlayer
                } else if (source == "ComparisonTwo") {
                    comparisonViewController.currCompareSecondPlayer = selectedPlayer
                }
            }
        }
    }
    
    func transformData(transformingPlayers: [Player]) {
        for player in transformingPlayers {
            let lastNameInitial = player.lastName.prefix(1)
            print(lastNameInitial)
        }
    }
}
