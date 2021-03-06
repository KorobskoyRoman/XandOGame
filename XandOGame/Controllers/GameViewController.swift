//
//  GameViewController.swift
//  XandOGame
//
//  Created by Roman Korobskoy on 29.03.2022.
//

import UIKit

class GameViewController: ViewController {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var computerScoreLabel: UILabel!
    
    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!
    
    var playerName: String!
    var lastValue = "o"
    var playerChoices: [Box] = []
    var compChoices: [Box] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerNameLabel.text = playerName + ":"
        
        createTap(on: box1, type: .one)
        createTap(on: box2, type: .two)
        createTap(on: box3, type: .three)
        createTap(on: box4, type: .four)
        createTap(on: box5, type: .five)
        createTap(on: box6, type: .six)
        createTap(on: box7, type: .seven)
        createTap(on: box8, type: .eight)
        createTap(on: box9, type: .nine)
    }
    
    private func createTap(on imageView: UIImageView, type box: Box) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.boxClicked(_:)))
        tap.name = box.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func boxClicked(_ sender: UITapGestureRecognizer) {
        let selectedBox = getBox(from: sender.name ?? "")
        makeChoice(selectedBox: selectedBox)
        playerChoices.append(Box(rawValue: sender.name!)!)
        checkIfWon()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.compPlay()
        }
    }
    
    private func compPlay() {
        var availableSpaces = [UIImageView]()
        var availableBoxes = [Box]()
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            if box.image == nil {
                availableSpaces.append(box)
                availableBoxes.append(name)
            }
        }
        
        guard availableBoxes.count > 0 else { return }
        
        let randIndex = Int.random(in: 0 ..< availableSpaces.count)
        makeChoice(selectedBox: availableSpaces[randIndex])
        compChoices.append(availableBoxes[randIndex])
        checkIfWon()
    }
    
    private func makeChoice(selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return }
        if lastValue == "x" {
            selectedBox.image = #imageLiteral(resourceName: "oh")
            lastValue = "o"
        } else {
            selectedBox.image = #imageLiteral(resourceName: "ex")
            lastValue = "x"
        }
    }
    
    private func checkIfWon() {
        var correct = [[Box]]()
        let firstRow: [Box] = [.one, .two, .three]
        let secondRow: [Box] = [.four, .five, .six]
        let thirdRow: [Box] = [.seven, .eight, .nine]
        
        let firstCol: [Box] = [.one, .four, .seven]
        let secondCol: [Box] = [.two, .five, .eight]
        let thirdCol: [Box] = [.three, .six, .nine]
        
        let firstSlash: [Box] = [.one, .five, .nine]
        let secondSlash: [Box] = [.three, .five, .seven]
        
        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(firstCol)
        correct.append(secondCol)
        correct.append(thirdCol)
        correct.append(firstSlash)
        correct.append(secondSlash)
        
        for valid in correct {
            let userMatch = playerChoices.filter{valid.contains($0)}.count
            let compMatch = compChoices.filter{valid.contains($0)}.count
            
            if userMatch == valid.count {
                playerScoreLabel.text = String((Int(playerScoreLabel.text ?? "0") ?? 0) + 1)
                showAlert(controller: self,
                          title: "Winner",
                          message: "The winner is \(playerName!)! Score is \(playerScoreLabel.text!)") { _ in
                    self.resetGame()
                }
                break
            } else if compMatch == valid.count {
                computerScoreLabel.text = String((Int(computerScoreLabel.text ?? "0") ?? 0) + 1)
                showAlert(controller: self,
                          title: "Loser!",
                          message: "The winner is computer! Score is \(computerScoreLabel.text!)") { _ in
                    self.resetGame()
                }
                break
            } else if compChoices.count + playerChoices.count == 9 {
                showAlert(controller: self, title: "Draw!", message: "That's a draw!") { _ in
                    self.resetGame()
                }
                break
            }
        }
    }
    
    private func resetGame() {
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            box.image = nil
        }
        lastValue = "o"
        playerChoices = []
        compChoices = []
    }
    
    private func getBox(from name: String) -> UIImageView {
        let box = Box(rawValue: name) ?? .one
        switch box {
        case .one:
            return box1
        case .two:
            return box2
        case .three:
            return box3
        case .four:
            return box4
        case .five:
            return box5
        case .six:
            return box6
        case .seven:
            return box7
        case .eight:
            return box8
        case .nine:
            return box9
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
