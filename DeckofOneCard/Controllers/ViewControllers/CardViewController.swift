//
//  ViewController.swift
//  DeckofOneCard
//
//  Created by Tasuku Yamamoto on 4/26/22.
//

import UIKit

class CardViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var valueOfSuitLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - IBActions
    @IBAction func drawButtonTapped(_ sender: UIButton) {
        CardController.fetchCard { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self?.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    //MARK: - Helper Methods
    func fetchImageAndUpdateViews(for card: Card){
    
        CardController.fetchImage(for: card) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.valueOfSuitLabel.text = "\(card.value) of \(card.suit)"
                    self?.cardImageView.image = image
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
        
        
    }//End of function

}//End of class

