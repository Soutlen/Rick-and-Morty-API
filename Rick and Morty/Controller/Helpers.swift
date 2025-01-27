//
//  Helpers.swift
//  Rick and Morty
//
//  Created by Евгений Глоба on 1/17/25.
//

import Foundation

func waringMessage (error: NetworkError) -> String {
    switch error {
    case .noData:
        return "Data cannot be found at this URL"
    case .tooManyRequests:
        return "429: Too many requests"
    case .decodingError:
        return "Can't decode data"
    }
}
