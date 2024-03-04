package bland.hangman

import java.io.File
import kotlin.random.*

object App {
    fun welcomePlayer(randomWord: String) {
        GameBoard.create(randomWord)
        println("Welcome to Hangman! We have already chosen a random word for you.\n" +
                "Let's start by choosing a letter: ")
    }

    fun getRandomWord(): String {
                         // I hate Gradle so much
        val words = File("../../../../../words.txt").useLines() { it.toList() }
        val num = Random.nextInt(0, words.size)
        return words[num].lowercase()
    }

    fun play() {
        val choice = GameBoard.chooseLetter()
        GameBoard.update(choice)
        if (GameBoard.checkWin()) {
            println("You win! The word was ${GameBoard.randomWord}")
        }
        else {
            GameBoard.display()
            if (GameBoard.numWrong < 7) {
                play()
            }
        }
    }

    fun startGame() {
        App.welcomePlayer(GameBoard.randomWord)
        play()
    }
}

/*  
Run using: 

kotlinc *.kt -include-runtime -d App.jar && kotlin App.jar 

Gradle seems to breaks stdin, so the program will just close, regardless of how you gather input.
Also, gradle doesn't like the recursive implementation. 
*/
fun main() {
    App.startGame()
    println("The word is ${GameBoard.randomWord}")
}
