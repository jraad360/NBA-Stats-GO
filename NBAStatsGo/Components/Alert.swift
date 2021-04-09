//
//  Alert.swift
//  NBAStatsGo
//
//  Created by David Liu on 4/8/21.
//

import UIKit

struct Alert {
    static func alert(title: String, message: String, on vc: UIViewController) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        controller.addAction(dismissAction)
        DispatchQueue.main.async {
            vc.present(controller, animated: true, completion: nil)
        }
    }
}
