//
//  ViewController.swift
//  Hangman
//
//  Created by Andrew Johnson on 8/24/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var guessing: UIImageView!
    

    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    var wordBank = ["chocolate", "vanilla", "cherry", "strawberry", "mint"]
    
    let incorrectLettersTolerated = 8
    
    var winsInAll = 0 {
        didSet {
            newSet()
        }
    }
    var losesInAll = 0 {
        didSet {
            newSet()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newSet()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "split8.pdf")!)
    }
        var currentGame: Hangman!
        
    func newSet () {
        if !wordBank.isEmpty {
            let newWord = wordBank.randomElement()!
            currentGame = Hangman(word: newWord, incorrectGuessesRemaining: incorrectLettersTolerated, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
        
        func enableLetterButtons(_ enable: Bool) {
            for button in letterButtons {
                button.isEnabled = enable
            }
        }
    }
    
        func updateUI() {
            var letters = [String]()
            for letter in currentGame.formattedWord {
                letters.append(String(letter))
            }
            let wordWithSpacing = letters.joined(separator: " ")
            correctWordLabel.text = wordWithSpacing
            scoreLabel.text = "Wins: \(winsInAll), Losses: \(losesInAll)"
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "split\(currentGame.incorrectGuessesRemaining)")!)
            
        }
    
    func newGame() {
        let newWord = wordBank.removeFirst()
        currentGame = Hangman(word: newWord, incorrectGuessesRemaining: incorrectLettersTolerated, guessedLetters: [])
        updateUI()
    }


    

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateHangmanGame()
    }
    
    func updateHangmanGame() {
        if currentGame.incorrectGuessesRemaining == 0 {
            losesInAll += 1
        } else if currentGame.word == currentGame.formattedWord {
            winsInAll += 1
        } else {
            updateUI()
        }
    }
    
   
    
}

