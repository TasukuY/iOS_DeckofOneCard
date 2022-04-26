//
//  UIViewControllerExtension.swift
//  DeckofOneCard
//
//  Created by Tasuku Yamamoto on 4/26/22.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }//End of function
    
}//End of extension
