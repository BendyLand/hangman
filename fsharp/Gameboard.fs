module GameBoard

open Hangman
open System
open System.IO

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
        |> Array.map (fun _ -> "_ ")
        |> String.concat ""
    let gameImage = Hangman.empty
    (gameImage + "\n" + "\t" + placeholder + "\n", randomWord)

let display board = 
    printfn $"%s{board}"




