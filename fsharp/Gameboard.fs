module GameBoard

open System
open System.IO

type gameStats =
    {
        guessedChars: char list
        gameOver: bool
        numWrong: int
    }

let chooseRandomWord =
    let rnd = Random()
    let words = "../words.txt" |> File.ReadAllLines
    let randomWord = words |> Array.item (rnd.Next(words.Length))
    randomWord

let create =
    let randomWord = chooseRandomWord
    let placeholder =
        randomWord
        |> Seq.toArray
        |> Seq.map (fun _ -> '_')
        |> Seq.collect (fun c -> [|c; ' '|])
        |> Seq.toArray
        |> Array.map string
        |> String.concat " "
    let gameImage = Hangman.empty
    (gameImage + "\n" + placeholder + "\n", randomWord)

let display board =
    printfn $"%s{board}"

let chooseLetter = 
    let choice = Console.ReadLine()
    try
        choice[0] |> Char.ToLower
    with
        | :? System.IndexOutOfRangeException -> 
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

let update gameStats randomWord guess =
    if List.contains guess gameStats.guessedChars && not gameStats.gameOver then
        printfn "Already guessed that letter!"
        (randomWord, gameStats.guessedChars)
    else
        let guessedChars = guess :: gameStats.guessedChars
        let gameImage = chooseGameImage gameStats.numWrong
        let resultWord =
            randomWord
            |> Seq.map (fun c ->
                if List.contains c guessedChars then c else '_')
            |> Seq.collect (fun c -> [|c; ' '|])
            |> Seq.toArray
            |> Array.map string
            |> String.concat " "
        let gameBoard =
            gameImage + "\n" + resultWord.TrimEnd() + "\n"
        (gameBoard, guessedChars)
