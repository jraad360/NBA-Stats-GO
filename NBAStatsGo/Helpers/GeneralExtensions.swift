//
//  GeneralExtensions.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/13/21.
//

import UIKit

// Global View for the Progress View
var currViewProgress: UIView?

// Global Variable for the Progress View itself
var currProgress: UIProgressView?

extension UIViewController {
    
    // Show Progress View Function when loading data from API requests
    // Progress View includes progress bar + loading label in the center of the screen
    func displayProgressView(currView: UIView) {
        let overlay = UIView(frame: CGRect(x: currView.bounds.origin.x + 20, y: currView.frame.size.height / 2 - 80, width: currView.bounds.width - 40, height: 80))
        let finalOverlay = displayProgressHelper(tempView: overlay)
        currView.addSubview(finalOverlay)
        currView.bringSubviewToFront(finalOverlay)
        currViewProgress = finalOverlay
    }
    
    // Show Progress View Function for a tableview specifically when loading data from API requests
    // Progress View includes progress bar + loading label in the center of the screen
    func displayProgressTableView(currView: UITableView) {
        let overlay = UIView(frame: CGRect(x: currView.contentOffset.x + currView.bounds.origin.x + 20, y: currView.contentOffset.y + currView.frame.size.height / 2 - 80, width: currView.bounds.width - 40, height: 80))
        let finalOverlay = displayProgressHelper(tempView: overlay)
        currView.addSubview(finalOverlay)
        currView.bringSubviewToFront(finalOverlay)
        currViewProgress = finalOverlay
    }
    
    // Helper function that includes the steps of progress view that are the same for both a UIView and UITableView
    func displayProgressHelper(tempView: UIView) -> UIView {
        let overlay: UIView = tempView
        overlay.backgroundColor = .systemGray5
        overlay.layer.borderWidth = 1
        overlay.layer.borderColor = UIColor.black.cgColor
        overlay.layer.cornerRadius = 10
        let loadingLabel = UILabel()
        loadingLabel.frame = CGRect(x: overlay.frame.size.width, y: 0, width: overlay.frame.size.width - 40, height: 30)
        loadingLabel.text = "Loading... Please Wait"
        loadingLabel.center = CGPoint(x: overlay.frame.size.width / 2 + 70,
                                      y: overlay.frame.size.height / 2 - 10)
        currProgress = UIProgressView()
        currProgress!.frame = CGRect(x: 0, y: 0, width: overlay.frame.size.width - 40, height: 20)
        currProgress!.center = CGPoint(x: overlay.frame.size.width  / 2,
                                       y: overlay.frame.size.height / 2 + 10)
        currProgress!.progress = 0.0
        overlay.addSubview(loadingLabel)
        overlay.addSubview(currProgress!)
        return overlay
    }
}

extension Double {
    // Rounds the double to decimal places value
    func rounded2(toPlaces places:Int = 1) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
