//
//  ComparisonViewControllerExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/6/21.
//

import UIKit

extension ComparisonViewController: UITableViewDelegate, UITableViewDataSource {
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
            cell.textLabel?.text = "Player 1"
            cell.detailTextLabel?.text = (currCompareFirstPlayer == nil ? "Select Player" : currCompareFirstPlayer!.lastName + ", " + currCompareFirstPlayer!.firstName)
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel?.text = "Player 2"
            cell.detailTextLabel?.text = (currCompareSecondPlayer == nil ? "Select Player" : currCompareSecondPlayer!.lastName + ", " + currCompareSecondPlayer!.firstName)
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    // Segue transition to the tableview to select a player
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Go to Player Selection Window for player 1 or player 2
        if (indexPath.row == 0) {
            performSegue(withIdentifier: "comparisonPlayerOne", sender: indexPath)
        } else {
            performSegue(withIdentifier: "comparisonPlayerTwo", sender: indexPath)
        }
    }
}
