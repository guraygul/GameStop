//
//  SearchViewModel.swift
//  GameStop
//
//  Created by Güray Gül on 22.05.2024.
//

import Foundation

protocol SearchViewModelProtocol {
    var view: SearchViewControllerProtocol? { get set }
    
    func viewDidLoad()
}

final class SearchViewModel {
    weak var view: SearchViewControllerProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    func viewDidLoad() {
        view?.prepareCollectionView()
    }
    
    
}
