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
    
   
    var isGameWon: Bool {
        return word == formattedWordWithoutCheckingGameOver
    }
    
   
    var isGameLost: Bool {
        return incorrectGuessesRemaining == 0
    }
    
   
    var formattedWordWithoutCheckingGameOver: String {
        var guessedWord = ""
        for letter in word {
            if letter == " " {
                guessedWord += " "  
            } else if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }

    
  
    var formattedWord: String {
        if isGameWon || isGameLost {
            return word
        } else {
            return formattedWordWithoutCheckingGameOver
        }
    }
    
  
    init(word: String, incorrectGuessesRemaining: Int, guessedLetters: [Character]) {
        self.word = word
        self.incorrectGuessesRemaining = incorrectGuessesRemaining
        self.guessedLetters = guessedLetters

   
        for letter in word {
            if letter == " " {
                self.guessedLetters.append(letter)
            } else if self.guessedLetters.isEmpty {
                self.guessedLetters.append(letter)
            }
        }
    }

    
   
    mutating func playerGuessed(letter: Character) {
        if !guessedLetters.contains(letter) {
            guessedLetters.append(letter)
            if !word.contains(letter) {
                incorrectGuessesRemaining -= 1
            }
        }
    }
}
