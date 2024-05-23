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
    case search(page: Int, name: String)
    
    var url: URL? {
        switch self {
        case .games(let page):
            return URL(string: "\(Constants.baseURLWithAPI)\(page)")
        case .gameDetails(let id):
            return URL(string: "\(Constants.baseURL)/\(id)\(Constants.beforeKey)\(Constants.APIKEY)")
        case .search(let page, let name):
            let query = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return URL(string: "\(Constants.baseURLWithAPI)\(page)\(Constants.search)\(query)")
        }
    }
}
