//
//  StatlinesViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

class StatlinesViewController: UIViewController {

    @IBOutlet weak var statlineTableView: UITableView!
    @IBOutlet weak var statlineOutput: UILabel!
    @IBOutlet weak var statlineButton: UIButton!
    @IBOutlet weak var statPicker: UIPickerView!
    
    // Initialize API Manager
    let statsManager = StatsManager()
    
    // Currently selected player for statlines
    var currStatlinesPlayer: Player?

    // Currently selected stat for statlines
    var currStat: StatCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statlineTableView.delegate = self
        statlineTableView.dataSource = self
        statlineTableView.tableFooterView = UIView()
        statPicker.delegate = self
        statPicker.dataSource = self
        statPicker?.isHidden = true
        view.addSubview(statPicker!)
    }
    
    @IBAction func clickStatlinesButton(_ sender: Any) {
        statPicker?.isHidden = true
        let playerIndex = IndexPath(row: 0, section: 0)
        let statIndex = IndexPath(row: 1, section: 0)
        let playerCell: UITableViewCell = self.statlineTableView.cellForRow(at: playerIndex)!
        let statCell: UITableViewCell = self.statlineTableView.cellForRow(at: statIndex)!
        let playerText = playerCell.detailTextLabel?.text
        let statText = statCell.detailTextLabel?.text
        if (playerText != "Select Player" && statText != "Select Stat") {
            DispatchQueue.global(qos: .utility).async {
                do {
    
                    DispatchQueue.main.async {
                        self.displayProgressView(currView: self.view)
                        self.statlineTableView.isUserInteractionEnabled = false
                        self.statlineButton.isUserInteractionEnabled = false
                        self.tabBarController?.tabBar.isUserInteractionEnabled = false
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
                        self.statlineButton.isUserInteractionEnabled = true
                        self.statlineTableView.isUserInteractionEnabled = true
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    }
                } catch {
                    print(error)
                    Alert.alert(title: "Error Getting Statline", message: error.localizedDescription, on: self)
                    DispatchQueue.main.async {
                        currViewProgress!.removeFromSuperview()
                        currViewProgress = nil
                        self.statlineTableView.isUserInteractionEnabled = true
                        self.statlineButton.isUserInteractionEnabled = true
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    }
                }
    
            }
        }
        else {
            Alert.alert(title: "Cannot Get Statline", message: "Please make sure you have selected both a player and a stat before proceeding!", on: self)
        }
    }
    
    // Prepare for using the search table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "statlinesPlayer" {
                let searchTableController = segue.destination as! SearchTableViewController
                searchTableController.source = "Statlines"
            }
        }
    }
    
    // Reload data when returning from search table
    @IBAction func statlineReturnFromSearchTable(segue: UIStoryboardSegue) {
        statlineTableView.reloadData()
    }
}
