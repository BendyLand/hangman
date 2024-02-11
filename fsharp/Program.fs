open Hangman
open GameBoard
open System
open System.IO

let greetUser = 
    printfn "\n\
    Welcome to Hangman! We have chosen a random word for you.\n\
    Let's start by choosing a letter: \n\
    "

let start = 
    // I eventually want chooseRandomWord here
    greetUser


[<EntryPoint>]
let main argv = 
    start
    let (startingBoard, randomWord) = GameBoard.create
    printfn $"%s{startingBoard}"
    let gameStats = 
        {
            guessedChars = []
            gameOver = false
            numWrong = 0
        }
    let (newBoard, guessedChars) = update gameStats randomWord 'e' 
    printfn $"%s{newBoard}"
    printfn $"The random word was: %s{randomWord}"
    0