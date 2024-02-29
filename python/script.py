from gameboard import *

def main():
    greet()
    game = GameBoard()
    print(f"Random word: {game.word}")
    game.guess_letter()
    print(f"Guessed letters: {game.guessed_letters}")

def greet():
    print("Welcome to Hangman! We have already chosen a random word for you.")


if __name__ == "__main__":
    main()
else:
    print("Error starting application.")
