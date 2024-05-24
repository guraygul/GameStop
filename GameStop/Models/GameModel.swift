//
//  GameModel.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

// MARK: - GameModel
struct GameModel: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
}

// MARK: - Result
struct Result: Decodable {
    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let metacritic: Int?
    let shortScreenshots: [ShortScreenshot]?

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating, metacritic
        case ratingTop = "rating_top"
        case backgroundImage = "background_image"
        case shortScreenshots = "short_screenshots"
    }
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Decodable {
    let id: Int?
    let image: String?
}

// MARK: - Result Extension
extension Result {
    init(from searchResult: SearchResult) {
        self.id = searchResult.id
        self.name = searchResult.name
        self.released = searchResult.released
        self.backgroundImage = searchResult.backgroundImage
        self.rating = searchResult.rating
        self.ratingTop = searchResult.ratingTop
        self.metacritic = searchResult.metacritic
        self.shortScreenshots = searchResult.shortScreenshots
    }
}

