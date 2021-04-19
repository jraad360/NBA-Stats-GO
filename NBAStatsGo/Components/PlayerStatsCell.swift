//
//  PlayerStatsCell.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/16/21.
//

import UIKit
import SpreadsheetView

// Subclass of Cell (concept from SpreadsheetView) used to represent a single season player stat in the player stats view which contains one label
// Background color + Bold + Font Size changes based on if the cell corresponds to a header cell
// Layout label to fill the entire cell
// Identifier used for reusing cells purpose
class PlayerStatsCell: Cell {
    
    private let label = UILabel()
    
    static let identifier = "PlayerStatsCell"
    
    public func initCell(text: String, header: Bool) {
        label.text = text
        if (header) {
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
            label.textColor = .white
            self.backgroundColor = UIColor(red: 68/255, green: 92/255, blue: 124/255, alpha: 1.0)
            
        } else {
            label.font = UIFont.systemFont(ofSize: 14.0)
            self.backgroundColor = .white
        }
        label.textAlignment = .center
        contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
}
