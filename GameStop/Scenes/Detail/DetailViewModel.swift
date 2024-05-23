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
    var games: [Result] { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func cellForItem(at indexPath: IndexPath) -> Result?
    func toggleLike(for game: Result)
    func isGameLiked(id: Int) -> Bool
}

final class DetailViewModel {
    weak var view: DetailViewControllerProtocol?
    weak var favoriteViewDelegate: FavoriteViewControllerProtocol?
    private(set) var games: [Result]
    
    init(view: DetailViewControllerProtocol? = nil, games: [Result] = []) {
        self.view = view
        self.games = games
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func viewDidLoad() {
        view?.prepareCollectionView()
    }
    
    func viewWillAppear() {
        view?.prepareNavigationBar(with: .clear)
    }
    
    func cellForItem(at indexPath: IndexPath) -> Result? {
        return games[safe: indexPath.item]
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
            favoriteViewDelegate?.favoritesDidUpdate()
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
    
}
