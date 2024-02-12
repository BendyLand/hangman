module GameBoard

open System
open System.IO

type gameStats =
    {
        guessedChars: char list
        gameOver: bool
        numWrong: int
    }

/// <summary>Checks if the guessed letter is in the random word</summary>
/// <returns>The resulting word filled in with previously guessed letters,
/// and the updated list of guessed letters</returns>
let checkLetter (guess : char) (word : string) (guessedChars : char list) = 
    let resultWord = 
        word
        |> Seq.map (fun c -> 
            if List.contains c guessedChars then
                string c
            else
                "_")
        |> String.concat " "
    resultWord

/// <summary>Checks the number of incorrectly made guesses.</summary>
/// <returns>The number of incorrect guesses the user has made 
/// up to the point of the function call.</returns>
let checkNumWrong (guessedChars : char list) (word : string) = 
    let correctGuesses = 
        guessedChars 
        |> List.filter (fun c -> word.Contains(c))
    let numWrong = guessedChars.Length - correctGuesses.Length
    let numRight = correctGuesses.Length
    (numWrong, numRight)

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
/// <returns>The chosen character (or a default of 'a' for invalid inputs),
/// and an updated list of guessed letters.</returns>
let guessLetter guessedLetters = 
    let choice = Console.ReadLine()
    let result = 
        try Char.ToLower choice[0] 
        with | :? IndexOutOfRangeException -> 
                printfn "Invalid input. Defaulting to 'a'"
                'a'
    if List.contains result guessedLetters then 
        printfn $"Already guessed that letter!"
        (result, guessedLetters)
    else
        let newGuessedLetters = result :: guessedLetters
        (result, newGuessedLetters)

/// <summary>Helper function to generate the proper game image.</summary>
/// <returns>The proper game image based on the number of incorrect guesses.</returns>
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

/// <summary>Checks if game is over either by winning or losing</summary>
/// <returns>A boolean that represents whether or not the game is over</returns>
let checkGameOver guessedChars (word : string) =
    let (numWrong, numRight) = checkNumWrong guessedChars word
    let uniqueCorrectLetters =
        word 
        |> Seq.distinct
        |> Seq.map string
        |> String.concat ""
    if numWrong >= 7 then
        printfn $"Game over! The word was %s{word}"
        true
    else if numRight >= uniqueCorrectLetters.Length then
        printfn $"You win! The word was %s{word}"
        true 
    else
        false