//
//  DetailViewModel.swift
//  GameStop
//
//  Created by Güray Gül on 21.05.2024.
//

import Foundation
import CoreData

protocol DetailViewModelProtocol {
    var view: DetailViewControllerProtocol? { get set }
    var favoriteViewDelegate: FavoriteViewControllerProtocol? { get set }
    var game: [Result] { get set }
    var gameDetails: [GameDetailModel] { get set }
    var gameTrailers: [GameTrailerModelResultTrailers] { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func cellForItem(at indexPath: IndexPath) -> Result?
    func cellForItemForDetail(at indexPath: IndexPath) -> GameDetailModel?
    func toggleLike(for game: Result)
    func isGameLiked(id: Int) -> Bool
    func numberOfGameScreenshots() -> Int
}

final class DetailViewModel {
    weak var view: DetailViewControllerProtocol?
    weak var favoriteViewDelegate: FavoriteViewControllerProtocol?
    private let networkService: NetworkServiceProtocol
    
    var game: [Result]
    var gameDetails: [GameDetailModel] = []
    private(set) var gameTrailers: [GameTrailerModelResultTrailers] = []
    
    init(view: DetailViewControllerProtocol? = nil,
         game: [Result] = [],
         gameDetails: [GameDetailModel] = [],
         networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.view = view
        self.game = game
        self.gameDetails = gameDetails
        self.networkService = networkService
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func viewDidLoad() {
        view?.prepareCollectionView()
        if let gameID = game.first?.id {
            fetchGameDetails(for: gameID)
        }
    }
    
    func viewWillAppear() {
        view?.prepareNavigationBar(with: .clear)
    }
    
    func cellForItem(at indexPath: IndexPath) -> Result? {
        return game[safe: indexPath.item]
    }
    
    func cellForItemForDetail(at indexPath: IndexPath) -> GameDetailModel? {
        return gameDetails[safe: indexPath.item]
    }
    
    func toggleLike(for game: Result) {
        guard let id = game.id else { return }
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let entity = results.first {
                entity.isLiked.toggle()
            } else {
                let newEntity = GameEntity(context: context)
                newEntity.id = Int64(id)
                newEntity.isLiked = true
            }
            CoreDataManager.shared.saveContext()
        } catch {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.view?.showAlert(
                    title: "Failed when toggling like",
                    message: "An Error occured while liking.\nPlease try again.",
                    openSettings: false) {
                        self.toggleLike(for: game)
                }
            }
        }
    }
    
    func isGameLiked(id: Int) -> Bool {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first?.isLiked ?? false
        } catch {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.view?.showAlert(
                    title: "Failed to fetch game's like status",
                    message: "An Error occured while fething game's like status.\nPlease check your connection and try again.",
                    openSettings: false) { }
            }
            return false
        }
    }
    
    func numberOfGameScreenshots() -> Int {
        return game.reduce(0) { $0 + ($1.shortScreenshots?.count ?? 0) }
    }
    
//    private func fetchGameTrailers(for gameID: Int, completion: @escaping (GameTrailerModelResultTrailers?) -> Void) {
//        Task {
//            do {
//                let gameDetail = try await networkService.fetchData(
//                    from: GameAPI.gameTrailers(id: gameID),
//                    as: GameTrailerModelResultTrailers.self)
//                completion(gameDetail)
//            } catch {
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else { return }
//                    self.view?.showAlert(
//                        title: "Failed to fetch game details",
//                        message: "An Error occured while fetching game details.\nPlease check your connection and try again.",
//                        openSettings: false) {
//                            self.fetchGameTrailers(for: gameID, completion: completion)
//                        }
//                }
//            }
//        }
//    }
    
    func fetchGameDetails(for gameID: Int) {
        Task {
            do {
                let gameDetail = try await networkService.fetchData(
                    from: GameAPI.gameDetails(id: gameID),
                    as: GameDetailModel.self)
                self.gameDetails.append(gameDetail)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.reloadData()
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view?.showAlert(
                        title: "Failed to fetch game details",
                        message: "An Error occurred while fetching game details.\nPlease check your connection and try again.",
                        openSettings: false) {
                            self.fetchGameDetails(for: gameID)
                        }
                }
            }
        }
    }
    
}
