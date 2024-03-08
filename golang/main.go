package main

import (
	"fmt"
)

func main() {
	fmt.Println("Welcome to Hangman! We have already chosen a random word for you.")
	state := Init()
	fmt.Println("Initial state:", state)
	for !state.gameOver {
		placeholder := ConstructPlaceholder(&state)
		fmt.Println(placeholder)
		GuessLetter(&state)
		CheckGameOver(&state)
	}
}
