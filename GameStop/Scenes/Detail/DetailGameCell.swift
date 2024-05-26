//
//  DetailGameCell.swift
//  GameStop
//
//  Created by Güray Gül on 21.05.2024.
//

import UIKit

final class DetailGameCell: UICollectionViewCell {
    private var mediaItems: [Media] = []
    weak var delegate: DetailScreenshotCellDelegate?
    static let identifier = "DetailGameCell"
    private let sectionInsets = UIEdgeInsets(top: 0,
                                             left: 10.0,
                                             bottom: 0,
                                             right: 10.0)
    
    private let gameLabel = UILabelFactory(text: "Description")
        .fontSize(of: 24, weight: .bold)
        .textColor(with: Theme.whiteColor)
        .numberOf(lines: 0)
        .build()
    
    private let gameDescriptionLabel = UILabelFactory(text: "Error")
        .fontSize(of: 14, weight: .regular)
        .textColor(with: Theme.tintColor)
        .numberOf(lines: 0)
        .build()
    
    private let previewLabel = UILabelFactory(text: "Preview")
        .fontSize(of: 16, weight: .medium)
        .textColor(with: Theme.whiteColor)
        .numberOf(lines: 1)
        .build()
    
    private lazy var screenshotsCollectionView = UICollectionViewFactory()
        .registerCellClass(DetailScreenshotCell.self,
                           forCellWithReuseIdentifier: DetailScreenshotCell.identifier)
        .scrollDirection(.horizontal)
        .minimumInteritemSpacing(sectionInsets.left)
        .showsHorizontalScrollIndicator(false)
        .delegate(self)
        .dataSource(self)
        .build()
    
    private var shortScreenshots: [ShortScreenshot] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(gameLabel)
        contentView.addSubview(gameDescriptionLabel)
        contentView.addSubview(previewLabel)
        contentView.addSubview(screenshotsCollectionView)
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            gameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            gameDescriptionLabel.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 16),
            gameDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            gameDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            previewLabel.topAnchor.constraint(equalTo: gameDescriptionLabel.bottomAnchor, constant: 16),
            previewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            previewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            screenshotsCollectionView.topAnchor.constraint(equalTo: previewLabel.bottomAnchor, constant: 8),
            screenshotsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            screenshotsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screenshotsCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configure(with game: Result,
                   withDetails gameDetails: GameDetailModel,
                   media: [Media],
                   delegate: DetailScreenshotCellDelegate) {
        gameDescriptionLabel.text = gameDetails.description?.extractEnglishDescription() ?? "Error"
        self.mediaItems = media
        self.delegate = delegate
        screenshotsCollectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension DetailGameCell: UICollectionViewDataSource,
                          UICollectionViewDelegate,
                          UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return mediaItems.count
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DetailScreenshotCell.identifier,
                for: indexPath) as! DetailScreenshotCell
            
            let media = mediaItems[indexPath.item]
            cell.configure(with: media, delegate: delegate!)
            return cell
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let paddingSpace = sectionInsets.left * 2
            let availableWidth = collectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / 1.5
            return CGSize(width: widthPerItem, height: widthPerItem * 0.5)
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

#Preview {
    let navC = UINavigationController(
        rootViewController: DetailViewController(
            viewModel: DetailViewModel(
                game: [Result(
                    id: 3498,
                    name: "Grand Theft Auto V",
                    released: "2013-09-17",
                    backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                    rating: 4.47,
                    ratingTop: 5,
                    metacritic: 92,
                    genres: [Genre(name: "Action")],
                    shortScreenshots: [ShortScreenshot(id: -1,
                                                       image: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg")]
                )]
            )
        )
    )
    return navC
}
