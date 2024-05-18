//
//  HomeGameCell.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import UIKit

protocol HomeGameCellInterface: AnyObject {
    
}

final class HomeGameCell: UICollectionViewCell {
    
    static let identifier = "GameCell"
    
    let gameImageView = UIImageViewFactory()
        .build()
    
    let gameLabel = UILabelFactory(text: "Error")
        .fontSize(of: 22, weight: .medium)
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
            gameImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            gameImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            gameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            gameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
