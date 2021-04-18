//
//  StatlinesViewDataExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/17/21.
//

import UIKit

extension StatlinesViewController {
    
    // Function corresponding to getting statlines data from the API
    // Steps include:
    // Displaying progress view + Disabling other components in the view while loading
    // Getting statline data from the API
    // Renabling the other components + Removing the progress view
    func getStatlinesData() {
        DispatchQueue.global(qos: .utility).async {
            do {

                DispatchQueue.main.async {
                    self.displayProgressView(currView: self.view)
                    self.changeEnabledSettings(enabled: false)
                }
                
                let careerHighValue = try self.statsManager.getCareerHigh(for: self.currStatlinesPlayer!, in: self.currStat!)
                let regular = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
                let bold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
                let regularText = NSAttributedString(string: self.currStatlinesPlayer!.getFirstLastNames() + "\'s career high in " + self.currStat!.label + " is ", attributes: regular)
                let boldText = NSAttributedString(string: careerHighValue, attributes: bold)
                let statlineText = NSMutableAttributedString()
                statlineText.append(regularText)
                statlineText.append(boldText)

                DispatchQueue.main.async {
                    currViewProgress!.removeFromSuperview()
                    currViewProgress = nil
                    self.statlineOutput.attributedText = statlineText
                    self.statlineOutput.sizeToFit()
                    self.changeEnabledSettings(enabled: true)
                }
            } catch {
                print(error)
                Alert.alert(title: "Error Getting Statline", message: error.localizedDescription, on: self)
                DispatchQueue.main.async {
                    currViewProgress!.removeFromSuperview()
                    currViewProgress = nil
                    self.changeEnabledSettings(enabled: true)
                }
            }
        }
    }
    
    // Helper Function to either enable or disable the subviews within the statlines view
    // If something is currently in operation/loading the subviews will be disabled, otherwise the subviews will be enabled
    func changeEnabledSettings(enabled: Bool) {
        self.statlineTableView.isUserInteractionEnabled = enabled
        self.statlineButton.isUserInteractionEnabled = enabled
        self.tabBarController?.tabBar.isUserInteractionEnabled = enabled
    }
}
