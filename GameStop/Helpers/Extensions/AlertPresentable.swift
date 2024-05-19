//
//  AlertPresentable.swift
//  GameStop
//
//  Created by Güray Gül on 19.05.2024.
//

import UIKit

protocol AlertPresentable {
    func showAlert(title: String,
                   message: String)
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String,
                   message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
