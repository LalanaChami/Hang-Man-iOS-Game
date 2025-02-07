//
//  ViewController.swift
//  HangMan
//
//  Created by Lalana Thanthirigama on 2024-10-14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var labels: [UILabel]!
    
    @IBOutlet weak var winCount: UILabel!
    @IBOutlet weak var lossCount: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    var letters: [Character] = []
    var coloredButtonList: [UIButton] = []
    var failedAttempts: Int = 0
    var word: String = ""
    var successAttempts: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    private func startGame() {
        word = getRandomWord()
        print(word)
        letters = Array(word)
        
    }
    
    private func getRandomWord() -> String {
        return sevenLetterWords.randomElement()!
    }
    
    @IBAction func onKeybordBtnClick(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "")
        var isAttemptSuccess: Bool = false
        
        for (index, value) in letters.enumerated() {
            if (sender.titleLabel?.text == String(value)) {
                labels[index].text = String(value)
                successAttempts += 1
                isAttemptSuccess = true
                sender.backgroundColor = .green
                coloredButtonList.append(sender)
            }
        }
        
        if (!isAttemptSuccess) {
            failedAttempts += 1
            hangmanImage.image = UIImage(named: "img_\(failedAttempts)")
            sender.backgroundColor = .red
            coloredButtonList.append(sender)
            if (failedAttempts == 7) {
                lossCount.text = String((Int(lossCount.text ?? "0") ?? 0) + 1)
                showAlert(isSuccess: false)
            }
        } else {
            if (successAttempts == 7) {
                winCount.text = String((Int(winCount.text ?? "0") ?? 0) + 1)
                showAlert(isSuccess: true)
            }
        }
    }
    
    func showAlert(isSuccess: Bool) {
        if isSuccess {
            let alert = UIAlertController(title: "Woohoo!", message: "You saved me! Would you like to play again?.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { _ in
                // reset the game
                self.resetGame()
                alert.dismiss(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "No",
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            
            DispatchQueue.main.async {
                self.present(alert, animated: false, completion: nil)
            }
            
        } else {
            let alert = UIAlertController(title: "Uh oh", message: "The correct word was \(self.word). Would you like to try again?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { _ in
                // restart the previous game
                self.restartPreviousGame()
                alert.dismiss(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "No",
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            
            DispatchQueue.main.async {
                self.present(alert, animated: false, completion: nil)
            }
        }
    }
    
    func resetGame() {
        // rest background color of keyboad buttons
        coloredButtonList.forEach { $0.backgroundColor = .clear }
        
        // clearing labels
        labels.forEach { $0.text = "" }
        
        // clear the image
        hangmanImage.image = UIImage(named: "img_1")
        
        failedAttempts = 0
        
        // Start new game
        startGame()
    }
    
    
    func restartPreviousGame() {
        // rest background color of keyboad buttons
        coloredButtonList.forEach { $0.backgroundColor = .clear }
        
        // clearing labels
        labels.forEach { $0.text = "" }
        
        failedAttempts = 0
        
        // clear the image
        hangmanImage.image = UIImage(named: "img_1")
        
    }
}

