package utils

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"strings"
)

func ChooseRandomWord() string {
	file, err := os.Open("../words.txt")
	if err != nil {
		fmt.Println("Could not open file")
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	var result string
	for scanner.Scan() {
		result += scanner.Text() + "\n"
	}
	lines := strings.Split(result, "\n")
	num := rand.Int() % len(lines)
	return strings.ToLower(lines[num])
}

func Unique(arr []rune) []rune {
	var newArr []rune
	for _, item := range arr {
		if Contains(item, newArr) {
			continue
		}
		newArr = append(newArr, item)
	}
	return newArr
}

func FilterContains(guesses []rune, wordLetters []rune) []rune {
	var correctGuesses []rune
	for _, guess := range guesses {
		if Contains(guess, wordLetters) && !Contains(guess, correctGuesses) {
			correctGuesses = append(correctGuesses, guess)
		}
	}
	return correctGuesses
}

func Contains(elem rune, list []rune) bool {
	for _, item := range list {
		if item == elem {
			return true
		}
	}
	return false
}
