//
//  DetailScreenshotCell.swift
//  GameStop
//
//  Created by Güray Gül on 24.05.2024.
//

import UIKit

protocol DetailScreenshotCellDelegate: AnyObject {
    func playVideo(with url: URL)
}

final class DetailScreenshotCell: UICollectionViewCell {
    static let identifier = "DetailScreenshotCell"
    
    weak var delegate: DetailScreenshotCellDelegate?
    
    private let imageViewContainer = UIViewFactory()
        .build()
    
    private let imageView = UIImageViewFactory()
        .contentMode(.scaleAspectFill)
        .build()
    
    private var videoURL: URL?
    
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
        
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
        
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
    
    func configure(with media: Media, delegate: DetailScreenshotCellDelegate) {
        self.delegate = delegate
        
        switch media {
        case .screenshot(let screenshot):
            imageView.isHidden = false
            videoURL = nil
            if let imageUrl = screenshot.image, let url = URL(string: imageUrl) {
                imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            } else {
                imageView.image = UIImage(named: "placeholder")
            }
        case .trailer(let trailer):
            imageView.isHidden = false
            if let previewUrl = URL(string: trailer.preview) {
                imageView.kf.setImage(with: previewUrl, placeholder: UIImage(named: "placeholder"))
            }
            if let videoUrl = URL(string: trailer.data.low?.absoluteString ?? "") {
                videoURL = videoUrl
            }
        }
    }
    
    @objc private func imageViewTapped() {
        guard let url = videoURL else { return }
        delegate?.playVideo(with: url)
    }
}
