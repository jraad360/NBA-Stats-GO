//
//  HomeViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/6/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var teamLogosView: UIView!
    
    // Setup the home controller
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(createTeamLogosView())
        super.viewWillAppear(true)
    }
}
