//
//  Constants.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

struct Constants {
    static let APIKEY = "?key=5b39ec7fccc64f4896fb6b7c12c9ab0d"
    static let baseURL = "https://api.rawg.io/api/games"
    static let search = "&search="
    static let page = "&page="
    static let movies = "movies"
    static let baseURLWithAPI = baseURL + APIKEY + page
}
