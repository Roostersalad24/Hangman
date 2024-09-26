//
//  Hangman.swift
//  Hangman
//
//  Created by Andrew Johnson on 8/24/24.
//

import Foundation

struct Hangman {
    var word: String
    var incorrectGuessesRemaining: Int
    var guessedLetters: [Character]
    
    // Computed property to check if the game is won
    var isGameWon: Bool {
        return word == formattedWordWithoutCheckingGameOver
    }
    
    // Computed property to check if the game is lost
    var isGameLost: Bool {
        return incorrectGuessesRemaining == 0
    }
    
    // Format the word with underscores for unguessed letters
    var formattedWordWithoutCheckingGameOver: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    // If the game is over (won or lost), reveal the word
    var formattedWord: String {
        if isGameWon || isGameLost {
            return word
        } else {
            return formattedWordWithoutCheckingGameOver
        }
    }
    
    // Initialize the game with the first letter revealed
    init(word: String, incorrectGuessesRemaining: Int, guessedLetters: [Character]) {
        self.word = word
        self.incorrectGuessesRemaining = incorrectGuessesRemaining
        self.guessedLetters = guessedLetters
        
        // Automatically reveal the first letter of the word
        if let firstLetter = word.first {
            self.guessedLetters.append(firstLetter)
        }
    }
    
    // Updates the game state when a letter is guessed
    mutating func playerGuessed(letter: Character) {
        if !guessedLetters.contains(letter) {
            guessedLetters.append(letter)
            if !word.contains(letter) {
                incorrectGuessesRemaining -= 1
            }
        }
    }
}
