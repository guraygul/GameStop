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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.7, 1.0]
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupGradientLayer()
        
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(named: "notFound")
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
        imageView.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = imageView.bounds
    }
}
