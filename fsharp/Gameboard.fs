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
    guessedChars.Length - correctGuesses.Length

let chooseRandomWord =
    let rnd = Random()
    let words = "../words.txt" |> File.ReadAllLines
    let randomWord = words |> Array.item (rnd.Next(words.Length))
    randomWord

let display board =
    printfn $"%s{board}"

let guessLetter guessedLetters = 
    let choice = Console.ReadLine()
    let result = 
        try choice[0] |> Char.ToLower
        with | :? IndexOutOfRangeException -> 
                printfn "Invalid input. Defaulting to 'a'"
                'a'
    let newGuessedLetters = result :: guessedLetters
    (result, newGuessedLetters)

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

let create = 
    let gameImage = Hangman.empty
    let word = chooseRandomWord
    let placeholder = 
        word
        |> Seq.map (fun c -> "_")
        |> Seq.toArray
        |> String.concat " "
    (gameImage + "\n" + placeholder + "\n", word)