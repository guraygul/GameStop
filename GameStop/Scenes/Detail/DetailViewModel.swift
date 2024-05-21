//
//  DetailViewModel.swift
//  GameStop
//
//  Created by Güray Gül on 21.05.2024.
//

import Foundation

protocol DetailViewModelProtocol {
    var view: DetailViewControllerProtocol? { get set }
    var games: [Result] { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func cellForItem(at indexPath: IndexPath) -> Result?
}

final class DetailViewModel {
    weak var view: DetailViewControllerProtocol?
    
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
        
    }
    
    func cellForItem(at indexPath: IndexPath) -> Result? {
        return games[safe: indexPath.item]
    }
    
}
