//
//  GameTrailerModel.swift
//  GameStop
//
//  Created by Güray Gül on 25.05.2024.
//

import Foundation

// MARK: - Welcome
struct GameTrailerModel: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
}

// MARK: - Result
struct GameTrailerModelResult: Decodable {
    let id: Int?
    let name: String?
    let preview: String?
    let data: GameTrailerModelResultTrailers?
}

// MARK: - DataClass
struct GameTrailerModelResultTrailers: Decodable {
    let the480: String?
    let max: String?

    enum CodingKeys: String, CodingKey {
        case max
        case the480 = "480"
    }
}
