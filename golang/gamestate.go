package main

import (
	"golang/pkgs/utils"
)

type GameState struct {
	numGuesses int
	gameOver bool
	guessedLetters []string
	randomWord string
}

func Init() GameState {
	randomWord := utils.ChooseRandomWord()
	return GameState{
		0,
		false,
		[]string{},
		randomWord,
	}
}