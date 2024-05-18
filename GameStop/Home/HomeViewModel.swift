//
//  HomeViewModel.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    
    private func fetchGames() {
        
//        GameManager.shared.fetchGames { [weak self] in
//            guard let self = self else { return }
//            
//            self.view?.reloadData()
//        }
    }
}

extension HomeViewModel: HomeViewModelInterface {
    func viewDidLoad() {
        view?.prepareCollectionView()
        fetchGames()
    }
    
    func viewWillAppear() {
        
    }
    
    
}
