//
//  CardError.swift
//  DeckofOneCard
//
//  Created by Tasuku Yamamoto on 4/26/22.
//

import Foundation

enum CardError: LocalizedError {
    //What developers see
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    //What users see
    var errorDescription: String? {
        switch self{
        case .invalidURL:
            return "Internal error. Please update Deck of One Card or contact support."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        }
    }
    
}//End of enum

