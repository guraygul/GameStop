//
//  SearchViewModel.swift
//  GameStop
//
//  Created by Güray Gül on 22.05.2024.
//

import Foundation

protocol SearchViewModelProtocol {
    var view: SearchViewControllerProtocol? { get set }
    var games: [Result] { get }
    var gameDetails: [GameDetailModel] { get }
    
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func cellForItem(at indexPath: IndexPath) -> Result?
    func fetchNextPage()
    func searchGames(with query: String)
}

final class SearchViewModel {
    weak var view: SearchViewControllerProtocol?
    private let networkService: NetworkServiceProtocol
    
    private(set) var games: [Result] = []
    private(set) var gameDetails: [GameDetailModel] = []
    
    private var currentPage: Int = 1
    private var isFetching: Bool = false
    private var hasMoreGames: Bool = true
    private var name: String = ""
    
    private var debounceTimer: Timer?
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    private func fetchGames(page: Int, name: String) {
        guard !isFetching, hasMoreGames else { return }
        isFetching = true
        Task {
            do {
                let gameModel = try await networkService.fetchData(
                    from: GameAPI.search(page: page,
                                         name: name),
                    as: GameModel.self)
                self.games = page == 1 ? gameModel.results ?? [] : self.games + (gameModel.results ?? [])
                self.hasMoreGames = gameModel.next != nil
                self.currentPage = page + 1
                await MainActor.run { [weak self] in
                    self?.view?.reloadData()
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.showAlert(
                        title: "Failed to fetch searched games",
                        message: "An Error occured while fething searched games.\nPlease check your connection and try again.",
                        openSettings: false) {
                            self.fetchGames(page: page, name: name)
                        }
                }
            }
            isFetching = false
        }
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    func didSelectItem(at indexPath: IndexPath) {
        guard let game = games[safe: indexPath.item] else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.navigateToDetailScreen(with: game)
        }
    }
    
    func cellForItem(at indexPath: IndexPath) -> Result? {
        return games[safe: indexPath.item]
    }
    
    func fetchNextPage() {
        fetchGames(page: currentPage, name: name)
    }
    
    func viewDidLoad() {
        view?.setNavigationTitle(with: "Search")
        view?.prepareCollectionView()
        fetchGames(page: currentPage, name: name)
    }
    
    func searchGames(with query: String) {
        name = query
        hasMoreGames = true
        currentPage = 1
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(
            withTimeInterval: 0.5, repeats: false) { [weak self] _ in
                self?.fetchGames(page: 1, name: query)
            }
    }
}
