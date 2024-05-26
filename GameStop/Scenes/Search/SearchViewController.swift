//
//  SearchViewController.swift
//  GameStop
//
//  Created by Güray Gül on 22.05.2024.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject, AlertPresentable {
    func setNavigationTitle(with title: String)
    func prepareCollectionView()
    func reloadData()
    func navigateToDetailScreen(with game: Result?)
}

final class SearchViewController: UIViewController {
    private var viewModel: SearchViewModelProtocol
    private let searchController = UISearchController(searchResultsController: nil)
    private let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 10.0,
                                             bottom: 20.0,
                                             right: 10.0)
    
    private lazy var collectionView = UICollectionViewFactory()
        .build()
    
    private let emptyView = UIViewFactory()
        .backgroundColor(.clear)
        .build()
    
    private let emptyImageView = UIImageViewFactory(image: UIImage(named: "NothingWasFound"))
        .build()
    
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
        leftNavigationBar(backgroundColor: .clear)
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.applyCustomStyling(
            placeholder: "Search by game name...",
            placeholderColor: Theme.tintColor,
            backgroundColor: Theme.backgroundColor,
            tintColor: Theme.yellowColor
        )
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        emptyView.isHidden = true
        emptyView.addSubview(emptyImageView)
        collectionView.backgroundView = emptyView
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            emptyImageView.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 8),
            emptyImageView.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -8)
        ])
    }
    
    private func updateEmptyViewVisibility() {
        emptyView.isHidden = viewModel.games.count > 0
    }
}

// MARK: - Configuring collection view cells data
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        updateEmptyViewVisibility()
        return viewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchGameCell.identifier,
                                                      for: indexPath) as! SearchGameCell
        if let game = viewModel.cellForItem(at: indexPath) { cell.configure(with: game) }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height * 2 {
            viewModel.fetchNextPage()
        }
        
        showNavigationBarOnScrollUp(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 1
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        viewModel.searchGames(with: query)
        updateEmptyViewVisibility()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchGames(with: "")
        updateEmptyViewVisibility()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.searchGames(with: "")
        }
        updateEmptyViewVisibility()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.resignFirstResponder()
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    func setNavigationTitle(with title: String) {
        self.title = title
    }
    
    func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            SearchGameCell.self,
            forCellWithReuseIdentifier: SearchGameCell.identifier)
        
        collectionView.reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.updateEmptyViewVisibility()
        }
    }
    
    func navigateToDetailScreen(with game: Result?) {
        guard let game = game else { return }
        let detailViewModel = DetailViewModel(game: [game])
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let detailViewController = DetailViewController(viewModel: detailViewModel)
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
