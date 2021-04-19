//
//  HomeViewControllerExtension.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 4/19/21.
//

import UIKit

extension HomeViewController {

    func createTeamLogosView() -> UIView {
        let numTeams = 30
        let margin = 20
        let imageViewWidth = 80
        
        let view = UIView(frame:
                            CGRect(x: 0,
                                   y: Int(teamLogosView.frame.minY),
                                   width: (numTeams + 4)*(imageViewWidth + margin),
                                   height: imageViewWidth + 2*margin))
        for i in 1...34 {
            let teamView = UIImageView(frame:
                                    CGRect(x: (i - 1)*(imageViewWidth + margin),
                                           y: margin,
                                           width: imageViewWidth,
                                           height: imageViewWidth))
            let teamId = i < 31 ? i : i - 30
            teamView.image = UIImage(named: String(teamId))
            view.addSubview(teamView)
        }
        UIView.animate(withDuration: 60, delay: 0,
                       options: [.repeat, .curveLinear], animations: {
                                view.frame.origin.x -= view.frame.width*30/34
                })
        view.backgroundColor = UIColor(red: 19/255, green: 51/255, blue: 99/255, alpha: 1.0)
        return view
    }
}
