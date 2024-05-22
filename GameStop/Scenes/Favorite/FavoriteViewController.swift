//
//  FavoriteViewController.swift
//  GameStop
//
//  Created by Güray Gül on 19.05.2024.
//

import UIKit

protocol FavoriteViewControllerProtocol: AnyObject, AlertPresentable {
    func reloadData()
    func favoritesDidUpdate()
}

final class FavoriteViewController: UIViewController {
    private var viewModel: FavoriteViewModelProtocol
    private var collectionView: UICollectionView!
    
    init(viewModel: FavoriteViewModelProtocol) {
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
        
        setupUI()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteGameCell.self, forCellWithReuseIdentifier: "FavoriteGameCell")
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.likedGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteGameCell",
                                                      for: indexPath) as! FavoriteGameCell
        let game = viewModel.likedGames[indexPath.item]
        cell.configure(with: game)
        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }
}

extension FavoriteViewController: FavoriteViewControllerProtocol {
    func favoritesDidUpdate() {
        let detailViewModel = DetailViewModel()
        let favoriteViewController = FavoriteViewController(viewModel: FavoriteViewModel())

        detailViewModel.favoriteViewDelegate = favoriteViewController
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
