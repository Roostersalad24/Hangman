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
    
    var wordBank = ["CHICKEN", "BEEF", "PORK", "FISH", "VEGETABLES", "CARROT", "CELERY", "ONION", "GARLIC", "GINGER", "POTATO", "TOMATO", "CABBAGE", "SPINACH", "BROCCOLI", "PEAS", "LENTILS", "RICE", "NOODLES", "CORN", "MUSHROOM", "BEANS", "HERBS", "THYME", "BAYLEAF", "BASIL", "OREGANO", "CHILI", "CUMIN", "SALT", "PEPPER", "LEMON", "LIME", "VINEGAR", "CREAM", "BROTH", "STOCK", "SOURCREAM", "PARSLEY", "DILL", "CILANTRO", "ZUCCHINI", "SCALLIONS", "RADISH","SHRIMP", "CLAMS", "CRAB", "HOMINY", "BARLEY", "QUINOA", "FENNEL", "LEEK", "BACON", "TURNIP", "CELERY"]
    
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
        setBackgroundImage(named: "broccoli8.pdf")
    }
        var currentGame: Hangman!
    
    func setBackgroundImage(named imageName: String) {
        // Remove the previous background image view if it exists
        if let existingBackground = view.subviews.first(where: { $0 is UIImageView }) {
            existingBackground.removeFromSuperview()
        }

        // Create and add a new UIImageView with the updated image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = .scaleAspectFit  // Aspect Fit
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false

        // Add the image view as a subview and send it to the back
        self.view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)

        // Constraints to pin the image view to the edges of the screen
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
        correctWordLabel.textColor = wordColor  // Set the color of the word label

        scoreLabel.text = "Wins: \(winsInAll), Losses: \(losesInAll)"
        guesses.text = "Guesses Left: \(currentGame.incorrectGuessesRemaining)"

        // Update background image based on incorrect guesses remaining
        setBackgroundImage(named: "broccoli\(currentGame.incorrectGuessesRemaining)")
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
