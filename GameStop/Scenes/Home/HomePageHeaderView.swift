//
//  HomePageHeaderView.swift
//  GameStop
//
//  Created by Güray Gül on 23.05.2024.
//

import UIKit

final class HomePageHeaderView: UICollectionReusableView {
    static let identifier = "HomePageHeaderView"
    
    private let homePageViewController = HomePageViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHomePageViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHomePageViewController() {
        homePageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(homePageViewController.view)
        
        NSLayoutConstraint.activate([
            homePageViewController.view.topAnchor.constraint(equalTo: topAnchor),
            homePageViewController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            homePageViewController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            homePageViewController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with games: [Result]) {
        homePageViewController.games = games
    }
}
