//
//  GeneralExtensions.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/13/21.
//

import UIKit

// Global View for the Spinner
var currViewSpinner: UIView?

extension UIViewController {
    
    // Show Spinner Function when loading data from API requests
    func displaySpinner(currView: UIView) {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        let overlay = UIView(frame: currView.bounds)
        spinner.center = overlay.center
        overlay.addSubview(spinner)
        currView.addSubview(overlay)
        currViewSpinner = overlay
    }
}