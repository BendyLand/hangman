package bland.hangman

object GameBoard {
    val randomWord = App.getRandomWord()
    var gameboard = ""
    var gameOver = false
    var numWrong = 0
    var guessedChars: MutableList<Char> = mutableListOf()

    fun create(word: String): Unit {
        val image = Hangman.empty
        val placeholder = (1..word.length).map { "_ " }
        gameboard = 
            image + "\n" + "\t" + placeholder.joinToString(" ") + "\n"
    }

    fun chooseGameImage(numWrong: Int): String {
        return when (numWrong) {
            0 -> Hangman.empty
            1 -> Hangman.head
            2 -> Hangman.neck
            3 -> Hangman.oneArm
            4 -> Hangman.twoArms
            5 -> Hangman.oneLeg
            6 -> Hangman.finishedMan
            else -> {
                gameOver = true
                println("Game over!")
                println("The word was $randomWord")
                Hangman.deadMan
            }
        }
    }

    fun display() {
        println(gameboard)
    }
}