﻿open GameBoard
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

[<EntryPoint>]
let main argv =
    let (initialGameBoard, randomWord) = startGame
    printfn $"%s{initialGameBoard}"
    let initialGuessedChars = []
    let rec runGame board randomWord guessedChars (numRight, numWrong) =
        let (guess, guessedChars) = guessLetter guessedChars
        let resultWord = checkLetter guess randomWord guessedChars
        let (numWrong, numRight) = checkNumWrong guessedChars randomWord
        let newBoard = (chooseGameImage numWrong) + "\n" + resultWord + "\n"
        printfn $"%s{newBoard}"
        let gameOver = checkGameOver guessedChars randomWord
        if not gameOver then 
            runGame newBoard randomWord guessedChars (numWrong, numRight)
        else
            ()
    runGame initialGameBoard randomWord initialGuessedChars (0, 0)
    0