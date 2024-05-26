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
    
    private let imageView = UIImageViewFactory()
        .contentMode(.scaleAspectFill)
        .cornerRadius(10)
        .build()
    
    private let titleLabel = UILabelFactory(text: "Error")
        .fontSize(of: 14, weight: .medium)
        .numberOf(lines: 3)
        .textColor(with: Theme.whiteColor)
        .build()
    
    private let arrowImageView = UIImageViewFactory(image: UIImage(systemName: "chevron.right"))
        .tintColor(Theme.yellowColor)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -8)
        ])
    }
    
    func configure(with game: Result) {
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
