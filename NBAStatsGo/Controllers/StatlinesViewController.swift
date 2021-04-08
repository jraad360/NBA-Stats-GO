//
//  StatlinesViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

// Currently selected player for statlines
var currStatlinesPlayer: Player?

// Currently selected stat for statlines
var currStat: StatCategory?

class StatlinesViewController: UIViewController {

    @IBOutlet weak var statlineTableView: UITableView!
    @IBOutlet weak var statlineOutput: UILabel!
    @IBOutlet weak var statlineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statlineTableView.delegate = self
        statlineTableView.dataSource = self
        statlineTableView.tableFooterView = UIView()
    }
    
    @IBAction func clickStatlinesButton(_ sender: Any) {
        let playerIndex = IndexPath(row: 0, section: 0)
        let statIndex = IndexPath(row: 1, section: 0)
        let playerCell: UITableViewCell = self.statlineTableView.cellForRow(at: playerIndex)!
        let statCell: UITableViewCell = self.statlineTableView.cellForRow(at: statIndex)!
        let playerText = playerCell.detailTextLabel?.text
        let statText = statCell.detailTextLabel?.text
        if (playerText != "Select Player" && statText != "Select Stat") {
            // Insert API Call Here
            // Setup Loading Indicator
        }
        else {
            Alert.alert(title: "Cannot Get Statline", message: "Please make sure you have selected both a player and a stat before proceeding!", on: self)
        }
    }
}
