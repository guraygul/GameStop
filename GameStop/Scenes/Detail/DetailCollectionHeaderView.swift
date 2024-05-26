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
        .build()
    
    private let imageView = UIImageViewFactory()
        .contentMode(.scaleAspectFill)
        .build()
    
    private let gradientLayerBottom: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.5, 1.0]
        return layer
    }()
    
    private let gradientLayerTop: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        layer.locations = [0.1, 1.0]
        return layer
    }()
    
    private let blurEffectViewBottom: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let blurEffectViewTop: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gameLabel = UILabelFactory(text: "Error")
        .fontSize(of: 24, weight: .bold)
        .textColor(with: Theme.whiteColor)
        .numberOf(lines: 2)
        .build()
    
    private let metacriticImageView = UIImageViewFactory(image: UIImage(named: "meta"))
        .build()
    
    private let metacriticLabel = UILabelFactory(text: "Error")
        .fontSize(of: 16, weight: .semibold)
        .numberOf(lines: 1)
        .textAlignment(.right)
        .textColor(with: .systemYellow)
        .build()
    
    private let ratingImageView = UIImageViewFactory(image: UIImage(systemName: "star.fill"))
        .tintColor(.systemYellow)
        .build()
    
    private let ratingLabel = UILabelFactory(text: "Error")
        .fontSize(of: 16, weight: .semibold)
        .numberOf(lines: 1)
        .textAlignment(.right)
        .textColor(with: .systemYellow)
        .build()
    
    private lazy var metacriticHStack = UIStackViewFactory(axis: .horizontal)
        .addArrangedSubview(metacriticImageView)
        .addArrangedSubview(metacriticLabel)
        .distribution(.fill)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayerTop.frame = blurEffectViewTop.bounds
        gradientLayerBottom.frame = blurEffectViewBottom.bounds
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
        
        headerView.addSubview(blurEffectViewBottom)
        headerView.addSubview(blurEffectViewTop)
        
        NSLayoutConstraint.activate([
            blurEffectViewBottom.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            blurEffectViewBottom.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            blurEffectViewBottom.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            blurEffectViewBottom.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5),
            
            blurEffectViewTop.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            blurEffectViewTop.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            blurEffectViewTop.topAnchor.constraint(equalTo: headerView.topAnchor),
            blurEffectViewTop.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5)
        ])
        
        blurEffectViewTop.layer.mask = gradientLayerTop
        blurEffectViewBottom.layer.mask = gradientLayerBottom
        
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
            ratingVStack.heightAnchor.constraint(equalToConstant: 70),
            ratingVStack.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            metacriticImageView.widthAnchor.constraint(equalToConstant: 30),
            metacriticImageView.heightAnchor.constraint(equalToConstant: 30)
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
        } else {
            imageView.image = UIImage(named: "notFound")
        }
    }
}
