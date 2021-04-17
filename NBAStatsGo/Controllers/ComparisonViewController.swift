//
//  ComparisonViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

class ComparisonViewController: UIViewController {
    
    // Initialize API Manager
    let statsManager = StatsManager()
    
    // Currently selected player 1 for comparison
    var currCompareFirstPlayer: Player?

    // Currently selected player 2 for comparison
    var currCompareSecondPlayer: Player?
    
    // Currently selected player 1 career averages
    var firstPlayerCareerStats: PlayerSeasonAverageStats?
    
    // Currently selected player 2 career averages
    var secondPlayerCareerStats: PlayerSeasonAverageStats?

    @IBOutlet weak var compareTableView: UITableView!
    @IBOutlet weak var compareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compareTableView.delegate = self
        compareTableView.dataSource = self
        compareTableView.tableFooterView = UIView()
    }
    
    @IBAction func clickCompareButton(_ sender: Any) {
        let playerOneIndex = IndexPath(row: 0, section: 0)
        let playerTwoIndex = IndexPath(row: 1, section: 0)
        let playerOneCell: UITableViewCell = self.compareTableView.cellForRow(at: playerOneIndex)!
        let playerTwoCell: UITableViewCell = self.compareTableView.cellForRow(at: playerTwoIndex)!
        let playerOneText = playerOneCell.detailTextLabel?.text
        let playerTwoText = playerTwoCell.detailTextLabel?.text
        if (playerOneText != "Select Player" && playerTwoText != "Select Player") {
            DispatchQueue.global(qos: .utility).async {
                do {

                    DispatchQueue.main.async {
                        self.displayProgressView(currView: self.view)
                    }
                    let firstPlayerStats = try self.statsManager.getCareerStats(for: self.currCompareFirstPlayer!)
                    self.firstPlayerCareerStats = PlayerSeasonAverageStats(seasons: firstPlayerStats)
                    
                } catch {
                    print(error)
                    Alert.alert(title: "Error Getting Career Stats for Comparison", message: error.localizedDescription, on: self)
                    DispatchQueue.main.async {
                        currViewProgress!.removeFromSuperview()
                        currViewProgress = nil
                    }
                }

            }
            
            DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 50.0) {
                do {
                    
                    let secondPlayerStats = try self.statsManager.getCareerStats(for: self.currCompareSecondPlayer!)
                    self.secondPlayerCareerStats = PlayerSeasonAverageStats(seasons: secondPlayerStats)
                    
                    DispatchQueue.main.async {
                        currViewProgress!.removeFromSuperview()
                        currViewProgress = nil
                        self.performSegue(withIdentifier: "viewPlayerComparison", sender: self)
                    }
                    
                } catch {
                    print(error)
                    Alert.alert(title: "Error Getting Career Stats for Comparison", message: error.localizedDescription, on: self)
                    DispatchQueue.main.async {
                        currViewProgress!.removeFromSuperview()
                        currViewProgress = nil
                    }
                }
            }
        }
        else {
            Alert.alert(title: "Cannot Get Player Comparison", message: "Please make sure you have selected two players before proceeding!", on: self)
        }
    }
    
    // Prepare for either
    // Using the search table (comparisonPlayerOne, comparisonPlayerTwo)
    // Going to chart comparison (viewPlayerComparison)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "comparisonPlayerOne" {
                let searchTableController = segue.destination as! SearchTableViewController
                searchTableController.source = "ComparisonOne"
            } else if identifier == "comparisonPlayerTwo" {
                let searchTableController = segue.destination as! SearchTableViewController
                searchTableController.source = "ComparisonTwo"
            } else if identifier == "viewPlayerComparison" {
                let chartComparisonController = segue.destination as! ChartComparisonViewController
                chartComparisonController.firstPlayer = currCompareFirstPlayer
                chartComparisonController.secondPlayer = currCompareSecondPlayer
                chartComparisonController.firstPlayerCareerStats = firstPlayerCareerStats
                chartComparisonController.secondPlayerCareerStats = secondPlayerCareerStats
            }
        }
    }
    
    // Reload data when returning from search table
    @IBAction func comparisonReturnFromSearchTable(segue: UIStoryboardSegue) {
        compareTableView.reloadData()
    }
}
