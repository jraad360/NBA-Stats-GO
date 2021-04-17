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
    @IBOutlet weak var seasonSpreadsheet: SpreadsheetView!
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
