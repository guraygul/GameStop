//
//  SearchBar+Extension.swift
//  GameStop
//
//  Created by Güray Gül on 26.05.2024.
//

import UIKit

extension UISearchController {
    func applyCustomStyling(placeholder: String,
                            placeholderColor: UIColor,
                            backgroundColor: UIColor,
                            tintColor: UIColor) {
        self.obscuresBackgroundDuringPresentation = false
        self.searchBar.placeholder = placeholder
        
        if let searchTextField = self.searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
            searchTextField.leftView?.tintColor = placeholderColor
            searchTextField.backgroundColor = backgroundColor
        }
        self.searchBar.tintColor = tintColor
        self.searchBar.barTintColor = backgroundColor
        self.searchBar.barStyle = .black
    }
}
