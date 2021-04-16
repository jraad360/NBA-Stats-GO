//
//  PlayerStatsCell.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/16/21.
//

import UIKit
import SpreadsheetView

class PlayerStatsCell: Cell {
    
    private let label = UILabel()
    
    static let identifier = "PlayerStatsCell"
    
    public func initCell(text: String, header: Bool) {
        label.text = text
        if (header) {
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
        } else {
            label.font = UIFont.systemFont(ofSize: 14.0)
        }
        label.textAlignment = .center
        contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
}
