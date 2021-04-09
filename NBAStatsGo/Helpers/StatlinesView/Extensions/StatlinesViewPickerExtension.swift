//
//  StatlinesViewPickerExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/9/21.
//

import UIKit

let stats: [String] = StatCategory.allCases.map { $0.rawValue }

extension StatlinesViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    // Sets number of components needed for picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets number of rows needed for picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stats.count
    }
    
    // Sets the appropriate title for each picker row based on degrees array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stats[row]
    }

    // Assigns chosen picker value to the appropriate degree variables and closes the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currStat = StatCategory(rawValue: stats[row])
        pickerView.isHidden = true
        statlineTableView.reloadData()
    }
}
