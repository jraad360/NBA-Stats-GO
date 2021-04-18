//
//  SearchTableViewLoadingExtension.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/17/21.
//

import UIKit

extension SearchTableViewController {
    
    // Function corresponding to refresh action - loading data from API
    // Steps include:
    // Displaying progress view + Disabling other components in the view while loading
    // Getting player data from the API
    // Renabling the other components + Removing the progress view
    func loadDataFromAPI(searchParams: String) {
        DispatchQueue.global(qos: .utility).async {
            do {
                
                DispatchQueue.main.async {
                    self.displayProgressView(currView: self.view)
                    self.changeEnabledSettings(enabled: false)
                }
                
                allPlayers = try self.statsManager.getPlayers(filters:["name": ""])
                if (searchParams == "") {
                    self.transformData(transformingPlayers: allPlayers)
                } else {
                    self.transformIntermediateStep(searchParams: searchParams)
                }
                
                DispatchQueue.main.async {
                    currViewProgress!.removeFromSuperview()
                    currViewProgress = nil
                    self.tableView.reloadData()
                    self.changeEnabledSettings(enabled: true)
                }
            } catch {
                print(error)
                Alert.alert(title: "Error Getting Players", message: error.localizedDescription, on: self)
                DispatchQueue.main.async {
                    currViewProgress!.removeFromSuperview()
                    currViewProgress = nil
                    self.changeEnabledSettings(enabled: true)
                }
            }
        }
    }
    
    // Function corresponding to loading initial data - either from file or persisted data
    // Steps include:
    // Displaying progress view + Disabling other components in the view while loading
    // Getting player data from the file or persisted data
    // Renabling the other components + Removing the progress view
    func initialLoadData() {
        DispatchQueue.global(qos: .utility).async {
            do {
                DispatchQueue.main.async {
                    self.displayProgressView(currView: self.view)
                    self.changeEnabledSettings(enabled: false)
                }
                
                if (allPlayers.count > 0) {
                    self.transformData(transformingPlayers: allPlayers)
                } else {
                    allPlayers = try self.statsManager.getPlayersFromFile()
                    self.transformData(transformingPlayers: allPlayers)
                }
                
                DispatchQueue.main.async {
                    currViewProgress!.removeFromSuperview()
                    currViewProgress = nil
                    self.tableView.reloadData()
                    self.changeEnabledSettings(enabled: true)
                }
            } catch {
                print(error)
                Alert.alert(title: "Error Getting Players", message: error.localizedDescription, on: self)
                DispatchQueue.main.async {
                    currViewProgress!.removeFromSuperview()
                    currViewProgress = nil
                    self.changeEnabledSettings(enabled: true)
                }
            }
        }
    }
    
    // Helper Function to either enable or disable the subviews within the search table
    // If something is currently in operation/loading the subviews will be disabled, otherwise the subviews will be enabled
    func changeEnabledSettings(enabled: Bool) {
        self.tableView.isUserInteractionEnabled = enabled
        self.playerSearchBar!.isUserInteractionEnabled = enabled
        self.tabBarController?.tabBar.isUserInteractionEnabled = enabled
        self.refreshButton.isEnabled = enabled
    }
}
