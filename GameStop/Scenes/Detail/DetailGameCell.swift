//
//  DetailGameCell.swift
//  GameStop
//
//  Created by Güray Gül on 21.05.2024.
//

import UIKit

final class DetailGameCell: UICollectionViewCell {
    static let identifier = "DetailGameCell"
        
    private let gameLabel = UILabelFactory(text: "Error")
        .fontSize(of: 24, weight: .bold)
        .textColor(with: .black)
        .numberOf(lines: 0)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(gameLabel)
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            gameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            gameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            gameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with game: Result) {
        gameLabel.text = game.name
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
