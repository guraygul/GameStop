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
    var likedGames: [GameDetailModel] { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func fetchLikedGames()
}

final class FavoriteViewModel {
    weak var view: FavoriteViewControllerProtocol?
    private(set) var likedGames: [GameDetailModel] = []
    
    private let networkService: NetworkServiceProtocol
    private let coreDataManager: CoreDataManager
    private let queue = DispatchQueue(label: "com.example.FavoriteViewModel.queue",
                                      attributes: .concurrent)
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared,
         coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }
    
    private func fetchGameDetails(for gameIDs: [Int]) {
        Task {
            var fetchedGames: [GameDetailModel] = []
            for id in gameIDs {
                do {
                    let gameDetail = try await networkService.fetchData(from: GameAPI.gameDetails(id: id),
                                                                        as: GameDetailModel.self)
                    fetchedGames.append(gameDetail)
                } catch {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.view?.showAlert(title: "Failed to fetch game details",
                                             message: "You're not connected to the internet. Please check your connection and try again.",
                                             openSettings: false) {
                        }
                    }
                }
            }
            await MainActor.run { [fetchedGames] in
                likedGames = fetchedGames
                view?.prepareCollectionView()
            }
        }
    }
}

extension FavoriteViewModel: FavoriteViewModelProtocol {
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        fetchLikedGames()
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
            print("Failed to fetch liked games: \(error)")
        }
    }
}
