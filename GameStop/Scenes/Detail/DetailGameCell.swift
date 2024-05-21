//
//  DetailGameCell.swift
//  GameStop
//
//  Created by Güray Gül on 21.05.2024.
//

import UIKit

final class DetailGameCell: UICollectionViewCell {
    static let identifier = "DetailGameCell"
        
    let gameLabel = UILabelFactory(text: "Error")
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
