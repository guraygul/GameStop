//
//  HomeViewModel.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var view: HomeViewControllerProtocol? { get set }
    var gamesCount: Int { get }
    var games: [Result] { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func didSelectItem(at indexPath: IndexPath)
    func cellForItem(at indexPath: IndexPath) -> Result?
    func fetchNextPage()
}

final class HomeViewModel {
    weak var view: HomeViewControllerProtocol?
    private let networkService: NetworkServiceProtocol
    
    private(set) var games: [Result] = []
    
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
                let gameModel = try await networkService.fetchData(from: GameAPI.games(page: page),
                                                                   as: GameModel.self)
                self.games += gameModel.results ?? []
                self.hasMoreGames = gameModel.next != nil
                self.currentPage += 1
                DispatchQueue.main.async { [weak self] in
                    self?.view?.reloadData()
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.showAlert(title: "Error fetching games",
                                         message: "You're not connected to the internet. Please check your connection and try again.",
                                         openSettings: true) {
                        self.fetchGames(page: page)
                    }
                }
            }
            isFetching = false
        }
    }
    
    func fetchNextPage() {
        fetchGames(page: currentPage)
    }
    
}

extension HomeViewModel: HomeViewModelProtocol {
    var gamesCount: Int {
        return games.count
    }
    
    func viewDidLoad() {
        view?.prepareCollectionView()
        fetchGames(page: currentPage)
    }
    
    func viewWillAppear() {
        
    }
    
    func cellForItem(at indexPath: IndexPath) -> Result? {
        return games[safe: indexPath.item]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }
    
}
