//
//  UIViewController+ShowAlert.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/18/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

