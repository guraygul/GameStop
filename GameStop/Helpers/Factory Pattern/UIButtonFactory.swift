//
//  UIButtonFactory.swift
//  GameStop
//
//  Created by Güray Gül on 21.05.2024.
//
import UIKit

final class UIButtonFactory {
    private let button: UIButton
    
    // MARK: - Inits
    init(type: UIButton.ButtonType = .system) {
        button = UIButton(type: type)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Public methods
    func title(_ title: String, for state: UIControl.State = .normal) -> Self {
        button.setTitle(title, for: state)
        return self
    }
    
    func titleColor(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        button.setTitleColor(color, for: state)
        return self
    }
    
    func backgroundColor(_ color: UIColor) -> Self {
        button.backgroundColor = color
        return self
    }
    
    func cornerRadius(_ radius: CGFloat) -> Self {
        button.layer.cornerRadius = radius
        return self
    }
    
    func maskedCorners(_ cornerOne: CACornerMask, _ cornerTwo: CACornerMask) -> Self {
        button.layer.maskedCorners = [cornerOne, cornerTwo]
        return self
    }
    
    func borderWidth(_ width: CGFloat) -> Self {
        button.layer.borderWidth = width
        return self
    }
    
    func borderColor(_ color: UIColor) -> Self {
        button.layer.borderColor = color.cgColor
        return self
    }
    
    func font(_ font: UIFont) -> Self {
        button.titleLabel?.font = font
        return self
    }
    
    func image(_ image: UIImage?, for state: UIControl.State = .normal) -> Self {
        button.setImage(image, for: state)
        return self
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Self {
        button.addTarget(target, action: action, for: controlEvents)
        return self
    }
    
    func build() -> UIButton {
        return button
    }
}
