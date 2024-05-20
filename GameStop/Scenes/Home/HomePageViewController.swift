//
//  HomePageViewController.swift
//  GameStop
//
//  Created by Güray Gül on 20.05.2024.
//

import UIKit

final class HomePageViewController: UIViewController {
    private var pageViewController: UIPageViewController!
    var games: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)
        pageViewController.dataSource = self
        
        if let firstViewController = viewController(at: 0) {
            pageViewController.setViewControllers([firstViewController], direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        }
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func viewController(at index: Int) -> HomePageImageViewController? {
        guard index >= 0 && index < games.count else {
            return nil
        }
        let viewController = HomePageImageViewController()
        viewController.imageUrl = games[index].backgroundImage
        viewController.pageIndex = index
        return viewController
    }
    
}

// MARK: - UIPageViewControllerDataSource Methods
extension HomePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? HomePageImageViewController,
              let index = viewController.pageIndex,
              index > 0 else { return nil }
        return self.viewController(at: index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? HomePageImageViewController,
              let index = viewController.pageIndex,
              index < games.count - 1 else { return nil }
        return self.viewController(at: index + 1)
    }
}

