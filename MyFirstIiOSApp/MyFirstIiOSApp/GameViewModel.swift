//
//  GameViewModel.swift
//  CalculatorGame
//
//  Created by Mark Moore on 20/10/2025.
//

import Foundation
import SwiftUI

// A ViewModel handles the app's logic and data for a view.
// It's an "ObservableObject" which means the view can watch it for changes.
@Observable
class GameViewModel {
    
    // @Published tells the view to update when these values change.
    var firstNumber = 0
    var secondNumber = 0
    var currentAnswer = ""
    var score = 0
    var feedbackMessage = ""

    // Computed property to create the question string.
    var questionText: String {
        "What is \(firstNumber) + \(secondNumber)?"
    }

    init() {
        // Start the game with the first question.
        generateNewQuestion()
    }

    func generateNewQuestion() {
        // Create two random numbers for the question.
        firstNumber = Int.random(in: 1...10)
        secondNumber = Int.random(in: 1...10)
        currentAnswer = ""
        feedbackMessage = ""
    }

    func submitAnswer() -> (question: String, correct: Int, wasCorrect: Bool) {
        // First, let's prepare the data we'll need to save.
        let question = self.questionText
        let correctAnswer = firstNumber + secondNumber
        
        // Check if the user's answer is correct.
        guard let userAnswer = Int(currentAnswer) else {
            feedbackMessage = "Please enter a valid number."
            // Return a tuple indicating an invalid attempt.
            return (question, correctAnswer, false)
        }

        if userAnswer == correctAnswer {
            score += 1
            feedbackMessage = "Correct! Well done."
            generateNewQuestion()
            // Return a tuple indicating a correct answer.
            return (question, correctAnswer, true)
        } else {
            score -= 1
            feedbackMessage = "Wrong! The answer was \(correctAnswer)."
            generateNewQuestion()
            // Return a tuple indicating an incorrect answer.
            return (question, correctAnswer, false)
        }
    }
}
