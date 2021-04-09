//
//  ComparisonViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

class ComparisonViewController: UIViewController {
    
    // Currently selected player 1 for comparison
    var currCompareFirstPlayer: Player?

    // Currently selected player 2 for comparison
    var currCompareSecondPlayer: Player?

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
            performSegue(withIdentifier: "viewPlayerComparison", sender: self)
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
            }
        }
    }
}
