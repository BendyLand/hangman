open GameBoard
open System
open System.IO

let greetUser =
    printfn "\n\
    Welcome to Hangman! We have chosen a random word for you.\n\
    Let's start by choosing a letter: \n\
    "

let startGame =
    greetUser
    create

let rec runGame board randomWord guessedChars (numWrong, numRight) =
    let (guess, guessedChars) = guessLetter guessedChars
    let resultWord = checkLetter guess randomWord guessedChars
    let (numWrong, numRight) = checkNumWrong guessedChars randomWord
    let newBoard = (chooseGameImage numWrong) + "\n" + resultWord + "\n"
    display newBoard
    let gameOver = checkGameOver guessedChars randomWord
    if not gameOver then 
        runGame newBoard randomWord guessedChars (numWrong, numRight)
    else
        ()

[<EntryPoint>]
let main argv =
    let (initialGameBoard, randomWord) = startGame
    display initialGameBoard
    let initialGuessedChars = []
    runGame initialGameBoard randomWord initialGuessedChars (0, 0)
    0