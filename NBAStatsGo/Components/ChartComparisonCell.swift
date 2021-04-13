//
//  ChartComparisonCell.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/9/21.
//

import UIKit

// Subclass of UITableViewCell used to represent a stat in the player comparison view with two number labels, stat label, and horizontal bar
class ChartComparisonCell: UITableViewCell {
    
    @IBOutlet weak var playerOneStatLabel: UILabel!
    @IBOutlet weak var playerTwoStatLabel: UILabel!
    @IBOutlet weak var statName: UILabel!
    @IBOutlet weak var statBar: UIView!
    @IBOutlet weak var adjustedStatBar: UIView!
}
