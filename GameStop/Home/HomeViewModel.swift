//
//  HomeViewModel.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    var gamesCount: Int { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func didSelectItem(at indexPath: IndexPath)
    func cellForItem(at indexPath: IndexPath) -> Result?
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    private var games: [Result] = []
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    private func fetchGames() {
        Task {
            do {
                let gameModel = try await networkService.fetchData(
                    from: GameAPI.games(
                        page: 1
                    ),
                    as: GameModel.self
                )
                self.games = gameModel.results ?? []
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.reloadData()
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.showError("Error fetching games: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension HomeViewModel: HomeViewModelInterface {
    var gamesCount: Int {
        return games.count
    }
    
    func viewDidLoad() {
        view?.prepareCollectionView()
        fetchGames()
    }
    
    func viewWillAppear() {
        
    }
    
    func cellForItem(at indexPath: IndexPath) -> Result? {
        return games[safe: indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }
    
}
