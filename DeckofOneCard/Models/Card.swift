//
//  Card.swift
//  DeckofOneCard
//
//  Created by Tasuku Yamamoto on 4/26/22.
//

import Foundation

struct TopLevelObject: Decodable {
    let cards: [Card]
}//End of struct

struct Card: Decodable {
    let image: URL
    let value: String
    let suit: String
}//End of struct

