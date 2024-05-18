//
//  NetworkService.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchData<T: Decodable>(from endpoint: APIEndpoint, as type: T.Type) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
