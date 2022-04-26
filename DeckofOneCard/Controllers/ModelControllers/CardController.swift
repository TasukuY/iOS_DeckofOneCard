//
//  CardController.swift
//  DeckofOneCard
//
//  Created by Tasuku Yamamoto on 4/26/22.
//

import Foundation
import UIKit

class CardController{
    
    //MARK: - Helper Methods
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        // 1 - Prepare URL
        guard let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/")
        else { return completion(.failure(.invalidURL)) }
        
        let drawOneCardEndpoint = "draw/"
        let drawCardURL = baseURL.appendingPathComponent(drawOneCardEndpoint)
        var urlComponents = URLComponents(url: drawCardURL, resolvingAgainstBaseURL: true)
        let queryItem = URLQueryItem(name: "count", value: "1")
        urlComponents?.queryItems = [queryItem]
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL)) }
        print("URL: \(finalURL)")
        
        // 2 - Contact server
        let dataTask = URLSession.shared.dataTask(with: drawCardURL) { data, response, error in
            // 3 - Handle errors from the server
            if let error = error {
                print("Error while accessing the server: \(error.localizedDescription)")
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Check for json data
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5 - Decode json into a Card
            do{
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                if let firstCard = topLevelObject.cards.first {
                    return completion(.success(firstCard))
                }else {
                    print("Error while drawing the first card")
                    return completion(.failure(.noData))
                }
            }catch let decodingError{
                print("Error while decoding the data: \(decodingError.localizedDescription)")
                return completion(.failure(.thrownError(decodingError)))
            }
        }
        dataTask.resume()
    }//End of function
    
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void){
        // 1 - Prepare URL
        let imageURL = card.image
        // 2 - Contact server
        let dataTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            // 3 - Handle errors from the server
            if let error = error {
                print("Error while accessing the image URL: \(error.localizedDescription)")
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Check for image data
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5 - Initialize an image from the data
            guard let cardImage = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(cardImage))
        }
        dataTask.resume()
    }//End of function
    
}//End of class


