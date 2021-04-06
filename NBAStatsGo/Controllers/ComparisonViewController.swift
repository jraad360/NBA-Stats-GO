//
//  ComparisonViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

// Currently selected player 1 for comparison
var currCompareFirstPlayer: Player?

// Currently selected player 2 for comparison
var currCompareSecondPlayer: Player?

class ComparisonViewController: UIViewController {

    @IBOutlet weak var compareTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compareTableView.delegate = self
        compareTableView.dataSource = self
        compareTableView.tableFooterView = UIView()
    }
}
