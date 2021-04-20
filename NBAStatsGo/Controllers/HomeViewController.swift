//
//  HomeViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/6/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var teamLogosView: UIView!
    var animatedLogos: UIView? = nil
    
    // Setup the home controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if animatedLogos != nil {
            animatedLogos!.removeFromSuperview()
        }
        animatedLogos = createTeamLogosView()
        view.addSubview(animatedLogos!)
    }
}
