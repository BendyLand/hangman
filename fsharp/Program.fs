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

[<EntryPoint>]
let main argv = 
    let (initialGameBoard, randomWord) = startGame
    printfn $"%s{initialGameBoard}"
    printfn $"The random word is %s{randomWord}"
    0