//
//  Location.swift
//  Rick and Morty
//
//  Created by Евгений Глоба on 1/17/25.
//

import Foundation

struct EpisodeAPI: Decodable {
    let results: [EpisodeResult]
}

struct EpisodeResult: Decodable {
    let id: Int
    let name: String
}

