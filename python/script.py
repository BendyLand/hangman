from gameboard import *


def main():
    greet()
    game = GameBoard()
    game.display_game_image()
    while not game.check_game_over():
        game.guess_letter()
        game.check_num_wrong()
        game.display_game_image()


def greet():
    print("Welcome to Hangman! We have already chosen a random word for you.")


if __name__ == "__main__":
    main()
else:
    print("Error starting application.")
