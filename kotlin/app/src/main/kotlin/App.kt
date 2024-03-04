package bland.hangman

object App {
    fun greetPlayer() {
        println("Welcome to Hangman! We have already chosen a random word for you.\n" +
                "Let's start by choosing a letter: ")
    }
}

fun main() {
    App.greetPlayer()
    val word = GameBoard.getRandomWord()
    GameBoard.create(word)
    println(GameBoard.gameboard)
    println("The word is $word")
}
