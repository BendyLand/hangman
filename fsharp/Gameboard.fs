module GameBoard

open System
open System.IO

type gameStats =
    {
        guessedChars: char list
        gameOver: bool
        numWrong: int
    }

/// <summary>Checks the number of incorrectly made guesses.</summary>
/// <returns>The number of incorrect guesses the user has made 
/// up to the point of the function call.</returns>
let checkNumWrong (guessedChars : char list) (word : string) = 
    let correctGuesses = 
        guessedChars 
        |> List.filter (fun c -> word.Contains(c))
    guessedChars.Length - correctGuesses.Length

/// <summary>Selects a random word from the provided text file.</summary>
/// <returns>A random word from the text file.</returns>
let chooseRandomWord =
    let rnd = Random()
    let words = "../words.txt" |> File.ReadAllLines
    let randomWord = words |> Array.item (rnd.Next(words.Length))
    randomWord

/// Prints the game board, made up of the game image and random word.
let display board =
    printfn $"%s{board}"

/// <summary>Takes user input and trims to one character.</summary>
/// <returns>The chosen character (or a default of 'a' for invalid inputs)
/// and an updated list of guessed letters.</returns>
let guessLetter guessedLetters = 
    let choice = Console.ReadLine()
    let result = 
        try choice[0] |> Char.ToLower
        with | :? IndexOutOfRangeException -> 
                printfn "Invalid input. Defaulting to 'a'"
                'a'
    let newGuessedLetters = result :: guessedLetters
    // returning newGuessedLetters allows us to check incorrect guesses later
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

/// <summary>Creates the initial game board and chooses the random word.</summary>
/// <returns>The complete game board and the randomly selected word.</returns>
let create = 
    let gameImage = Hangman.empty
    let word = chooseRandomWord
    let placeholder = 
        word
        |> Seq.map (fun c -> "_")
        |> Seq.toArray
        |> String.concat " "
    (gameImage + "\n" + placeholder + "\n", word)