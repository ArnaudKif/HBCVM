//
//  ExtensionVC.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import UIKit

extension UIViewController {
    /// Create an alert with a personalized message
    func createAlert(message: String) {
        let alertVC = UIAlertController(title: "Attention !", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
