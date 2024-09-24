//
//  SaladViewController.swift
//  Hangman
//
//  Created by Andrew Johnson on 9/18/24.
//

import UIKit

class SaladViewController: UIViewController {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var guesses: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet weak var letterStack: UIStackView!
    
    
    var wordBank = ["LETTUCE", "TOMATO", "CUCUMBER", "CARROT", "ONION", "BELLPEPPER", "SPINACH", "KALE", "ARUGULA", "AVOCADO", "CHICKEN", "TUNA", "FETA", "OLIVES", "EGG", "BACON", "CROUTON", "CHEESE", "PINEAPPLE", "STRAWBERRY", "ALMONDS", "WALNUTS", "PECAN", "CHICKPEA", "QUINOA", "FARRO", "MUSHROOM", "BEETS", "ARTICHOKE", "ZUCCHINI", "RADISH", "BROCCOLI", "CAULIFLOWER", "PEAR", "APPLE", "CRANBERRY", "BLUEBERRIES", "POMEGRANATE", "ORANGE", "CORN", "BLACKBEANS", "EDAMAME", "TOFU", "RICE", "BARLEY", "COUSCOUS", "HUMMUS", "GARBANZO", "PARMESAN", "ROMAINE", "DILL", "CILANTRO", "CAPERS", "CHAI", "VINEGAR", "GARLIC", "BASIL"]
    
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
        applyBlurEffect1()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "salad8.pdf")!)
    }
        var currentGame: Hangman!
        
    func newSet() {
        if !wordBank.isEmpty {
            let newWord = wordBank.randomElement()!
            currentGame = Hangman(word: newWord, incorrectGuessesRemaining: incorrectLettersTolerated, guessedLetters: [])
            enableLetterButtons(true)
            correctWordLabel.textColor = .black  // Reset text color to default
            updateUI()  // Update UI for the new word
        } else {
            enableLetterButtons(false)  // Disable buttons if no words are left
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
            guesses.text = "Guesses Left: \(currentGame.incorrectGuessesRemaining)"
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "salad\(currentGame.incorrectGuessesRemaining)")!)
            
        }
    
    func newGame() {
        let newWord = wordBank.removeFirst()
        currentGame = Hangman(word: newWord, incorrectGuessesRemaining: incorrectLettersTolerated, guessedLetters: [])
        updateUI()
    }


    

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString)
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            feedbackGenerator.impactOccurred()

        currentGame.playerGuessed(letter: letter)
        updateHangmanGame()
    }
    
    func updateHangmanGame() {
        if currentGame.incorrectGuessesRemaining == 0 {
            // Game lost - reveal the word in red
            currentGame.isGameOver = true  // Mark game as over
            correctWordLabel.textColor = .red
            showCorrectWord()
            losesInAll += 1
            disableLetterButtons()
            delayNewGame()
        } else if currentGame.word == currentGame.formattedWord {
            // Game won - reveal the word in green
            currentGame.isGameOver = true  // Mark game as over
            correctWordLabel.textColor = .green
            showCorrectWord()
            winsInAll += 1
            disableLetterButtons()
            
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                    feedbackGenerator.impactOccurred()
            
            delayNewGame()
        } else {
            updateUI()
            
            let feedbackGenerator = UIImpactFeedbackGenerator(style: currentGame.word.contains(currentGame.formattedWord) ? .light : .medium)
                    feedbackGenerator.impactOccurred()
        }
    }


    func showCorrectWord() {
        // Show the fully revealed correct word (no underscores)
        correctWordLabel.text = currentGame.formattedWord
    }


    func delayNewGame() {
        // Delay the start of the new game by 2 seconds to show the result
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newSet()  // Start a new game after a 2-second delay
        }
    }

    func disableLetterButtons() {
        for button in letterButtons {
            button.isEnabled = false
        }
    }


    
    
    
    func applyBlurEffect1() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = letterStack.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = false
        
        
        letterStack.addSubview(blurEffectView)
        letterStack.sendSubviewToBack(blurEffectView)
    }
    
   
   
   
    
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


