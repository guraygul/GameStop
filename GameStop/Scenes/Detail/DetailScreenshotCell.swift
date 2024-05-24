//
//  DetailScreenshotCell.swift
//  GameStop
//
//  Created by Güray Gül on 24.05.2024.
//

import UIKit

final class DetailScreenshotCell: UICollectionViewCell {
    static let identifier = "DetailScreenshotCell"
    
    private let imageViewContainer = UIViewFactory()
        .build()
    
    private let imageView = UIImageViewFactory()
        .contentMode(.scaleAspectFill)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageViewContainer)
        imageViewContainer.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor)
        ])
    }
    
    func configure(with screenshot: ShortScreenshot) {
        if let imageUrl = screenshot.image,
           let url = URL(string: imageUrl) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}
