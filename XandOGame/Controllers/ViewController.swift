//
//  ViewController.swift
//  XandOGame
//
//  Created by Roman Korobskoy on 29.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        guard !nameField.text!.trimmingCharacters(in: .whitespaces).isEmpty else {
            nameErrorLabel.isHidden = false
            return
        }
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        controller.playerName = nameField.text
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
}

