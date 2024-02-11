import hangman.*
import gameboard.*

@main def run() =
    welcomePlayer(GameBoard.randomWord)
    while GameBoard.numWrong < 7 && !GameBoard.checkWin do
        startGame()


def welcomePlayer(randomWord: String) = 
    GameBoard.create(randomWord)
    println("Welcome to Hangman! We have chosen a word for you at random.\n" +
            "Let's start by choosing a letter: ")

def startGame(): Unit = 
    def play(): Unit = 
        val choice = GameBoard.chooseLetter()
        GameBoard.update(choice)
        if GameBoard.checkWin then
            println(s"You win! The word was ${GameBoard.randomWord}")
        else
            GameBoard.display
            if GameBoard.numWrong < 7 then
                play()
    play()