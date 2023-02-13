//
//  ViewController+extensions.swift
//  Flash Chat iOS13
//
//  Created by Idwall Go Dev 003 on 23/04/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Authentication", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
