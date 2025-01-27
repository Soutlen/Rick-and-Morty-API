//
//  Character.swift
//  Rick and Morty
//
//  Created by Евгений Глоба on 1/14/25.
//

import Foundation

struct CharacterAPI: Decodable { let results: [CharacterResult] }

struct CharacterResult: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var image: String
    var location: Location
}

struct Location: Decodable {
    let name: String
}
