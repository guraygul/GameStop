//
//  GameTrailerModel.swift
//  GameStop
//
//  Created by Güray Gül on 25.05.2024.
//

import Foundation

// MARK: - GameTrailerModelResult
struct GameTrailerModelResult: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameTrailer]
}

// MARK: - GameTrailer
struct GameTrailer: Decodable {
    let id: Int
    let name: String
    let preview: String
    let data: TrailerData
}

// MARK: - TrailerData
struct TrailerData: Decodable {
    let low: URL?
    let high: URL?
    
    enum CodingKeys: String, CodingKey {
        case low = "480"
        case high = "max"
    }
}
