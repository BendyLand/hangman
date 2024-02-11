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
    let (startingBoard, randomWord) = GameBoard.create
    start
    0