//
//  GameSearchModel.swift
//  GameStop
//
//  Created by Güray Gül on 22.05.2024.
//

import Foundation

// MARK: - Welcome
struct GameSearchModel: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [SearchResult]?
    let userPlatforms: Bool?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case userPlatforms = "user_platforms"
    }
}

// MARK: - Result
struct SearchResult: Decodable {
    let slug: String?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let id: Int?
    let saturatedColor: String?
    let dominantColor: String?
    let metacritic: Int?
    let shortScreenshots: [ShortScreenshot]?

    enum CodingKeys: String, CodingKey {
        case slug, name, released, id, metacritic, rating
        case backgroundImage = "background_image"
        case saturatedColor = "saturated_color"
        case ratingTop = "rating_top"
        case dominantColor = "dominant_color"
        case shortScreenshots = "short_screenshots"
    }
}
