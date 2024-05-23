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
    let id: Int?
    let saturatedColor: String?
    let dominantColor: String?

    enum CodingKeys: String, CodingKey {
        case slug, name, released, id
        case backgroundImage = "background_image"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
    }
}
