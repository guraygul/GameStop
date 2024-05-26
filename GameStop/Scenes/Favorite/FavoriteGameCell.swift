//
//  FavoriteGameCell.swift
//  GameStop
//
//  Created by Güray Gül on 22.05.2024.
//

import UIKit

protocol FavoriteGameCellDelegate: AnyObject {
    func didTapHeartButton(in cell: FavoriteGameCell)
}

final class FavoriteGameCell: UICollectionViewCell {
    static let identifier = "FavoriteGameCell"
    weak var delegate: FavoriteGameCellDelegate?
    
    private let imageViewContainer = UIViewFactory()
        .cornerRadius(10)
        .build()
    
    private let titleLabelContainer = UIViewFactory()
        .shadowOpacity(1)
        .shadowOffset(CGSize(width: 0, height: 5))
        .shadowRadius(10)
        .shadowColor(Theme.blackColor)
        .build()
    
    private let gradientLayerBottom: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, Theme.blackColor.cgColor]
        layer.locations = [0.8, 1.0]
        return layer
    }()
    
    private lazy var likedButton = UIButtonFactory()
        .image(UIImage(systemName: "heart.fill"))
        .addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        .tintColor(Theme.yellowColor)
        .build()
    
    private let imageView = UIImageViewFactory()
        .contentMode(.scaleAspectFill)
        .build()
    
    private let titleLabel = UILabelFactory(text: "Error")
        .textColor(with: .white)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGradientLayer() {
        imageView.layer.addSublayer(gradientLayerBottom)
    }
    
    private func setupUI() {
        contentView.addSubview(imageViewContainer)
        
        contentView.addSubview(titleLabelContainer)
        
        imageViewContainer.addSubview(imageView)
        imageViewContainer.addSubview(likedButton)
        titleLabelContainer.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabelContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabelContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabelContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabelContainer.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleLabelContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleLabelContainer.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleLabelContainer.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            likedButton.topAnchor.constraint(equalTo: imageViewContainer.topAnchor, constant: 16),
            likedButton.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: -16),
            likedButton.widthAnchor.constraint(equalToConstant: 40),
            likedButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayerBottom.frame = contentView.bounds
    }
    
    @objc private func didTapHeartButton() {
        delegate?.didTapHeartButton(in: self)
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
