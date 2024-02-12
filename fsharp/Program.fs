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
    // these values will begin the game loop
    // also need defaults for numWrong (0), guessedChars ([]), gameOver (false)
    let (initialGameBoard, randomWord) = startGame
    printfn $"%s{initialGameBoard}"
    printfn $"The random word is %s{randomWord}"
    0