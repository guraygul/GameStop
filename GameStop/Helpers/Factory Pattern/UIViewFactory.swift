//
//  UIViewFactory.swift
//  CoinCo
//
//  Created by Güray Gül on 9.05.2024.
//

import UIKit

final class UIViewFactory {
    private let view: UIView
    
    // MARK: - Inits
    init() {
        view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
    }
    
    // MARK: - Public methods
    func clipsToBounds(_ clipsToBounds: Bool) -> Self {
        view.clipsToBounds = clipsToBounds
        return self
    }
    
    func backgroundColor(_ color: UIColor) -> Self {
        view.backgroundColor = color
        return self
    }
    
    func cornerRadius(_ radius: CGFloat) -> Self {
        view.layer.cornerRadius = radius
        return self
    }
    
    func maskedCorners(_ cornerOne: CACornerMask, _ cornerTwo: CACornerMask) -> Self {
        view.layer.maskedCorners = [cornerOne, cornerTwo]
        return self
    }
    
    func borderWidth(_ width: CGFloat) -> Self {
        view.layer.borderWidth = width
        return self
    }
    
    func borderColor(_ color: UIColor) -> Self {
        view.layer.borderColor = color.cgColor
        return self
    }
    
    func shadowOpacity(_ opacity: Float) -> Self {
        view.layer.shadowOpacity = opacity
        return self
    }
    
    func shadowOffset(_ offset: CGSize) -> Self {
        view.layer.shadowOffset = offset
        return self
    }
    
    func shadowColor(_ color: UIColor) -> Self {
        view.layer.shadowColor = color.cgColor
        return self
    }
    
    func shadowRadius(_ radius: CGFloat) -> Self {
        view.layer.shadowRadius = radius
        return self
    }
    
    func build() -> UIView {
        return view
    }
}
