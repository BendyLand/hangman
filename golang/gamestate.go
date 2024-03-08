package main

import (
	"fmt"
	"strings"
	"golang/pkgs/utils"
	"unicode/utf8"
)

type GameState struct {
	numGuesses     int
	gameOver       bool
	guessedLetters []rune
	randomWord     string
}

func Contains(elem rune, list []rune) bool {
	for _, item := range list {
		if item == elem {
			return true
		}
	}
	return false
}

func ConstructPlaceholder(state *GameState) string {
	length := len(state.randomWord)
	arr := make([]string, length)
	for i := range arr {
		if Contains(rune(state.randomWord[i]), state.guessedLetters) {
			arr[i] = string(state.randomWord[i])
		} else {
			arr[i] = "_"
		}
	}
	return strings.Join(arr, " ")
}

func GuessLetter(state *GameState) {
	var letter string
Loop:
	for {
		fmt.Println("Please enter a letter: ")
		fmt.Scan(&letter)
		if len(letter) >= 1 {
			break Loop
		} else {
			fmt.Println("Invalid input. Please enter a letter.")
		}
	}
	char, _ := utf8.DecodeRuneInString(letter)
	state.guessedLetters = append(state.guessedLetters, char)
}

func Init() GameState {
	randomWord := utils.ChooseRandomWord()
	return GameState{
		0,
		false,
		[]rune{},
		randomWord,
	}
}
