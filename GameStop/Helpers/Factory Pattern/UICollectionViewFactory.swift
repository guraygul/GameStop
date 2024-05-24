//
//  UICollectionViewFactory.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import UIKit

final class UICollectionViewFactory {
    private let collectionView: UICollectionView
    
    // MARK: - Inits
    init(layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
    }
    
    // MARK: - Public methods
    func backgroundColor(_ color: UIColor) -> Self {
        collectionView.backgroundColor = color
        return self
    }
    
    func registerCellClass(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) -> Self {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
        return self
    }
    
    func registerSupplementaryViewClass(_ viewClass: AnyClass?,
                                        forSupplementaryViewOfKind kind: String,
                                        withReuseIdentifier identifier: String) -> Self {
        collectionView.register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        return self
    }
    
    func delegate(_ delegate: UICollectionViewDelegate?) -> Self {
        collectionView.delegate = delegate
        return self
    }
    
    func dataSource(_ dataSource: UICollectionViewDataSource?) -> Self {
        collectionView.dataSource = dataSource
        return self
    }
    
    func contentInset(_ insets: UIEdgeInsets) -> Self {
        collectionView.contentInset = insets
        return self
    }
    
    func contentInsetAdjustmentBehavior(_ behavior: UIScrollView.ContentInsetAdjustmentBehavior) -> Self {
        collectionView.contentInsetAdjustmentBehavior = behavior
        return self
    }
    
    func scrollDirection(_ direction: UICollectionView.ScrollDirection) -> Self {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = direction
        }
        return self
    }
    
    func showsHorizontalScrollIndicator(_ shows: Bool) -> Self {
        collectionView.showsHorizontalScrollIndicator = shows
        return self
    }
    
    func minimumInteritemSpacing(_ insets: CGFloat) -> Self {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = insets
        return self
    }
    
    func build() -> UICollectionView {
        return collectionView
    }
}
