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
            // API Call Here to get statline
            // Setup Loading Indicator
            // Write the statlineOutput
        }
        else {
            // Apply this to the previous if statement when API Call is ready
            let regular = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
            let bold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
            // Change this to be Player/Stat/Numeric specific
            let regularText = NSAttributedString(string: "Giannis Antetokounmpo's career high in rebounds is ", attributes: regular)
            let boldText = NSAttributedString(string: "35", attributes: bold)
            let statlineText = NSMutableAttributedString()
            statlineText.append(regularText)
            statlineText.append(boldText)
            statlineOutput.attributedText = statlineText
            statlineOutput.sizeToFit()
            // Uncomment this when API is ready
//            Alert.alert(title: "Cannot Get Statline", message: "Please make sure you have selected both a player and a stat before proceeding!", on: self)
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
