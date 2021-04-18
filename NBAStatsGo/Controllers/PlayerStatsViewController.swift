//
//  PlayerStatsViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit
import SpreadsheetView

class PlayerStatsViewController: UIViewController {
    
    // Currently viewed player
    var currViewedPlayer: Player?
    
    // Currently viewed player season-by-season averages
    var currViewedSeasonAvgs: [PlayerSeasonAverageStats]?
    
    // Currently viewed player career averages
    var currViewedCareerAvgs: PlayerSeasonAverageStats?

    // Labels displaying a piece of info in the player stats view
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerHeight: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerWeight: UILabel!
    @IBOutlet weak var careerStats: UIView!
    @IBOutlet weak var careerStatsHeader: UIView!
    @IBOutlet weak var careerStatsLabel: UILabel!
    @IBOutlet weak var careerAvgPts: UILabel!
    @IBOutlet weak var careerAvgRebs: UILabel!
    @IBOutlet weak var careerAvgAsts: UILabel!
    @IBOutlet weak var careerAvgBlks: UILabel!
    @IBOutlet weak var careerAvgStls: UILabel!
    
    // SpreadsheetView that displays season-by-season averages
    @IBOutlet weak var seasonSpreadsheet: SpreadsheetView!
    
    // Setup includes:
    // Player labels, Career Stats labels, Career Stats View, Spreadsheet View
    override func viewDidLoad() {
        super.viewDidLoad()
        initPlayerLabels()
        careerStatsLabel.center = careerStatsHeader.center
        careerStats.layer.borderWidth = 1
        careerStats.layer.borderColor = UIColor.black.cgColor
        careerStatsHeader.layer.borderWidth = 1
        careerStatsHeader.layer.borderColor = UIColor.black.cgColor
        initCareerLabels()
        seasonSpreadsheet.register(PlayerStatsCell.self, forCellWithReuseIdentifier: PlayerStatsCell.identifier)
        seasonSpreadsheet.delegate = self
        seasonSpreadsheet.dataSource = self
        let spreadsheetHeight = seasonSpreadsheet.frame.height
        if (spreadsheetHeight > CGFloat((currViewedSeasonAvgs!.count + 1) * 32)) {
            seasonSpreadsheet.frame = CGRect(x: seasonSpreadsheet.frame.origin.x, y: seasonSpreadsheet.frame.origin.y, width: seasonSpreadsheet.frame.width, height: CGFloat((currViewedSeasonAvgs!.count + 1) * 32))
        }
    }

}
