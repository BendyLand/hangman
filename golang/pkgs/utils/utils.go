package utils

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"strings"
)

type Chars []rune

func (chars Chars) Contains(item rune) bool {
	for _, element := range chars {
		if element == item {
			return true
		}
	}
	return false
}

func (chars Chars) Unique() Chars {
	var resultArr Chars
	for _, element := range chars {
		if resultArr.Contains(element) {
			continue
		}
		resultArr = append(resultArr, element)
	}
	return resultArr
}

func (guesses Chars) FilterContains(wordLetters []rune) Chars {
	var correctGuesses []rune
	for _, guess := range guesses {
		if Chars(wordLetters).Contains(guess) && !Chars(correctGuesses).Contains(guess) {
			correctGuesses = append(correctGuesses, guess)
		}
	}
	return correctGuesses
}

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
