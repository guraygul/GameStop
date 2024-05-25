//
//  FavoriteGameCell.swift
//  GameStop
//
//  Created by Güray Gül on 22.05.2024.
//

import UIKit

final class FavoriteGameCell: UICollectionViewCell {
    static let identifier = "FavoriteGameCell"
    
    private let imageView = UIImageViewFactory()
        .build()
    
    private let titleLabel = UILabelFactory(text: "Error")
        .textColor(with: .white)
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
        contentView.addSubview(titleLabel)
        
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
    
    func configure(with game: Result) {
        titleLabel.text = game.name
        if let imageUrl = game.backgroundImage {
            imageView.kf.setImage(
                with: URL(string: imageUrl))
        } else {
            imageView.image = UIImage(named: "notFound")
        }
    }
}
