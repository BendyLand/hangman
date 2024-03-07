package utils

import (
	"os"
	"fmt"
	"bufio"
	"math/rand"
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