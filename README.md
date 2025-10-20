# A simple Swift Calculator App. 
This readMe.md will teach you the logic and code behind my swift app :D
Firstly to see the calculator please see the attached video (sorry for the resolution github seems to have compressed it):

https://github.com/user-attachments/assets/8dbe84b5-6815-4525-82bd-05bc29de3640

# In depth Overview of each file
I will not go over the imports for each file however if you do need more documentaiton please see here:
https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

I didn't spend long on this as it is my first ever iOS app, it was a cool experience and I definetely learned a lot overall. 
One thing I would highlight is just how easy it is to learn with swift, I made this in a couple of hours and although it is not a sophisticated app there is definetely a sense of reward.

## File - CalculationIteam.swift
<img width="675" height="305" alt="Screenshot 2025-10-20 at 11 00 35" src="https://github.com/user-attachments/assets/ad118ee5-d995-4e70-8899-b9dc880aa6ec" />

Line 11 : @Model : Converts a Swift class into a stored model that’s managed by SwiftData, is what Apple officially say it does. In simpler terms, you can think of it as a regular Swift class that SwiftData automatically tracks and stores for you.

Line 18 : The initialiser sets the class’s properties — like question, correctAnswer, etc. — when you create a new instance. Since the class is marked with @Model, SwiftData automatically saves these values. In java we would call this a constructor.

## File - CalculatorGameApp.swift
<img width="738" height="447" alt="Screenshot 2025-10-20 at 11 09 05" src="https://github.com/user-attachments/assets/3c62db46-1a98-4b18-a579-0e0c2bfd446d" />

This is a relatively confusing file to get your head around however, essentially what it does is creates the database for our game.
I honestly do not think that the format for this file changes too often.

Line 11 : @main : Tells the compiler that this file will be the entry point / starting point into the app.
The rest of the file is essentially declaring the database and then calling contentview() (line 29)

## File - ContentView.swift
Since this file is 200 lines of code, i decided it may be a smarter move to just take small relevant screenshots to prevent you from having to search through long ones.
A summary of what this file does is;
1. The game’s state (setup → playing → finished)
2. The user interface for each game phase
3. The saving and deletion of game results in SwiftData
4. The display of history (previous games)

<img width="487" height="58" alt="Screenshot 2025-10-20 at 11 16 59" src="https://github.com/user-attachments/assets/4618c089-8859-4dfb-bfcd-8c84240f06bd" />
Gives you access to your SwiftData model context, which is like a connection to the database, we can use it to insert or delete data (CalculationItems).

<img width="498" height="54" alt="Screenshot 2025-10-20 at 11 17 30" src="https://github.com/user-attachments/assets/aeac71b7-52f8-4287-b054-262781abb6d9" />
Automatically fetches all saved CalculationItem objects from SwiftData. The .reverse sort means most recent first and SwiftUI automatically updates when data changes.

<img width="570" height="635" alt="Screenshot 2025-10-20 at 11 18 27" src="https://github.com/user-attachments/assets/64ae371f-94bc-4085-8c29-9671b334629a" />
@State private var viewModel = GameViewModel()
This holds your game logic — how questions are created, answers are checked, and scores tracked and the @State keeps it alive and reactive for this view.

Main Body
NavigationStack {
    VStack(spacing: 20) {
        Text("Calculator Game!")
        ...
        switch viewModel.gameState {
            case .settingUp: SetupView(...)
            case .playing: GameView(...)
            case .finished: FinishedView(...)
        }
        Spacer()
        HistoryView(items: items, onDelete: deleteItems)
    }
    .padding()
    .navigationTitle("Game")
}

What happens here:
The navigation stack provides navigation and a toolbar.
Inside, a vertical stack (VStack) arranges your content.
You switch between different subviews based on the game’s state:
SetupView → choose number of questions
GameView → play and answer
FinishedView → show score
At the bottom, we show the HistoryView

private func saveGameResult(result: (question: String, correct: Int, wasCorrect: Bool)) {
    let newItem = CalculationItem(
        question: result.question,
        correctAnswer: result.correct,
        wasCorrect: result.wasCorrect,
        timestamp: Date()
    )
    modelContext.insert(newItem)
}


When a user answers a question, this creates a new CalculationItem with the question, correct answer, whether they were right, and a timestamp.
Then it inserts it into SwiftData — which automatically saves it.
So each game result gets persistently stored (you’ll see it even after app restarts).


This sets up a preview-friendly, in-memory SwiftData store so you can test the UI without saving anything permanently.

## File - GameViewModel.swift
This file contains the main game logic for the Calculator Game — it’s the “brains” behind the UI.
Essentially, this file manages what stage the game is in (setup, playing, or finished), generates questions, checks answers, and updates the score.
<img width="633" height="587" alt="Screenshot 2025-10-20 at 11 21 50" src="https://github.com/user-attachments/assets/2a9fc296-91f2-4857-b480-86a40180c648" />

Line 9 : enum GameState

Defines the three possible states of the game —
.settingUp, .playing, and .finished.
This makes it easy to switch between screens in ContentView.

Line 14 : @Observable

This modifier tells Swift that this class’s properties can be observed for changes by SwiftUI.
Whenever a value changes (like the score or question), the UI automatically updates — you don’t need to refresh it manually.

Line 15–24 : Declared Variables : These store all the information about the game:

gameState → what stage the game is in

numberOfQuestions → how many questions the user chose to answer

questionCounter → tracks which question the player is on

firstNumber / secondNumber → random numbers used to create a question

currentAnswer → the user’s input

score → how many correct answers so far

feedbackMessage → short text showing if the answer was correct or not

Line 27 : var questionText: String

Creates a computed property that automatically generates the question text (e.g. “What is 4 + 7?”).
This means every time firstNumber or secondNumber changes, the question updates.

Line 31 : init()

An empty initializer — just here so the class can be created with default values.

Line 34 : func startGame()

Resets everything at the start of a game:

Sets score back to 0

Resets the question counter

Sets the state to .playing

Calls generateNewQuestion() to start the first round

Line 40 : func playAgain()

Simply resets the game state to .settingUp, so the player can choose a new number of questions and start again.

Line 43 : func generateNewQuestion()

Generates a new random addition question:

Increases the question counter (only if the game is playing)

Picks two random numbers between 1 and 10

Clears the user’s answer and feedback message

This keeps the game flowing question by question.

<img width="715" height="722" alt="Screenshot 2025-10-20 at 11 22 16" src="https://github.com/user-attachments/assets/0d3d8649-3497-4b86-8182-a446b61a1e81" />

Line 51 : func submitAnswer()

This is where the main game logic happens:

Gets the current question text and calculates the correct answer.
Checks if the player’s answer is a valid number (Int).

If it’s correct → increases score and shows “Correct!”
If wrong → shows the right answer.

Uses a short 1-second delay (DispatchQueue.main.asyncAfter) to give the user feedback before moving to the next question.
Once all questions are done, it changes the state to .finished. 
It also returns a tuple (question, correct, wasCorrect) so that ContentView can save the result into SwiftData.

Summary

This file controls the entire logic and flow of the Calculator Game.
It:
1. Manages the game’s current state
2. Generates and checks questions
3. Tracks score
4. Updates feedback messages
5. Tells the UI when to move to the next screen
