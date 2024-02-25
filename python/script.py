from gameboard import *

def main():
    greet()
    random_word = choose_random_word()
    print(f"Random word: {random_word}")


def greet():
    print("Welcome to Hangman! We have already chosen a random word for you.")


if __name__ == "__main__":
    main()
else:
    print("Error starting application.")
