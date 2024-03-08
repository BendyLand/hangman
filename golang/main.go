package main

import (
	"fmt"
)

func main() {
	fmt.Println("Welcome to Hangman! We have already chosen a random word for you.")
	state := Init()
	for !state.gameOver {
		gameboard := ConstructGameBoard(&state)
		fmt.Println(gameboard)
		GuessLetter(&state)
		CheckGameOver(&state)
	}
}
