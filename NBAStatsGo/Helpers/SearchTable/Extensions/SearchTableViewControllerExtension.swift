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
        cell.textLabel?.text = player.getLastFirstNames()
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 237/255, alpha: 1.0)
        return cell
    }
    
    // Headers for each section within the table view
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (players[section].count == 0) {
            return nil
        }
        let sectionHeader = SectionHeaderLabel()
        let startingValue = Int(("A" as UnicodeScalar).value) // 65
        sectionHeader.text = String(UnicodeScalar(section + startingValue)!)
        sectionHeader.backgroundColor = UIColor.systemYellow
        sectionHeader.font = UIFont(name: "Courier", size: 16)
        return sectionHeader
    }
    
    // Alphabetical index to navigate between sections
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       return ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
   }
    
    // Segue transition when selecting a table cell at a specific row in three cases
    // Segue to Player Stats View (PlayerStatsViewController)
    // Renabling the other components + Removing the progress view
    // Unwind to Statlines View (StatlinesViewController)
    // Unwind to Comparison View (ComparisonViewController)
    
    // Steps to Player Stats View include:
    // Displaying progress view + Disabling other components in the view while loading
    // Getting player stats data from the API
    // Renabling the other components + Removing the progress view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlayer = players[indexPath.section][indexPath.row]
        if (source == "Tab") {
            DispatchQueue.global(qos: .utility).async {
                do {
                    DispatchQueue.main.async {
                        self.displayProgressView(currView: self.view)
                        self.changeEnabledSettings(enabled: false)
                    }
                    
                    self.selectedPlayerSeasonAvgs = try self.statsManager.getCareerStats(for: self.players[indexPath.section][indexPath.row])
                    self.selectedPlayerCareerAvgs = PlayerSeasonAverageStats(seasons: self.selectedPlayerSeasonAvgs!)

                    DispatchQueue.main.async {
                        currViewProgress!.removeFromSuperview()
                        currViewProgress = nil
                        self.changeEnabledSettings(enabled: true)
                        self.performSegue(withIdentifier: "viewPlayerStats", sender: indexPath)
                    }
                    
                } catch {
                    print(error)
                    Alert.alert(title: "Error Getting Player Stats", message: error.localizedDescription, on: self)
                    DispatchQueue.main.async {
                        currViewProgress!.removeFromSuperview()
                        currViewProgress = nil
                        self.changeEnabledSettings(enabled: true)
                    }
                }

            }
        } else if (source == "Statlines") {
            performSegue(withIdentifier: "statlinesSearch", sender: indexPath)
        } else if (source == "ComparisonOne" || source == "ComparisonTwo") {
            performSegue(withIdentifier: "comparisonSearch", sender: indexPath)
        }
    }
    
    // Set height of a section header to 0 if there are no players for that section, otherwise set it to 30
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (players[section].count == 0) {
            return 0
        }
        return 30
    }
}
