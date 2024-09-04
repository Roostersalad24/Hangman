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
    var formattedWord: String {
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
    
    
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectGuessesRemaining -= 1
        }
    }
}


