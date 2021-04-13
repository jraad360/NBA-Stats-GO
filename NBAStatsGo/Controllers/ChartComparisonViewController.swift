//
//  ChartComparisonViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

class ChartComparisonViewController: UIViewController {
    
    // Currently selected player 1 for comparison
    var firstPlayer: Player?

    // Currently selected player 2 for comparison
    var secondPlayer: Player?
    
    // Currently selected player 1 career averages
    var firstPlayerCareerStats: PlayerSeasonAverageStats?
    
    // Currently selected player 2 career averages
    var secondPlayerCareerStats: PlayerSeasonAverageStats?
    
    // Adjusted Frame Width Boolean Array
    var tableCellAdjustedBoolean = [Bool](repeating: false, count:19)
    
    // Adjusted Frame Width Double Array
    var tableCellAdjustedWidth = [CGFloat](repeating: 0.0, count:19)

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
    }
}
