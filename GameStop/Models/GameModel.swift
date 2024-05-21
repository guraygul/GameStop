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

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating, metacritic
        case ratingTop = "rating_top"
        case backgroundImage = "background_image"
    }
}
