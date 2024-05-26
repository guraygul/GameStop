//
//  Theme.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import UIKit

class Theme {
    static let backgroundColor = UIColor(
        red: 31/255,
        green: 31/255,
        blue: 31/255,
        alpha: 1.0
    )
    
    static let tintColor = UIColor(
        red: 199/255,
        green: 200/255,
        blue: 204/255,
        alpha: 1.0
    )
    
    static let blackColor = UIColor(
        red: 0/255,
        green: 0/255,
        blue: 0/255,
        alpha: 1.0
    )
    
    static let whiteColor = UIColor(
        red: 1.0,
        green: 1.0,
        blue: 1.0,
        alpha: 1.0
    )
    
    static let yellowColor = UIColor(
        red: 255/255,
        green: 204/255,
        blue: 0/255,
        alpha: 1.0
    )
    
    static func gradientLayer(for view: UIView) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 11/255, green: 11/255, blue: 11/255, alpha: 1.0).cgColor,
            UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0).cgColor
        ]
        return gradientLayer
    }
}
