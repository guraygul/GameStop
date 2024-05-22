//
//  Constants.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

struct Constants {
    static let APIKEY = "5b39ec7fccc64f4896fb6b7c12c9ab0d"
    static let baseURL = "https://api.rawg.io/api/games"
    static let beforeKey = "?key="
    static let upcomingURL = baseURL + beforeKey + APIKEY + "&page="
}
