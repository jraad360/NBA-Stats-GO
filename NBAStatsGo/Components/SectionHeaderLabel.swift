//
//  SectionHeaderLabel.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/6/21.
//

import UIKit

// Subclass to add Left Side Padding for labels (needed for section headers)
class SectionHeaderLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
