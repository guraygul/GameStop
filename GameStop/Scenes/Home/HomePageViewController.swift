//
//  HomePageViewController.swift
//  GameStop
//
//  Created by Güray Gül on 20.05.2024.
//

import UIKit

final class HomePageViewController: UIViewController {
    private var pageViewController: UIPageViewController!
    private var timer: Timer?
    private var pageControl: UIPageControl!
    
    var games: [Result] = [] {
        didSet {
            setupPageViewController()
            setupPageControl()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        setupPageControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    func setGames(_ games: [Result]) {
        self.games = games
        if isViewLoaded {
            setupPageViewController()
            setupPageControl()
        }
    }
    
    private func setupPageViewController() {
        if pageViewController != nil {
            pageViewController.willMove(toParent: nil)
            pageViewController.view.removeFromSuperview()
            pageViewController.removeFromParent()
        }
        
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
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
    
    private func setupPageControl() {
        if pageControl != nil {
            pageControl.removeFromSuperview()
        }
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = games.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = Theme.yellowColor
        pageControl.pageIndicatorTintColor = .lightGray
        
        applyShadowToPageControl()
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func applyShadowToPageControl() {
        pageControl.layer.shadowColor = UIColor.black.cgColor
        pageControl.layer.shadowOpacity = 1
        pageControl.layer.shadowOffset = CGSize.zero
        pageControl.layer.shadowRadius = 2
        pageControl.layer.masksToBounds = false
    }
    
    private func viewController(at index: Int) -> HomePageImageViewController? {
        guard index >= 0 && index < games.count else {
            return nil
        }
        let viewController = HomePageImageViewController()
        viewController.imageUrl = games[index].backgroundImage
        viewController.pageIndex = index
        viewController.gameName = games[index].name
        
        return viewController
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 3.0,
                                     target: self,
                                     selector: #selector(moveToNextPage),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func moveToNextPage() {
        guard let currentViewController = pageViewController.viewControllers?.first as? HomePageImageViewController,
              let currentIndex = currentViewController.pageIndex else { return }
        
        let nextIndex = (currentIndex + 1) % games.count
        if let nextViewController = viewController(at: nextIndex) {
            pageViewController.setViewControllers([nextViewController],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
            pageControl.currentPage = nextIndex
            applyShadowToPageControl()
        }
    }
    
}

// MARK: - UIPageViewControllerDataSource Methods
extension HomePageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewController = viewController as? HomePageImageViewController,
                  let index = viewController.pageIndex,
                  index > 0 else { return nil }
            return self.viewController(at: index - 1)
        }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewController = viewController as? HomePageImageViewController,
                  let index = viewController.pageIndex,
                  index < games.count - 1 else { return nil }
            return self.viewController(at: index + 1)
        }
}

// MARK: - UIPageViewControllerDelegate Methods
extension HomePageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard completed,
              let viewController = pageViewController.viewControllers?.first as? HomePageImageViewController,
              let index = viewController.pageIndex else { return }
        pageControl.currentPage = index
        applyShadowToPageControl()
    }
}
