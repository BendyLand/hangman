from random import sample

def choose_random_word() -> str:
    string = ""
    with open("../words.txt") as file:
        for line in file:
            if line is not None:
                string += line
    words = string.split("\n")
    return sample(words, 1)[0]
