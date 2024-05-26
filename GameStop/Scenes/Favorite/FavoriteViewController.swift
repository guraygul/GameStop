//
//  FavoriteViewController.swift
//  GameStop
//
//  Created by Güray Gül on 19.05.2024.
//

import UIKit

protocol FavoriteViewControllerProtocol: AnyObject, AlertPresentable {
    func setNavigationTitle(with title: String)
    func prepareCollectionView()
    func reloadData()
}

final class FavoriteViewController: UIViewController {
    private var viewModel: FavoriteViewModelProtocol
    private let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 10.0,
                                             bottom: 20.0,
                                             right: 10.0)
    private lazy var collectionView = UICollectionViewFactory()
        .build()
    
    private let emptyView = UIViewFactory()
        .backgroundColor(.clear)
        .build()
    
    private let emptyImageView = UIImageViewFactory(image: UIImage(named: "NothingWasFound"))
        .build()
    
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
        
        leftNavigationBar(backgroundColor: .clear)
        setupUI()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func setupUI() {
        
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        emptyView.isHidden = true
        emptyView.addSubview(emptyImageView)
        collectionView.backgroundView = emptyView
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            emptyImageView.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 8),
            emptyImageView.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -8)
        ])
    }
    
    private func updateEmptyViewVisibility() {
        emptyView.isHidden = viewModel.likedGames.count > 0
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        updateEmptyViewVisibility()
        return viewModel.likedGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteGameCell.identifier,
                                                      for: indexPath) as! FavoriteGameCell
        if let game = viewModel.cellForItem(at: indexPath) {
            cell.delegate = self
            cell.configure(with: game) }
        return cell
    }
    
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        showNavigationBarOnScrollUp(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 1
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 2)
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

extension FavoriteViewController: FavoriteViewControllerProtocol {
    func setNavigationTitle(with title: String) {
        self.title = title
    }
    
    func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            FavoriteGameCell.self,
            forCellWithReuseIdentifier: FavoriteGameCell.identifier)
        
        reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.updateEmptyViewVisibility()
        }
    }
    
}

extension FavoriteViewController: FavoriteGameCellDelegate {
    func didTapHeartButton(in cell: FavoriteGameCell) {
        guard let indexPath = collectionView.indexPath(for: cell),
              let game = viewModel.cellForItem(at: indexPath) else { return }
        
        showConfirmationAlert(
            title: "Remove From Favorites",
            message: "Are you sure you want to remove the like for this game?") { [weak self] in
                guard let self = self else { return }
                self.viewModel.toggleLike(for: game)
        }
    }
}
