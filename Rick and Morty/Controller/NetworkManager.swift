//
//  NetworkManager.swift
//  Rick and Morty
//
//  Created by Евгений Глоба on 1/14/25.
//

import Foundation

// MARK: - LinkCharacter Enum
enum LinkCharacter {
    case character(page: Int)
    
    var url: URL {
        switch self {
        case .character(let page):
            return URL(string: "https://rickandmortyapi.com/api/character?page=\(page)")!
        }
    }
}

enum LinkEpisode {
    case episode(page: Int)
    var url: URL {
        switch self {
        case .episode(let page):
            return URL(string: "https://rickandmortyapi.com/api/episode?page=\(page)")!
        }
    }
}

enum NetworkError:  Error {
    case noData
    case tooManyRequests
    case decodingError
}

// MARK: -Network Manager
final class NetworkManager: ObservableObject {

    static let shared = NetworkManager()
    private init() {}
    
    // MARK: - Fetch Characters
    static func fetchCharacters(page: Int) async throws -> [CharacterResult] {
            print("Try to fetch characters for page: \(page)...")
            
            let fetchRequest = URLRequest(url: LinkCharacter.character(page: page).url)

            let (data, response) = try await URLSession.shared.data(for: fetchRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }
            
            print("Status code: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode == 429 {
                throw NetworkError.tooManyRequests
            }

            guard let safeData = data as Data? else {
                throw NetworkError.noData
            }

            do {
                let decodedQuery = try JSONDecoder().decode(CharacterAPI.self, from: safeData)
                return decodedQuery.results
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                throw NetworkError.decodingError
            }
        }
    //MARK: -Fetch Episodes
    static func fetchEpisodes(page: Int) async throws -> [EpisodeResult] {
            print("Try to fetch characters for page: \(page)...")
            
        let fetchRequest = URLRequest(url: LinkEpisode.episode(page: page).url)

            let (data, response) = try await URLSession.shared.data(for: fetchRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }
            
            print("Status code: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode == 429 {
                throw NetworkError.tooManyRequests
            }

            guard let safeData = data as Data? else {
                throw NetworkError.noData
            }

            do {
                let decodedQuery = try JSONDecoder().decode(EpisodeAPI.self, from: safeData)
                return decodedQuery.results
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                throw NetworkError.decodingError
            }
        }

}

