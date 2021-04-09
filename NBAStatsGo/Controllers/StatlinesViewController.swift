//
//  StatlinesViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

class StatlinesViewController: UIViewController {

    @IBOutlet weak var statlineTableView: UITableView!
    @IBOutlet weak var statlineOutput: UILabel!
    @IBOutlet weak var statlineButton: UIButton!
    
    // Currently selected player for statlines
    var currStatlinesPlayer: Player?

    // Currently selected stat for statlines
    var currStat: StatCategory?
    
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
            // Insert API Call Here to get statline
            // Setup Loading Indicator
            // Write the statlineOutput
        }
        else {
            Alert.alert(title: "Cannot Get Statline", message: "Please make sure you have selected both a player and a stat before proceeding!", on: self)
        }
    }
    
    // Prepare for using the search table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "statlinesPlayer" {
                let searchTableController = segue.destination as! SearchTableViewController
                searchTableController.source = "Statlines"
            }
        }
    }
    
    @IBAction func returnFromSearchTable(segue: UIStoryboardSegue) {
    }
}
