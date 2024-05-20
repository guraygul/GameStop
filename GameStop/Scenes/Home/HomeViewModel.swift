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
    var games: [Result] { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func didSelectItem(at indexPath: IndexPath)
    func cellForItem(at indexPath: IndexPath) -> Result?
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    private let networkService: NetworkServiceProtocol
    
    private(set) var games: [Result] = []
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    private func fetchGames() {
        Task {
            do {
                let gameModel = try await networkService.fetchData(from: GameAPI.games(page: 1),
                                                                   as: GameModel.self)
                self.games = gameModel.results ?? []
                DispatchQueue.main.async { [weak self] in
                    self?.view?.reloadData()
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.showAlert(title: "Error fetching games",
                                         message: "You're not connected to the internet. Please check your connection and try again.",
                                         openSettings: true)
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
