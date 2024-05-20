//
//  AlertPresentable.swift
//  GameStop
//
//  Created by Güray Gül on 19.05.2024.
//

import UIKit

protocol AlertPresentable {
    func showAlert(title: String,
                   message: String,
                   openSettings: Bool?)
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String,
                   message: String,
                   openSettings: Bool? = false) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .cancel)
        
        if openSettings == true {
            let settingsAction = UIAlertAction(title: "Settings",
                                               style: .default) { _ in
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsURL) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
            alert.addAction(settingsAction)
        }
        
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
        
    }
}
