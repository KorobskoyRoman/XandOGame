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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        startButton.layer.cornerRadius = 10
        alertView.layer.cornerRadius = 10
        alertView.layer.shadowOpacity = 0.4
        alertView.layer.shadowColor = UIColor.black.cgColor
        alertView.layer.shadowRadius = 10
        alertView.layer.shadowOffset = .zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameField.resignFirstResponder()
    }
}

