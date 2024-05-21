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
                   openSettings: Bool?,
                   retryAction: (() -> Void)?)
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String,
                   message: String,
                   openSettings: Bool? = false,
                   retryAction: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        if let retryAction = retryAction {
            let retryAction = UIAlertAction(title: "Try Again", style: .default) { _ in
                retryAction()
            }
            alert.addAction(retryAction)
        } else {
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(okAction)
        }
        
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
        
        present(alert, animated: true, completion: nil)
    }
}
