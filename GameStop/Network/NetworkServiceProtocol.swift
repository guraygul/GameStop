//
//  NetworkServiceProtocol.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

// Protocol for API Endpoint
protocol APIEndpoint {
    var url: URL? { get }
}

// Protocol for Network Service
protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from endpoint: APIEndpoint, as type: T.Type) async throws -> T
}
