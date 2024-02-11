package gameboard 

import scala.io.StdIn
import scala.io.Source.*
import hangman.*

object GameBoard:
    val randomWord = GameBoard.getRandomWord
    var gameOver = false
    var numWrong = 0
    var gameBoard = ""
    var guessedChars: List[Char] = List()

    def checkWin: Boolean = 
        val correctGuesses = guessedChars.filter(c => randomWord.contains(c)).size 
        correctGuesses == randomWord.distinct.size

    def checkNumWrong: Int =
        val correctGuesses = guessedChars.filter(c => randomWord.contains(c))
        val result = guessedChars.size - correctGuesses.size  
        numWrong = result
        result

    def getRandomWord: String =
        val words = fromFile("../words.txt").getLines().toArray
        val num = (math.random() * words.size + 1).toInt
        words(num)

    def create(word: String): Unit =
        val image = HangMan.empty
        val placeholder = for _ <- 1 to word.size yield "_ "
        gameBoard = 
            image + "\n" + "\t" + placeholder.mkString(" ") + "\n"

    def update(guess: Char): Unit = 
        if guessedChars.contains(guess) && !gameOver then
            println("Already guessed that letter!")
        else
            guessedChars = guess +: guessedChars
            val gameImage = chooseGameImage(checkNumWrong)
            val resultWord = 
                for i <- 0 until GameBoard.randomWord.size 
                    yield 
                        if guessedChars.contains(randomWord(i)) then 
                            randomWord(i)
                        else "_ "
            gameBoard = 
                gameImage + "\n" + "\t" + resultWord.mkString(" ") + "\n"
    
    def display = 
        println(gameBoard)

    def chooseGameImage(numWrong: Int): String = 
        numWrong match
            case 0 => HangMan.empty
            case 1 => HangMan.head
            case 2 => HangMan.neck
            case 3 => HangMan.oneArm
            case 4 => HangMan.twoArms
            case 5 => HangMan.oneLeg
            case 6 => HangMan.finishedMan
            case _ => 
                gameOver = true
                println("Game over!")
                println(s"The word was: $randomWord")
                HangMan.deadMan

    def chooseLetter(): Char = 
        val input = StdIn.readLine()
        try input(0).toLower
        catch 
            case _: java.lang.StringIndexOutOfBoundsException =>
                'a'