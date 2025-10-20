import Foundation
import SwiftData

// This is our new Data Model.
// It defines what information we want to save in the database for each round of the game.
@Model
final class CalculationItem {
    var question: String
    var correctAnswer: Int
    var wasCorrect: Bool
    var timestamp: Date
    
    init(question: String, correctAnswer: Int, wasCorrect: Bool, timestamp: Date) {
        self.question = question
        self.correctAnswer = correctAnswer
        self.wasCorrect = wasCorrect
        self.timestamp = timestamp
    }
}
