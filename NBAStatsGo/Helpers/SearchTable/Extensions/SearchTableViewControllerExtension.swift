//
//  SearchTableViewControllerExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/6/21.
//

import UIKit

extension SearchTableViewController {
    // Number of Sections for table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return players.count
    }
    
    // Number of rows in a particular section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players[section].count
    }
    
    // Rendering of a generic UITableViewCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player: Player = players[indexPath.section][indexPath.row]
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = player.lastName + ", " + player.firstName
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
    
    // Alphabetical index to navigate between sections
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       return ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
   }
    
    // Segue transition when selecting a table cell at a specific row in three cases
    // Segue to Player Stats View (PlayerStatsViewController)
    // Unwind to Statlines View (StatlinesViewController)
    // Unwind to Comparison View (ComparisonViewController)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlayer = players[indexPath.section][indexPath.row]
        if (source == "Tab") {
            performSegue(withIdentifier: "viewPlayerStats", sender: indexPath)
        } else if (source == "Statlines") {
            performSegue(withIdentifier: "statlinesSearch", sender: indexPath)
        } else if (source == "ComparisonOne" || source == "ComparisonTwo") {
            performSegue(withIdentifier: "comparisonSearch", sender: indexPath)
        }
    }
}
