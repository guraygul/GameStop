//
//  HomePageImageViewController.swift
//  GameStop
//
//  Created by Güray Gül on 20.05.2024.
//

import UIKit
import Kingfisher

final class HomePageImageViewController: UIViewController {
    var imageUrl: String?
    var pageIndex: Int?
    var gameName: String?
    
    private let imageView = UIImageViewFactory()
        .cornerRadius(10)
        .contentMode(.scaleAspectFill)
        .build()
    
    private let gradientLayerBottom: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, Theme.blackColor.withAlphaComponent(0.6).cgColor]
        layer.locations = [0.9, 1.0]
        return layer
    }()
    
    private let gradientLayerTop: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [Theme.blackColor.withAlphaComponent(0.6).cgColor, UIColor.clear.cgColor]
        layer.locations = [0.0, 0.3]
        return layer
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupGradientLayer()
        setupNameLabel()
        
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(named: "notFound")
        }
        
        if let gameName = gameName {
            nameLabel.text = gameName
        }
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupGradientLayer() {
        imageView.layer.addSublayer(gradientLayerTop)
        imageView.layer.addSublayer(gradientLayerBottom)
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayerTop.frame = imageView.bounds
        gradientLayerBottom.frame = imageView.bounds
    }
}
