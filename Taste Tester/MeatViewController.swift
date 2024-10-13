//
//  MeatViewController.swift
//  Taste Tester
//
//  Created by Andrew Johnson on 10/8/24.
//

import UIKit

class MeatViewController: UIViewController {

   
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var guesses: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet weak var letterStack: UIStackView!
    
    @IBOutlet weak var hintButton: UIButton!
    
    var wordBank = ["RIBEYE", "TBONE", "PORTERHOUSE", "SIRLOIN", "FLAT IRON", "FLANK", "SKIRT STEAK", "HANGER", "TOMAHAWK", "DENVER STEAK", "TRI TIP", "CHUCK EYE", "RUMP ROAST", "LONDON BROIL", "SHORT RIBS", "PRIME RIB", "BRISKET", "CHUCK ROAST", "SHORT LOIN", "OXTAIL", "FLANK", "BABY BACK RIBS", "FLAT IRON", "PORK BELLY", "PORK CHOP", "PORK SHOULDER", "BEEF RIBS", "TOP ROUND", "BOTTOM ROUND", "NEW YORK STRIP", "FILET MIGNON", "PORK LOIN", "LAMB CHOP"]
    
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
        
        

        setBackgroundImage(named: "brisket8.pdf")
        }

        
    func setBackgroundImage(named imageName: String) {
        if let existingBackground = view.subviews.first(where: { $0 is UIImageView }) {
            existingBackground.removeFromSuperview()
        }

       
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false

     
        self.view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)

        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
        var currentGame: Hangman!
        
    func newSet() {
        if !wordBank.isEmpty {
            let newWord = wordBank.randomElement()!
            currentGame = Hangman(word: newWord, incorrectGuessesRemaining: incorrectLettersTolerated, guessedLetters: [])
            enableLetterButtons(true)
            disableGuessedLetterButtons()
            updateUI()
            hintButton.isEnabled = true
        } else {
            enableLetterButtons(false)
        }
    }
    
        func disableGuessedLetterButtons() {
               // Loop through each letter button and disable it if it's been guessed
               for button in letterButtons {
                   if let letterString = button.configuration?.title, let letter = letterString.first {
                       // If the letter is already in guessedLetters, disable the button
                       if currentGame.guessedLetters.contains(letter) {
                           button.isEnabled = false
                       }
                   }
               }
           }

        func enableLetterButtons(_ enable: Bool) {
            for button in letterButtons {
                button.isEnabled = enable
            }
        }
    
    
    func updateUI(wordColor: UIColor = .black) {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        correctWordLabel.textColor = wordColor

        scoreLabel.text = "Wins: \(winsInAll), Losses: \(losesInAll)"
        guesses.text = "Guesses Left: \(currentGame.incorrectGuessesRemaining)"

       
        setBackgroundImage(named: "brisket\(currentGame.incorrectGuessesRemaining)")
    }

    
    func newGame() {
        let newWord = wordBank.removeFirst()
        currentGame = Hangman(word: newWord, incorrectGuessesRemaining: incorrectLettersTolerated, guessedLetters: [])
        updateUI()
    }


    @IBAction func hintButtonPressed(_ sender: UIButton) {
        // Find a letter that hasn't been guessed yet
                let unguessedLetters = currentGame.word.filter { !currentGame.guessedLetters.contains($0) && $0 != " " }

                // If there are unguessed letters left, reveal one
                if let randomLetter = unguessedLetters.randomElement() {
                    currentGame.guessedLetters.append(randomLetter)
                    updateUI() // Update the word display with the newly revealed letter
                    disableGuessedLetterButtons() // Disable the button for the revealed letter
                }

                // Disable the hint button after it's used (optional: single-use hint)
                sender.isEnabled = false
            
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
            updateUI(wordColor: .green)
            enableLetterButtons(false)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.winsInAll += 1
                self.animateBackgroundToOriginal()
                self.newSet()
            }
        } else if currentGame.isGameLost {
            updateUI(wordColor: .red)
            enableLetterButtons(false)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.losesInAll += 1
                self.animateBackgroundToOriginal()
                self.newSet()
            }
        } else {
            updateUI()
        }
    }

    func animateBackgroundToOriginal() {
        UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            
            self.setBackgroundImage(named: "brisket8.pdf")
        }, completion: nil)
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


