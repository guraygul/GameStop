//
//  HomeViewModel.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var view: HomeViewControllerProtocol? { get set }
    var games: [Result] { get }
    var gameDetails: [GameDetailModel] { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func didSelectItem(at indexPath: IndexPath)
    func cellForItem(at indexPath: IndexPath) -> Result?
    func fetchNextPage()
    func numberOfGames() -> Int
}

final class HomeViewModel {
    weak var view: HomeViewControllerProtocol?
    private let networkService: NetworkServiceProtocol
    
    private(set) var games: [Result] = []
    private(set) var gameDetails: [GameDetailModel] = []
    
    private var currentPage: Int = 1
    private var isFetching: Bool = false
    private var hasMoreGames: Bool = true
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    private func fetchGames(page: Int) {
        guard !isFetching, hasMoreGames else { return }
        isFetching = true
        Task {
            do {
                let gameModel = try await networkService.fetchData(
                    from: GameAPI.games(page: page),
                    as: GameModel.self)
                self.games += gameModel.results ?? []
                self.hasMoreGames = gameModel.next != nil
                self.currentPage += 1
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.reloadData()
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.showAlert(
                        title: "Failed to fetch games",
                        message: "An Error occured while fething games.\nPlease check your connection and try again.",
                        openSettings: true) {
                        self.fetchGames(page: page)
                    }
                }
            }
            isFetching = false
        }
    }
    
    private func fetchGameDetails(for gameID: Int, completion: @escaping (GameDetailModel?) -> Void) {
        Task {
            do {
                let gameDetail = try await networkService.fetchData(
                    from: GameAPI.gameDetails(id: gameID),
                    as: GameDetailModel.self)
                completion(gameDetail)
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.showAlert(
                        title: "Failed to fetch game details",
                        message: "An Error occured while fetching game details.\nPlease check your connection and try again.",
                        openSettings: false) {
                            self.fetchGameDetails(for: gameID, completion: completion)
                        }
                }
            }
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func numberOfGames() -> Int { return games.count }
    
    func viewDidLoad() {
        view?.setNavigationTitle(with: "GameStop")
        view?.prepareCollectionView()
        fetchGames(page: currentPage)
    }
    
    func viewWillAppear() {
        
    }
    
    func cellForItem(at indexPath: IndexPath) -> Result? {
        return games[safe: indexPath.item]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard let game = games[safe: indexPath.item] else { return }
        guard let gameId = game.id else { return }
        
        fetchGameDetails(for: gameId) { [weak self] gameDetail in
            guard let self = self else { return }
            guard let gameDetail = gameDetail else {
                self.view?.showAlert(
                    title: "No Details",
                    message: "Details for the selected game could not be fetched.",
                    openSettings: false) { }
                return
            }
            self.view?.navigateToDetailScreen(with: game, withDetail: gameDetail)
        }
    }
    
    func fetchNextPage() {
        fetchGames(page: currentPage)
    }
}
