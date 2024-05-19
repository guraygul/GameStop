//
//  NetworkServiceProtocol.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

protocol APIEndpoint {
    var url: URL? { get }
}

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from endpoint: APIEndpoint, as type: T.Type) async throws -> T
}
