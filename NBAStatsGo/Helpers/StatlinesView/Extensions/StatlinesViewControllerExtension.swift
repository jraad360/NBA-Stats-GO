//
//  StatlinesViewControllerExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/6/21.
//

import UIKit

extension StatlinesViewController: UITableViewDelegate, UITableViewDataSource {
    // Number of Sections for table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows in a particular section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // Rendering of a generic UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        if (indexPath.row == 0) {
            cell.textLabel?.text = "Player"
            cell.detailTextLabel?.text = (currStatlinesPlayer == nil ? "Select Player" : currStatlinesPlayer!.lastName + ", " + currStatlinesPlayer!.firstName)
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel?.text = "Stat"
            cell.detailTextLabel?.text = (currStat == nil ? "Select Stat" : currStat!.rawValue)
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    // Segue transition to the tableview to select a player OR open a picker view for stats
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Go to Player Selection Window
        if (indexPath.row == 0) {
            performSegue(withIdentifier: "statlinesPlayer", sender: indexPath)
        } else {
            statPicker?.isHidden = false
        }
    }
}
