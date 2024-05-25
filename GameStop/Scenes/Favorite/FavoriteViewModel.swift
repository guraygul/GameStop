//
//  FavoriteViewModel.swift
//  GameStop
//
//  Created by Güray Gül on 22.05.2024.
//

import Foundation
import CoreData

protocol FavoriteViewModelProtocol {
    var view: FavoriteViewControllerProtocol? { get set }
    var likedGames: [Result] { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func fetchLikedGames()
    func cellForItem(at indexPath: IndexPath) -> Result?
}

final class FavoriteViewModel {
    weak var view: FavoriteViewControllerProtocol?
    private(set) var likedGames: [Result] = []
    
    private let networkService: NetworkServiceProtocol
    private let coreDataManager: CoreDataManager
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared,
         coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }
    
    private func fetchGameDetails(for gameIDs: [Int]) {
        Task {
            var fetchedGames: [Result] = []
            for id in gameIDs {
                do {
                    let gameDetail = try await networkService.fetchData(
                        from: GameAPI.gameDetails(id: id),
                        as: Result.self)
                    fetchedGames.append(gameDetail)
                } catch {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.view?.showAlert(
                            title: "Failed to fetch favorite games",
                            message: "An Error occured while fething favorite games.\nPlease check your connection and try again.",
                            openSettings: false) {
                                self.fetchGameDetails(for: gameIDs)
                            }
                    }
                }
            }
            await MainActor.run { [fetchedGames] in
                likedGames = fetchedGames
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.prepareCollectionView()
                }
            }
        }
    }
}

extension FavoriteViewModel: FavoriteViewModelProtocol {
    func viewDidLoad() {
        view?.setNavigationTitle(with: "Favorites")
        view?.prepareCollectionView()
        
    }
    
    func viewWillAppear() {
        fetchLikedGames()
    }
        
    func cellForItem(at indexPath: IndexPath) -> Result? {
        return likedGames[safe: indexPath.item]
    }
    
    func fetchLikedGames() {
        let context = coreDataManager.context
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isLiked == %d", true)
        
        do {
            let gameEntities = try context.fetch(fetchRequest)
            let gameIDs = gameEntities.map { Int($0.id) }
            fetchGameDetails(for: gameIDs)
        } catch {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.view?.showAlert(
                    title: "Fetch Error",
                    message: "Error while fetching favorite games",
                    openSettings: false) { }
            }
        }
    }
}
