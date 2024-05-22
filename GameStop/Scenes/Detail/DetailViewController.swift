//
//  DetailViewController.swift
//  GameStop
//
//  Created by Güray Gül on 21.05.2024.
//

import UIKit
import Kingfisher

protocol DetailViewControllerProtocol: AnyObject {
    func prepareCollectionView()
    func reloadData()
}

final class DetailViewController: UIViewController {
    private var viewModel: DetailViewModelProtocol
    private var isLiked = false
    private let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 10.0,
                                             bottom: 20.0,
                                             right: 10.0)
    
    private lazy var collectionView = UICollectionViewFactory()
        .backgroundColor(.clear)
        .registerCellClass(DetailGameCell.self,
                           forCellWithReuseIdentifier: "DetailGameCell")
        .registerSupplementaryViewClass(
            DetailCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DetailCollectionHeaderView.identifier
        )
        .contentInsetAdjustmentBehavior(.never)
        .build()
    
    private var headerView = UIViewFactory()
        .build()
    
    private lazy var heartButton = UIButtonFactory()
        .image(UIImage(systemName: "heart"), for: .normal)
        .addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        .build()
    
    init(viewModel: DetailViewModelProtocol) {
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
        
        view.backgroundColor = .white
        setupUI()
        setupNavigationBar()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
        navigationItem.rightBarButtonItem = heartBarButtonItem
        
        if let firstGame = viewModel.cellForItem(at: IndexPath(item: 0,
                                                               section: 0)) {
            updateHeartButton(for: firstGame)
        }
    }
    
    @objc private func heartButtonTapped() {
        guard let selectedGame = viewModel.cellForItem(at: IndexPath(item: 0,
                                                                     section: 0)) else { return }
        viewModel.toggleLike(for: selectedGame)
        updateHeartButton(for: selectedGame)
    }
    
    func updateHeartButton(for game: Result) {
        isLiked = viewModel.isGameLiked(id: game.id ?? 0)
        let imageName = isLiked ? "heart.fill" : "heart"
        heartButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}

// MARK: - Configuring collection view cells data
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailGameCell.identifier,
                                                      for: indexPath) as! DetailGameCell
        
        if let game = viewModel.cellForItem(at: indexPath) { cell.configure(with: game) }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DetailCollectionHeaderView.identifier,
                for: indexPath) as! DetailCollectionHeaderView
            if let game = viewModel.cellForItem(
                at: indexPath
            ) {
                headerView.configure(
                    with: game
                )
            }
            return headerView
        }
        fatalError("Unexpected element kind")
    }
    
}

// MARK: - Configuring collection view cells size
extension DetailViewController: UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 400)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
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
    let navC = UINavigationController(
        rootViewController: DetailViewController(
            viewModel: DetailViewModel(
                games: [Result(
                    id: 3498,
                    name: "Grand Theft Auto V",
                    released: "2013-09-17",
                    backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                    rating: 4.47,
                    ratingTop: 5,
                    metacritic: 92
                )]
            )
        )
    )
    return navC
}
