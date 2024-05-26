//
//  DetailViewController.swift
//  GameStop
//
//  Created by Güray Gül on 21.05.2024.
//

import UIKit
import Kingfisher
import AVKit

protocol DetailViewControllerProtocol: AnyObject, AlertPresentable {
    func prepareCollectionView()
    func reloadData()
    func prepareNavigationBar(with backgroundColor: UIColor)
    func updateHeartButton(for game: Result)
}

final class DetailViewController: UIViewController {
    private var viewModel: DetailViewModelProtocol
    private var isLiked = false
    private let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 0,
                                             bottom: 20.0,
                                             right: 0)
    
    private lazy var collectionView = UICollectionViewFactory()
        .registerSupplementaryViewClass(
            DetailCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DetailCollectionHeaderView.identifier
        )
        .contentInsetAdjustmentBehavior(.never)
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
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func setupUI() {
        setBackBarButtonItemTitleToEmpty()
        setNavigationBarItemsColor(.systemYellow)
        view.addSubview(collectionView)
        collectionView.backgroundColor = Theme.backgroundColor
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func heartButtonTapped() {
        guard let selectedGame = viewModel.cellForItem(
            at: IndexPath(item: 0,
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
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailGameCell.identifier,
                                                      for: indexPath) as! DetailGameCell
        
        if let game = viewModel.cellForItem(at: indexPath),
           let gameDetails = viewModel.cellForItemForDetail(at: indexPath) {
            let media = viewModel.getCombinedMedia()
            cell.configure(with: game, withDetails: gameDetails, media: media, delegate: self)
        }
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
            
            if let game = viewModel.cellForItem(at: indexPath) {
                headerView.configure(with: game)
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
        
        let paddingSpace = sectionInsets.left * 2
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth
        let heightPerItem = widthPerItem / 1.5
        
        return CGSize(width: widthPerItem, height: heightPerItem * 3 )
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
        
        collectionView.register(
            DetailGameCell.self,
            forCellWithReuseIdentifier: DetailGameCell.identifier)
        
        reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
    func prepareNavigationBar(with backgroundColor: UIColor) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.leftNavigationBar(backgroundColor: backgroundColor)
            
            let heartBarButtonItem = UIBarButtonItem(customView: self.heartButton)
            self.navigationItem.rightBarButtonItem = heartBarButtonItem
            
            if let firstGame = self.viewModel.cellForItem(
                at: IndexPath(item: 0,
                              section: 0)) {
                self.updateHeartButton(for: firstGame)
            }
        }
    }
    
}

extension DetailViewController: DetailScreenshotCellDelegate {
    func playVideo(with url: URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}

//#Preview {
//    let navC = UINavigationController(
//        rootViewController: DetailViewController(
//            viewModel: DetailViewModel(
//                games: [Result(
//                    id: 3498,
//                    name: "Grand Theft Auto V",
//                    released: "2013-09-17",
//                    backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
//                    rating: 4.47,
//                    ratingTop: 5,
//                    metacritic: 92,
//                    shortScreenshots: [ShortScreenshot(id: -1,
//                                                       image: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg")]
//                )]
//            )
//        )
//    )
//    return navC
//}
