module GameBoard

open System
open System.IO

type gameStats =
    {
        guessedChars: char list
        gameOver: bool
        numWrong: int
    }

let checkNumWrong (guessedChars : char list) (word : string) = 
    let correctGuesses = 
        guessedChars 
        |> List.filter (fun c -> word.Contains(c))
    let result = guessedChars.Length - correctGuesses.Length
    result

let chooseRandomWord =
    let rnd = Random()
    let words = "../words.txt" |> File.ReadAllLines
    let randomWord = words |> Array.item (rnd.Next(words.Length))
    randomWord

let display board =
    printfn $"%s{board}"

let chooseLetter = 
    let choice = Console.ReadLine()
    try choice[0] |> Char.ToLower
    with | :? IndexOutOfRangeException -> 
            printfn "Invalid input. Defaulting to 'a'"
            'a'

let chooseGameImage numWrong =
    match numWrong with
    | 0 -> Hangman.empty
    | 1 -> Hangman.head
    | 2 -> Hangman.neck
    | 3 -> Hangman.oneArm
    | 4 -> Hangman.twoArms
    | 5 -> Hangman.oneLeg
    | 6 -> Hangman.finishedMan
    | _ -> Hangman.deadMan
