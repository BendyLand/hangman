package main

import (
	"fmt"
)

func main() {
	greet()
	state := Init()
	fmt.Println("Initial state:", state)
	for state.gameOver {
		placeholder := ConstructPlaceholder(&state)
		fmt.Println(placeholder)
		GuessLetter(&state)
		CheckGameOver(&state)
	}
}

func greet() {
	fmt.Println("Welcome to Hangman! We have already chosen a random word for you.")
}
