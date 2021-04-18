//
//  SearchTableViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

// Global Player List
var allPlayers = [Player]()

class SearchTableViewController: UITableViewController {
    
    // Initialize Stats Manager
    let statsManager = StatsManager()
    
    // Search Bar
    var playerSearchBar: UISearchBar?

    // NBA Players
    var players = [[Player]]()
    
    // Filtered NBA Players
    var filteredPlayers = [Player]()
    
    // Selected Player from table
    var selectedPlayer: Player?
    
    // Selected Player season-by-season averages
    var selectedPlayerSeasonAvgs: [PlayerSeasonAverageStats]?
    
    // Selected Player career averages
    var selectedPlayerCareerAvgs: PlayerSeasonAverageStats?
    
    // How Search Table was called - default (tab bar is "Tab"), "Statlines", "Comparison"
    var source: String? = "Tab"
    
    // Search Text in the Search Bar
    var searchString: String? = ""

    // Refresh Button
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    // Function run on load - specifically setting up the search bar and loading player data
    override func viewDidLoad() {
        super.viewDidLoad()
        playerSearchBar = initSearchBar()
        initialLoadData()
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
                playerStatsViewController.currViewedSeasonAvgs = selectedPlayerSeasonAvgs
                playerStatsViewController.currViewedCareerAvgs = selectedPlayerCareerAvgs
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
    
    // Function when Refresh Button is pressed
    @IBAction func refreshPlayerData(_ sender: UIBarButtonItem) {
        loadDataFromAPI(searchParams: searchString ?? "")
    }
}
