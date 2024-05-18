//
//  GameAPI.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

enum GameAPI: APIEndpoint {
    case games(page: Int)
    
    var url: URL? {
        switch self {
        case .games(let page):
            return URL(string: "\(Constants.upcomingURL)\(page)")
        }
    }
}
