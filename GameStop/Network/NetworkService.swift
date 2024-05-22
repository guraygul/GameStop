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
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse {
                if !(200...299).contains(httpResponse.statusCode) {
                    throw NetworkError.invalidResponse
                }
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingError(error)
            }
        } catch {
            throw error
        }
    }
}
