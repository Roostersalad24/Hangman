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
    
    
    var wordBank = ["LETTUCE", "TOMATO", "CUCUMBER", "CARROT", "ONION", "BELLPEPPER", "SPINACH", "KALE", "ARUGULA", "AVOCADO", "CHICKEN", "TUNA", "FETA", "OLIVES", "EGG", "BACON", "CROUTON", "CHEESE", "PINEAPPLE", "STRAWBERRY", "ALMONDS", "WALNUTS", "PECAN", "CHICKPEA", "QUINOA", "FARRO", "MUSHROOM", "BEETS", "ARTICHOKE", "ZUCCHINI", "RADISH", "BROCCOLI", "CAULIFLOWER", "PEAR", "APPLE", "CRANBERRY", "BLUEBERRIES", "POMEGRANATE", "ORANGE", "CORN", "EDAMAME", "TOFU", "RICE", "BARLEY", "COUSCOUS", "HUMMUS", "GARBANZO", "PARMESAN", "ROMAINE", "DILL", "CILANTRO", "CAPERS", "CHAI", "VINEGAR", "GARLIC", "BASIL", "CHERRY TOMATOES", "BOILED EGG", "SUNFLOWER SEEDS", "RANCH DRESSING", "MANDARIN ORANGES", "ITALIAN DRESSING", "SOUR CREAM", "GREEN OLIVES", "BLACK BEANS", "ARTICHOKE HEARTS", "BOK CHOY", "FRESH MOZZARELLA", "SMOKED SALMON", "GREEN BEANS", "LIME JUICE"]
    
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
        setBackgroundImage(named: "salad8.pdf")
    }
        var currentGame: Hangman!
    
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
        correctWordLabel.textColor = wordColor

        scoreLabel.text = "Wins: \(winsInAll), Losses: \(losesInAll)"
        guesses.text = "Guesses Left: \(currentGame.incorrectGuessesRemaining)"

        
        setBackgroundImage(named: "salad\(currentGame.incorrectGuessesRemaining)")
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
        if currentGame.isGameWon {
            updateUI(wordColor: .green)
            enableLetterButtons(false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.winsInAll += 1
                self.newSet()
            }
        } else if currentGame.isGameLost {
            updateUI(wordColor: .red)
            enableLetterButtons(false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.losesInAll += 1
                self.newSet()
            }
        } else {
            updateUI()
        }
    }

    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }






    func showCorrectWord() {
       
        correctWordLabel.text = currentGame.formattedWord
    }


    func delayNewGame() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newSet()  
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


