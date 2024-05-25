//
//  TabBarViewController.swift
//  GameStop
//
//  Created by Güray Gül on 19.05.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {
    private lazy var homeViewController: UINavigationController = {
        let viewModel = HomeViewModel(networkService: NetworkService.shared)
        let vc = HomeViewController(viewModel: viewModel)
        let item = UITabBarItem(title: "Home",
                                image: UIImage(systemName: "house.fill"),
                                tag: 0)
        vc.tabBarItem = item
        let navController = UINavigationController(rootViewController: vc)
        return navController
    }()
    
    private lazy var searchViewController: UINavigationController = {
        let viewModel = SearchViewModel(networkService: NetworkService.shared)
        let vc = SearchViewController(viewModel: viewModel)
        let item = UITabBarItem(title: "Search",
                                image: UIImage(systemName: "magnifyingglass"),
                                tag: 1)
        vc.tabBarItem = item
        let navController = UINavigationController(rootViewController: vc)
        return navController
    }()
    
    private lazy var favoriteViewController: UINavigationController = {
        let viewModel = FavoriteViewModel(networkService: NetworkService.shared)
        let vc = FavoriteViewController(viewModel: viewModel)
        let item = UITabBarItem(title: "Favorites",
                                image: UIImage(systemName: "heart.fill"),
                                tag: 2)
        vc.tabBarItem = item
        let navController = UINavigationController(rootViewController: vc)
        return navController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = Theme.gradientLayer(for: self.view)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        UITabBar.appearance().barTintColor = Theme.blackColor
        tabBar.tintColor = Theme.whiteColor
        viewControllers = [homeViewController, searchViewController, favoriteViewController]
    }
    
}
