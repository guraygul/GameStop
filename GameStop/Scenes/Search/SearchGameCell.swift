//
//  SearchGameCell.swift
//  GameStop
//
//  Created by Güray Gül on 22.05.2024.
//

import UIKit
import Kingfisher

final class SearchGameCell: UICollectionViewCell {
    static let identifier = "SearchGameCell"
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 120),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10)
        ])
    }
    
    func configure(with game: SearchResult) {
        titleLabel.text = game.name
        
        if let imageUrl = game.backgroundImage,
           let url = URL(string: imageUrl) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url, options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage,
                .downloader(KingfisherManager.shared.downloader)
            ])
        } else {
            imageView.image = UIImage(named: "notFound")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
    
}
