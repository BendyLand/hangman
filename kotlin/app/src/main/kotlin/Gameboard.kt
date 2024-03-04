package bland.hangman

import java.io.File
import kotlin.random.*

object GameBoard {
    var gameboard = ""

    fun getRandomWord(): String {
        val words = File("../../words.txt").useLines() { it.toList() }
        val num = Random.nextInt(0, words.size)
        return words[num].lowercase()
    }

    fun create(word: String): Unit {
        val image = Hangman.empty
        val placeholder = (1..word.length).map { "_ " }
        gameboard = 
            image + "\n" + "\t" + placeholder.joinToString(" ") + "\n"
    }
}