//
//  ChartComparisonViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

class ChartComparisonViewController: UIViewController {
    
    // Initialize API Manager
    let apiManager: APIManager = BallDontLieAPIManager()
    
    // Currently selected player 1 for comparison
    var firstPlayer: Player?

    // Currently selected player 2 for comparison
    var secondPlayer: Player?

    @IBOutlet weak var firstPlayerLabel: UILabel!
    @IBOutlet weak var secondPlayerLabel: UILabel!
    @IBOutlet weak var chartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLabels()
        chartTableView.delegate = self
        chartTableView.dataSource = self
        chartTableView.tableFooterView = UIView()
        chartTableView.allowsSelection = false
//        DispatchQueue.global(qos: .utility).async {
//            do {
//
//                // TODO: start loading icon
//                self.allPlayers = try self.apiManager.getPlayers(filters:["name": ""])
//                self.transformData(transformingPlayers: self.allPlayers)
//
//                DispatchQueue.main.async {
//                    // TODO: stop loading icon
//                    self.tableView.reloadData()
//                }
//            } catch {
//                // TODO: display error message to user
//                print(error)
//            }
//
//        }
        // API Call Here to get stats for both players
        // Setup Loading Indicator
        // Display the player comparison
    }
}
