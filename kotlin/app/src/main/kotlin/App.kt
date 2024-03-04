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
        val words = File("../../words.txt").useLines() { it.toList() }
        val num = Random.nextInt(0, words.size)
        return words[num].lowercase()
    }
}

fun main() {
    App.welcomePlayer(GameBoard.randomWord)
    println("The word is ${GameBoard.randomWord}")


}
