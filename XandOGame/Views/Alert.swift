//
//  Alert.swift
//  XandOGame
//
//  Created by Roman Korobskoy on 29.03.2022.
//

import Foundation
import UIKit

func showAlert(controller: UIViewController, title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
    
    alert.addAction(okAction)
    DispatchQueue.main.async {
        controller.present(alert, animated: true, completion: nil)
    }
}
