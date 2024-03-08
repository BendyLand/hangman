package main

import (
	"fmt"
	"golang/pkgs/hangman"
	"golang/pkgs/utils"
	"strings"
	"unicode/utf8"
)

type GameState struct {
	numWrong       int
	gameOver       bool
	guessedLetters []rune
	randomWord     string
}

func ChooseGameImage(state *GameState) string {
	var image string
	switch state.numWrong {
	case 0:
		image = hangman.EMPTY
	case 1:
		image = hangman.HEAD
	case 2:
		image = hangman.NECK
	case 3:
		image = hangman.ONE_ARM
	case 4:
		image = hangman.TWO_ARMS
	case 5:
		image = hangman.ONE_LEG
	case 6:
		image = hangman.FINISHED_MAN
	default:
		image = hangman.DEAD_MAN
	}
	return image
}

func CheckNumWrong(state *GameState) {
	wordChars := utils.Unique([]rune(state.randomWord))
	correctGuesses := utils.Unique(utils.FilterContains(state.guessedLetters, wordChars))
	numWrong := len(state.guessedLetters) - len(correctGuesses)
	state.numWrong = numWrong
}

func CheckGameOver(state *GameState) {
	CheckNumWrong(state)
	if state.numWrong >= 7 {
		fmt.Println("Game over. The word was:", state.randomWord)
		state.gameOver = true
	}
	wordChars := utils.Unique([]rune(state.randomWord))
	correctGuesses := utils.Unique(utils.FilterContains(state.guessedLetters, wordChars))
	if len(correctGuesses) >= len(wordChars) {
		fmt.Println("You win! The word was:", state.randomWord)
		state.gameOver = true
	}
}

func ConstructPlaceholder(state *GameState) string {
	length := len(state.randomWord)
	arr := make([]string, length)
	for i := range arr {
		if utils.Contains(rune(state.randomWord[i]), state.guessedLetters) {
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
	letter = strings.ToLower(letter)
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
