//
//  DetailGameCell.swift
//  GameStop
//
//  Created by Güray Gül on 21.05.2024.
//

import UIKit

final class DetailGameCell: UICollectionViewCell {
    static let identifier = "DetailGameCell"
    
    let gameImageView = UIImageViewFactory()
        .build()
    
    let gameLabel = UILabelFactory(text: "Error")
        .fontSize(of: 10, weight: .medium)
        .textColor(with: Theme.tintColor)
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
        addSubview(gameLabel)
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gameImageView.heightAnchor.constraint(equalToConstant: 100),
            gameImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            gameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            gameLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 10)
        ])
    }
    
    func configure(with game: Result) {
        gameLabel.text = game.name
        
        if let imageUrl = game.backgroundImage, let url = URL(string: imageUrl) {
            gameImageView.kf.indicatorType = .activity
            gameImageView.kf.setImage(with: url,
                                      options: [
                                        .transition(.fade(0.2)),
                                        .cacheOriginalImage
                                      ])
        }
    }
}