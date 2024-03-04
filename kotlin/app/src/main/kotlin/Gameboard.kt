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

    fun update(guess: Char) {
        if (guessedChars.contains(guess) && !gameOver) {
            println("Already guessed that letter!")
        }
        else {
            guessedChars.add(guess)
            val gameImage = chooseGameImage(checkNumWrong())
            val resultWord = randomWord.indices.map { i: Int ->
                if (guessedChars.contains(randomWord[i])) {
                    randomWord[i].toString()
                }
                else {
                    "_ "
                }
            }
            gameboard = 
                gameImage + "\n" + "\t" + resultWord.joinToString(" ") + "\n"
        }
    }

    fun checkNumWrong(): Int {
        val numIncorrectGuesses = 
            guessedChars
                .filter { c -> !randomWord.contains(c) }
                .distinct()
                .size
        numWrong = numIncorrectGuesses
        return numIncorrectGuesses
    }

    fun checkWin(): Boolean {
        val numCorrectGuesses = 
            guessedChars
                .filter { c -> randomWord.contains(c) }
                .distinct()
                .size
        return numCorrectGuesses == randomWord.toCharArray().distinct().size
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

    fun chooseLetter(): Char {
        val input = readLine() ?: ""
        return try {
            input.trim().lowercase().first()
        } 
        catch (_: java.util.NoSuchElementException) {
            'a'
        }
    }

    fun display() {
        println(gameboard)
    }
}