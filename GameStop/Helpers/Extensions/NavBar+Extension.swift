//
//  NavBar+Extension.swift
//  GameStop
//
//  Created by Güray Gül on 23.05.2024.
//

import UIKit

extension UIViewController {
    func leftNavigationBar(backgroundColor: UIColor = Theme.yellowColor) {
        let offset = UIOffset(horizontal: -CGFloat.greatestFiniteMagnitude, vertical: 0)
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: Theme.yellowColor]
        appearance.backgroundColor = backgroundColor
        appearance.backgroundEffect = nil
        appearance.titlePositionAdjustment = offset
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.hideHairline()
        navigationController?.hidesBarsOnSwipe = true
        
        navigationItem.titleView = nil
    }
    
    func setNavigationBarItemsColor(_ color: UIColor) {
        navigationController?.navigationBar.tintColor = color
    }
    
    func setBackBarButtonItemTitleToEmpty() {
        let backItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
    
    func showNavigationBarOnScrollUp(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

extension UINavigationController {
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}
