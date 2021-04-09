//
//  ChartComparisonViewControllerExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/9/21.
//

import UIKit

extension ChartComparisonViewController: UITableViewDelegate, UITableViewDataSource {
    // Number of Sections for table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows in a particular section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StatCategory.allCases.count
    }
    
    // Rendering of a generic UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartStatCell", for: indexPath) as! ChartComparisonCell
        // Replace text below with text conversion of actual stats
        cell.playerOneStatLabel.text = "29.8"
        cell.playerTwoStatLabel.text = "31.8"
        cell.statName.text = StatCategory.allCases[indexPath.row].rawValue
        cell.statBar.backgroundColor = .systemBlue
        var newFrame = cell.adjustedStatBar.frame
        // Change this with calculation based on conversion of actual stats
        newFrame.size.width = cell.adjustedStatBar.frame.width * 29.8 / (29.8 + 31.8)
        cell.adjustedStatBar.frame = newFrame
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath:  IndexPath) -> CGFloat {
        return 55
    }
}
