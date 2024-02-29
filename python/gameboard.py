from random import sample
from hangman import *


class GameBoard:
    def __init__(self):
        self.word = self.choose_random_word()
        self.num_wrong = 0
        self.guessed_letters = []

    def check_game_over(self):
        if self.num_wrong >= 7:
            print(f"Game over. The word was {self.word}")
            return True
        elif self.check_correct_guesses() == len(set(self.word)):
            print(f"You win! The word was: {self.word}")
            return True
        else:
            return False

    def check_correct_guesses(self):
        correct_guesses = list(filter(lambda c: c in self.word, self.guessed_letters))
        return len(correct_guesses)

    def check_num_wrong(self):
        correct_guesses = list(filter(lambda c: c in self.word, self.guessed_letters))
        self.num_wrong = len(self.guessed_letters) - len(correct_guesses)
        return self.num_wrong

    def guess_letter(self):
        letter = input("Please enter a letter: ")
        try:
            guess = letter[0].lower()
            if guess not in self.guessed_letters:
                self.guessed_letters.append(guess)
                self.guessed_letters = list(set(self.guessed_letters))
            else:
                print("Already guessed that letter!")
        except:
            print("Invalid input. Defaulting to 'a'")
            self.guessed_letters.append("a")
            self.guessed_letters = list(set(self.guessed_letters))

    def choose_random_word(self) -> str:
        string = ""
        with open("../words.txt") as file:
            for line in file:
                if line is not None:
                    string += line
        words = string.split("\n")
        return sample(words, 1)[0].lower()

    def display_game_image(self):
        game_image = self.choose_game_image()
        placeholder = []
        for c in self.word:
            if c in self.guessed_letters:
                placeholder.append(c)
            else:
                placeholder.append("_")
        result = " ".join(placeholder)
        print(game_image + "\n" + result + "\n")

    def choose_game_image(self):
        match self.num_wrong:
            case 0:
                return EMPTY
            case 1:
                return HEAD
            case 2:
                return NECK
            case 3:
                return ONE_ARM
            case 4:
                return TWO_ARMS
            case 5:
                return ONE_LEG
            case 6:
                return FINISHED_MAN
            case _:
                return DEAD_MAN
