open Hangman
open System
open System.IO

let greetUser = 
    printfn "\n\
    Welcome to Hangman! We have chosen a random word for you.\n\
    Let's start by choosing a letter: \n\
    "

let chooseRandomWord = 
    let rnd = Random()
    let words = "../words.txt" |> File.ReadAllLines
    let randomWord = words |> Array.item (rnd.Next(words.Length))
    randomWord

let start = 
    // I eventually want chooseRandomWord here
    greetUser

[<EntryPoint>]
let main argv = 
    let randomWord = chooseRandomWord
    start
    0