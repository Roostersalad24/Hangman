//
//  CharcuterieViewController.swift
//  Hangman
//
//  Created by Andrew Johnson on 9/11/24.
//

import UIKit

class CharcuterieViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var guesses: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet weak var letterStack: UIStackView!
    
    
    var wordBank = ["PROSCIUTTO", "SALAMI", "CAPICOLA", "CHORIZO”, ”BRESAOLA", "PEPPERONI", "TURKEY", "HAM", "LIVERWURST", "SERRANO", "COPPA", "TURKEY", "JAM", "BACON", "CHEESE", "CHEDDAR", "GORGONZOLA", "BLUECHEESE", "HAVARTI", "PARMESAN", "SWISS", "CREAMCHEESE", "RICOTTA", "FETA", "PEPPERJACK", "OLIVES", "ARTICHOKES", "NUTS", "FRUIT", "HONEY", "JAM", "CRACKERS", "JELLY", "BRIE", "ALMONDS", "WALNUTS", "PECANS", "CASHEWS", "PISTACHIOS", "HAZELNUTS", "MACADAMIA", "CHESTNUTS", "FETA", "GRAPES", "BERRIES", "PRETZELS", "CUCUMBER", "RASPBERRY", "BLACKBERRY", "BLUEBERRY", "STRAWBERRY", "CAVIAR", "CARROT", "CELERY"]
    
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
        
        

        /*  let blur = UIVisualEffectView(effect: UIBlurEffect(style:
                                                                UIBlurEffect.Style.light))
        blur.frame = letterStack.bounds
        blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
       
        letterStack.insertSubview(blur, at: 0) */
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "charcuterie8.pdf")!)
    }
        var currentGame: Hangman!
        
    func newSet() {
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
    func updateUI(wordColor: UIColor = .black) {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        correctWordLabel.textColor = wordColor  // Set the color of the word label
        
        scoreLabel.text = "Wins: \(winsInAll), Losses: \(losesInAll)"
        guesses.text = "Guesses Left: \(currentGame.incorrectGuessesRemaining)"
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "charcuterie\(currentGame.incorrectGuessesRemaining)")!)
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
        if currentGame.isGameWon {
            updateUI(wordColor: .green)  // Set word color to green if won
            enableLetterButtons(false)   // Disable buttons on win
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.winsInAll += 1
                self.newSet()             // Start a new game
            }
        } else if currentGame.isGameLost {
            updateUI(wordColor: .red)  // Set word color to red if lost
            enableLetterButtons(false)   // Disable buttons on loss
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.losesInAll += 1
                self.newSet()             // Start a new game
            }
        } else {
            updateUI()  // Continue updating the UI during normal play
        }
    }

    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
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


