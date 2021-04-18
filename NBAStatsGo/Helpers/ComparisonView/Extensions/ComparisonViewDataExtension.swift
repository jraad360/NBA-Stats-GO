//
//  ComparisonViewDataExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/17/21.
//

import UIKit

extension ComparisonViewController {
    
    // Function corresponding to getting career stats data from the API for both players
    // Steps include:
    // Displaying progress view + Disabling other components in the view while loading
    // Getting first player's career data
    // Getting second player's career data after a short wait time
    // Renabling the other components + Removing the progress view
    func getComparisonData() {
        DispatchQueue.global(qos: .utility).async {
            do {

                DispatchQueue.main.async {
                    self.displayProgressView(currView: self.view)
                    self.changeEnabledSettings(enabled: false)
                }
                let firstPlayerStats = try self.statsManager.getCareerStats(for: self.currCompareFirstPlayer!)
                self.firstPlayerCareerStats = PlayerSeasonAverageStats(seasons: firstPlayerStats)
                
            } catch {
                print(error)
                Alert.alert(title: "Error Getting Career Stats for Comparison", message: error.localizedDescription, on: self)
                DispatchQueue.main.async {
                    currViewProgress!.removeFromSuperview()
                    currViewProgress = nil
                    self.changeEnabledSettings(enabled: true)
                }
            }

        }
        
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 40.0) {
            do {
                
                let secondPlayerStats = try self.statsManager.getCareerStats(for: self.currCompareSecondPlayer!)
                self.secondPlayerCareerStats = PlayerSeasonAverageStats(seasons: secondPlayerStats)
                
                DispatchQueue.main.async {
                    currViewProgress!.removeFromSuperview()
                    currViewProgress = nil
                    self.changeEnabledSettings(enabled: true)
                    self.performSegue(withIdentifier: "viewPlayerComparison", sender: self)
                }
                
            } catch {
                print(error)
                Alert.alert(title: "Error Getting Career Stats for Comparison", message: error.localizedDescription, on: self)
                DispatchQueue.main.async {
                    currViewProgress!.removeFromSuperview()
                    currViewProgress = nil
                    self.changeEnabledSettings(enabled: true)
                }
            }
        }
    }
    
    // Helper Function to either enable or disable the subviews within the comparison view
    // If something is currently in operation/loading the subviews will be disabled, otherwise the subviews will be enabled
    func changeEnabledSettings(enabled: Bool) {
        self.compareTableView.isUserInteractionEnabled = enabled
        self.tabBarController?.tabBar.isUserInteractionEnabled = enabled
        self.compareButton.isUserInteractionEnabled = enabled
    }
}
