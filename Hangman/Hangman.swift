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
    
    // A new property to track if the game is over
    var isGameOver: Bool = false
    
    // Computed property to format the word based on game state
    var formattedWord: String {
        var guessedWord = ""
        
        if isGameOver {
            // If the game is over, reveal the entire word
            guessedWord = word
        } else {
            // If the game is ongoing, reveal guessed letters and use "_" for unguessed ones
            for letter in word {
                if guessedLetters.contains(letter) {
                    guessedWord += "\(letter)"
                } else {
                    guessedWord += "_"
                }
            }
        }
        return guessedWord
    }
    
    // Handle the player's guess and update the game state
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectGuessesRemaining -= 1
        }
    }
}
