//
//  HomeController.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import UIKit
import Kingfisher

protocol HomeViewInterface: AnyObject, AlertPresentable {
    func prepareCollectionView()
    func reloadData()
}

final class HomeViewController: UIViewController {
    private var viewModel: HomeViewModelInterface
    private let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 10.0,
                                             bottom: 20.0,
                                             right: 10.0)
    
    private lazy var collectionView = UICollectionViewFactory()
        .backgroundColor(.clear)
        .registerCellClass(HomeGameCell.self, forCellWithReuseIdentifier: "GameCell")
        .build()
    
    init(viewModel: HomeViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
        view.backgroundColor = Theme.backgroundColor
        navigationItem.title = "GameStop"
        
        setupCollectionView()
        setupPageViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupPageViewController() {
        let homePageViewController = HomePageViewController()
        homePageViewController.games = Array(viewModel.games.prefix(3))
        
        addChild(homePageViewController)
        view.addSubview(homePageViewController.view)
        homePageViewController.didMove(toParent: self)
        
        homePageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homePageViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homePageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homePageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homePageViewController.view.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}

// MARK: - Configuring collection view cells data
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.gamesCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGameCell.identifier,
                                                      for: indexPath) as! HomeGameCell
        
        if let game = viewModel.cellForItem(at: indexPath) { cell.configure(with: game) }
        
        return cell
    }
    
}

// MARK: - Configuring collection view cells size
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 1
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension HomeViewController: HomeViewInterface {
    func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.reloadData()
    }
    
    func reloadData() {
        collectionView.reloadData()
        setupPageViewController()
    }
    
}

#Preview {
    let navC = UINavigationController(rootViewController: HomeViewController(viewModel: HomeViewModel(networkService: NetworkService.shared)))
    return navC
}
