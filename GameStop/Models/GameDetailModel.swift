//
//  GameDetailModel.swift
//  GameStop
//
//  Created by Güray Gül on 22.05.2024.
//

import Foundation

// MARK: - GameDetailModel
struct GameDetailModel: Decodable {
    let id: Int?
    let name: String?
    let nameOriginal: String?
    let description: String?
    let metacritic: Int?
    let released: String?
    let backgroundImage: String?
    let backgroundImageAdditional: String?
    let website: String?
    let rating: Double?
    let ratingTop: Int?
    let metacriticURL: String?
    let saturatedColor: String?
    let dominantColor: String?
    let publishers: [Publisher]?
    let descriptionRaw: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, metacritic, released, website, rating, publishers
        case nameOriginal = "name_original"
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case ratingTop = "rating_top"
        case metacriticURL = "metacritic_url"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case descriptionRaw = "description_raw"
    }
}

// MARK: - Publisher
struct Publisher: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, gamesCount, imageBackground
    }
}
