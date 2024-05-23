//
//  DetailCollectionHeaderView.swift
//  GameStop
//
//  Created by Güray Gül on 21.05.2024.
//

import UIKit

final class DetailCollectionHeaderView: UICollectionReusableView {
    static let identifier = "DetailCollectionHeaderView"
    
    private let headerView = UIViewFactory()
        .backgroundColor(.blue)
        .build()
    
    private let imageView = UIImageViewFactory()
        .contentMode(.scaleAspectFill)
        .build()
    
    private let gameLabel = UILabelFactory(text: "Error")
        .fontSize(of: 24, weight: .bold)
        .textColor(with: .black)
        .numberOf(lines: 1)
        .build()
    
    private let metacriticImageView = UIImageViewFactory(image: UIImage(named: "meta"))
        .build()
    
    private let metacriticLabel = UILabelFactory(text: "Error")
        .fontSize(of: 16, weight: .semibold)
        .numberOf(lines: 1)
        .textAlignment(.right)
        .textColor(with: .yellow)
        .build()
    
    private let ratingImageView = UIImageViewFactory(image: UIImage(systemName: "star.fill"))
        .build()
    
    private let ratingLabel = UILabelFactory(text: "Error")
        .fontSize(of: 16, weight: .semibold)
        .numberOf(lines: 1)
        .textAlignment(.right)
        .textColor(with: .red)
        .build()
    
    private lazy var metacriticHStack = UIStackViewFactory(axis: .horizontal)
        .addArrangedSubview(metacriticImageView)
        .addArrangedSubview(metacriticLabel)
        .distribution(.fillEqually)
        .build()
    
    private lazy var ratingHStack = UIStackViewFactory(axis: .horizontal)
        .addArrangedSubview(ratingImageView)
        .addArrangedSubview(ratingLabel)
        .distribution(.fill)
        .build()
    
    private lazy var ratingVStack = UIStackViewFactory(axis: .vertical)
        .addArrangedSubview(metacriticHStack)
        .addArrangedSubview(ratingHStack)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        headerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        headerView.addSubview(gameLabel)
        
        NSLayoutConstraint.activate([
            gameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            gameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16)
        ])
        
        headerView.addSubview(ratingVStack)
        
        NSLayoutConstraint.activate([
            ratingVStack.leadingAnchor.constraint(greaterThanOrEqualTo: gameLabel.trailingAnchor, constant: 16),
            ratingVStack.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            ratingVStack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16),
            ratingVStack.heightAnchor.constraint(equalToConstant: 100),
            ratingVStack.widthAnchor.constraint(equalToConstant: 80),
        ])
        
    }
    
    func configure(with game: Result) {
        gameLabel.text = game.name
        metacriticLabel.text = String(describing: game.metacritic ?? 0)
        ratingLabel.text = String(describing: game.ratingTop ?? 0) + "/" + String(describing: game.rating ?? 0)
        
        if let imageUrl = game.backgroundImage,
           let url = URL(string: imageUrl) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "notFound"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ])
        }
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
