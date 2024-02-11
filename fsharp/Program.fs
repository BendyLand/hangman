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
    greetUser
    GameBoard.create


[<EntryPoint>]
let main argv = 
    let (board, word) = start
    printfn $"%s{board}"
    let initialGameStats = 
        {
            guessedChars = []
            gameOver = false
            numWrong = 0
        }
    let guess = 
        try Console.ReadLine()[0] |> Char.ToLower
        with | :? IndexOutOfRangeException -> 'a'
    let (newBoard, guessedChars) = update initialGameStats word guess
    printfn $"%s{newBoard}"
    printfn $"The random word was: %s{word}"
    0