//
//  StatlinesViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

class StatlinesViewController: UIViewController {

    // Statline Table View
    @IBOutlet weak var statlineTableView: UITableView!
    
    // Statline Output Text
    @IBOutlet weak var statlineOutput: UILabel!
    
    // Statline Action Button
    @IBOutlet weak var statlineButton: UIButton!
    
    // Statline Picker View for stat categories
    @IBOutlet weak var statPicker: UIPickerView!
    
    // Initialize Stats Manager
    let statsManager = StatsManager()
    
    // Currently selected player for statlines
    var currStatlinesPlayer: Player?

    // Currently selected stat for statlines
    var currStat: StatCategory?
    
    // Setup statline table view and statline picker
    override func viewDidLoad() {
        super.viewDidLoad()
        statlineTableView.delegate = self
        statlineTableView.dataSource = self
        statlineTableView.tableFooterView = UIView()
        statPicker.delegate = self
        statPicker.dataSource = self
        statPicker?.isHidden = true
        view.addSubview(statPicker!)
    }
    
    // Action to find the career high based on a player and stat category
    // Only find the career high if both a valid player and stat category is selected
    // Otherwise display an alert
    @IBAction func clickStatlinesButton(_ sender: Any) {
        statPicker?.isHidden = true
        let playerIndex = IndexPath(row: 0, section: 0)
        let statIndex = IndexPath(row: 1, section: 0)
        let playerCell: UITableViewCell = self.statlineTableView.cellForRow(at: playerIndex)!
        let statCell: UITableViewCell = self.statlineTableView.cellForRow(at: statIndex)!
        let playerText = playerCell.detailTextLabel?.text
        let statText = statCell.detailTextLabel?.text
        if (playerText != "Select Player" && statText != "Select Stat") {
            getStatlinesData()
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
    
    // Reload data when returning from search table
    @IBAction func statlineReturnFromSearchTable(segue: UIStoryboardSegue) {
        statlineTableView.reloadData()
    }
}
