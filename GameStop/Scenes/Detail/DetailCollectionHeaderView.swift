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
    }
    
    func configure(with image: String) {
        
        if let imageUrl = URL(string: image) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageUrl,
                                      options: [
                                        .transition(.fade(0.2)),
                                        .cacheOriginalImage
                                      ])
        }
    }
    
}
