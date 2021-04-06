//
//  SearchTableViewControllerExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/6/21.
//

import UIKit
import MessageUI

extension SearchTableViewController {
    // Number of Sections for table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return players.count
    }
    
    // Number of rows in a particular section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players[section].count
    }
    
    // Rendering of a generic UITableViewCell based on DukePeopleCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player: Player = players[indexPath.section][indexPath.row]
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = player.lastName + ", " + player.firstName
        cell.detailTextLabel?.text = ">"
        return cell
    }
    
    // Headers for each section within the table view
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = SectionHeaderLabel()
        let startingValue = Int(("A" as UnicodeScalar).value) // 65
        sectionHeader.text = String(UnicodeScalar(section + startingValue)!)
        sectionHeader.backgroundColor = UIColor.systemGray2
        sectionHeader.font = UIFont(name: "Courier", size: 16)
        return sectionHeader
    }
    
    // Segue transition when selecting a table cell at a specific row
    // TO-DO: Handle case where you only want to "select" someone for statlines/player comparison
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currViewedPlayer = players[indexPath.section][indexPath.row]
        performSegue(withIdentifier: "viewPlayerStats", sender: indexPath)
    }
}
