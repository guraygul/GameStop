//
//  HomeGameCell.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import UIKit
import Kingfisher

final class HomeGameCell: UICollectionViewCell {
    static let identifier = "GameCell"
    
    private let gameImageView = UIImageViewFactory()
        .contentMode(.scaleAspectFill)
        .cornerRadius(10)
        .build()
    
    private let gameLabel = UILabelFactory(text: "Error")
        .fontSize(of: 14, weight: .medium)
        .numberOf(lines: 1)
        .textColor(with: Theme.whiteColor)
        .build()
    
    private let genresStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        addSubview(gameImageView)
        addSubview(arrowImageView)
        addSubview(gameLabel)
        addSubview(genresStackView)
        
        arrowImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        gameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        genresStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gameImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gameImageView.widthAnchor.constraint(equalToConstant: 160)
        ])
        
        NSLayoutConstraint.activate([
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            gameLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 8),
            gameLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            genresStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            genresStackView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 8),
            genresStackView.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -8),
            genresStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with game: Result) {
        gameLabel.text = game.name
        
        genresStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if let genres = game.genres, !genres.isEmpty {
            let displayedGenres = genres.prefix(2)
            displayedGenres.forEach { genre in
                let genreLabel = createGenreLabel(text: genre.name ?? "Unknown")
                genresStackView.addArrangedSubview(genreLabel)
            }
        } else {
            let genreLabel = createGenreLabel(text: "Unknown Genre")
            genresStackView.addArrangedSubview(genreLabel)
        }
        
        if let imageUrl = game.backgroundImage,
           let url = URL(string: imageUrl) {
            gameImageView.kf.indicatorType = .activity
            gameImageView.kf.setImage(with: url, options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage,
                .downloader(KingfisherManager.shared.downloader)
            ])
        } else {
            gameImageView.image = UIImage(named: "notFound")
        }
    }
    
    private func createGenreLabel(text: String) -> UIView {
        let label = UILabelFactory(text: text)
            .fontSize(of: 12, weight: .medium)
            .textColor(with: Theme.blackColor)
            .build()
        
        let container = UIViewFactory()
            .backgroundColor(Theme.yellowColor)
            .cornerRadius(15)
            .build()
        
        container.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            container.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return container
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.kf.cancelDownloadTask()
        gameImageView.image = nil
        genresStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

#Preview {
    let navC = UINavigationController(rootViewController: TabBarViewController())
    return navC
}
