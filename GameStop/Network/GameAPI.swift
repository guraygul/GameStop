//
//  GameAPI.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

enum GameAPI: APIEndpoint {
    case games(page: Int)
    case gameDetails(id: Int)
    
    var url: URL? {
        switch self {
        case .games(let page):
            return URL(string: "\(Constants.upcomingURL)\(page)")
        case .gameDetails(id: let id):
            return URL(string: "\(Constants.baseURL)/\(id)\(Constants.beforeKey)\(Constants.APIKEY)")
        }
    }
}
