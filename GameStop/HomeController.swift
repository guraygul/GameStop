//
//  HomeController.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import UIKit

class HomeController: UIViewController {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "GameStop"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        setupLeftAlignedTitle()
    }
    
    func setupLeftAlignedTitle() {
        let titleView = UIView()
        titleView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor)
        ])
        
        self.navigationItem.titleView = titleView
        
        NSLayoutConstraint.activate([
            titleView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            titleView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}

#Preview {
    let navC = UINavigationController(rootViewController: HomeController())
    return navC
}
