//
//  GameModel.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

// MARK: - GameModel
struct GameModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating
        case backgroundImage = "background_image"
    }
}
