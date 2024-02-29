from random import sample

class GameBoard:
    def __init__(self):
        self.word = self.choose_random_word()
        self.num_wrong = 0
        self.guessed_letters = []


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
            self.guessed_letters.append('a')
            self.guessed_letters = list(set(self.guessed_letters))

    def choose_random_word(self) -> str:
        string = ""
        with open("../words.txt") as file:
            for line in file:
                if line is not None:
                    string += line
        words = string.split("\n")
        return sample(words, 1)[0]
