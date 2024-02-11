open Hangman
open GameBoard
open System
open System.IO

let greetUser = 
    printfn "\n\
    Welcome to Hangman! We have chosen a random word for you.\n\
    Let's start by choosing a letter: \n\
    "

[<EntryPoint>]
let main argv = 
    greetUser
    let guess = chooseLetter
    printfn $"Letter: %c{guess}"
    0