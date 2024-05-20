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
    
    private lazy var favoriteViewController: UINavigationController = {
        let vc = FavoriteViewController()
        let item = UITabBarItem(title: "Favorites",
                                image: UIImage(systemName: "heart.fill"),
                                tag: 1)
        vc.tabBarItem = item
        let navController = UINavigationController(rootViewController: vc)
        return navController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        UITabBar.appearance().barTintColor = .green
        tabBar.tintColor = .blue
        viewControllers = [homeViewController, favoriteViewController]
    }
    
}
