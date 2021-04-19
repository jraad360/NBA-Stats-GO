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

    // Labels for the first and second player
    @IBOutlet weak var firstPlayerLabel: UILabel!
    @IBOutlet weak var secondPlayerLabel: UILabel!
    
    // ImageViews for the first and second player
    @IBOutlet weak var firstPlayerImageView: UIImageView!
    @IBOutlet weak var secondPlayerImageView: UIImageView!
    
    // Chart table view that facilitates displaying the stat comparison between the first and second player
    @IBOutlet weak var chartTableView: UITableView!
    
    // Setup the first and second player labels and the chart table view
    override func viewDidLoad() {
        super.viewDidLoad()
        initLabels()
        initImages()
        chartTableView.delegate = self
        chartTableView.dataSource = self
        chartTableView.tableFooterView = UIView()
        chartTableView.allowsSelection = false
    }
}
