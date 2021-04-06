//
//  StatlinesViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

// Currently selected player for statlines
var currStatlinesPlayer: Player?

// Currently selected stat for statlines
var currStat: StatCategory?

class StatlinesViewController: UIViewController {

    @IBOutlet weak var statlineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statlineTableView.delegate = self
        statlineTableView.dataSource = self
        statlineTableView.tableFooterView = UIView()
    }
}
