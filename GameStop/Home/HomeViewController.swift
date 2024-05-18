//
//  HomeController.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import UIKit
import Kingfisher

protocol HomeViewInterface: AnyObject {
    func prepareCollectionView()
    func reloadData()
}

final class HomeViewController: UIViewController {
    
    private lazy var viewModel: HomeViewModelInterface = HomeViewModel()
    
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    private let navigationTitleLabel = UILabelFactory(text: "GameStop")
        .fontSize(of: 20, weight: .bold)
        .textColor(with: Theme.tintColor)
        .build()
    
    private lazy var collectionView = UICollectionViewFactory()
        .backgroundColor(.clear)
        .registerCellClass(HomeGameCell.self, forCellWithReuseIdentifier: "GameCell")
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
        view.backgroundColor = Theme.backgroundColor
        setupLeftAlignedTitle()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    func setupLeftAlignedTitle() {
        let titleView = UIView()
        titleView.addSubview(navigationTitleLabel)
        
        NSLayoutConstraint.activate([
            navigationTitleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            navigationTitleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            navigationTitleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor)
        ])
        
        self.navigationItem.titleView = titleView
        
        NSLayoutConstraint.activate([
            titleView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            titleView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.gamesCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGameCell.identifier,
                                                      for: indexPath) as! HomeGameCell
        
        if let game = viewModel.cellForItem(at: indexPath) {
            cell.gameLabel.text = game.name
            if let imageUrl = game.backgroundImage, let url = URL(string: imageUrl) {
                cell.gameImageView.kf.setImage(with: url)
            }
        }
        
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let itemsPerRow: CGFloat = 1
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 4)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
            return sectionInsets
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
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
    }
}

#Preview {
    let navC = UINavigationController(rootViewController: HomeViewController())
    return navC
}
