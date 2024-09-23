//
//  BroccoliViewController.swift
//  Hangman
//
//  Created by Andrew Johnson on 9/11/24.
//

import UIKit

class BroccoliViewController: UIViewController {
   
    @IBOutlet weak var letterStack: UIStackView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet weak var guesses: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var wordBank = ["CHICKEN", "BEEF", "PORK", "FISH", "VEGETABLES", "CARROT", "CELERY", "ONION", "GARLIC", "GINGER", "POTATO", "TOMATO", "CABBAGE", "SPINACH", "BROCCOLI", "PEAS", "LENTILS", "RICE", "NOODLES", "CORN", "MUSHROOM", "BEANS", "HERBS", "THYME", "BAYLEAF", "BASIL", "OREGANO", "CHILI", "CUMIN", "SALT", "PEPPER", "LEMON", "LIME", "VINEGAR", "CREAM", "BROTH", "STOCK", "SOURCREAM", "PARSLEY", "DILL", "CILANTRO", "ZUCCHINI", "SCALLIONS", "RADISH","SHRIMP", "CLAMS", "CRAB", "HOMINY", "BARLEY", "QUINOA", "FENNEL", "LEEK", "BACON”, “TURNIP”, “CELERY"]
    
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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "broccoli8.pdf")!)
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
            guesses.text = "Guesses Left: \(currentGame.incorrectGuessesRemaining)"
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "broccoli\(currentGame.incorrectGuessesRemaining)")!)
            
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
