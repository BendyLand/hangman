import scala.io.Source.*
import scala.io.StdIn
import GameBoard.randomWord

/*
Hangman Game: Implement a Hangman game where users guess letters to complete a hidden word within a limited number of attempts.
*/
@main def run() =
    startGame(GameBoard.randomWord)


def startGame(randomWord: String) = 
    GameBoard.create(randomWord)
    println("Welcome to Hangman! We have chosen a word for you at random.\n" +
            "Let's start by choosing a letter: ")

    while GameBoard.currentNumWrong < 7 do
        val choice = GameBoard.chooseLetter()
        GameBoard.update(GameBoard.currentNumWrong, choice)
        GameBoard.display


object GameBoard:
    val randomWord = GameBoard.getRandomWord()
    var currentNumWrong = 0
    var gameBoard = ""
    var guessedChars: List[Char] = List()

    def getRandomWord(): String =
        val words = fromFile("../words.txt").getLines().toArray
        val num = (math.random() * words.size + 1).toInt
        words(num)

    def create(word: String): Unit =
        val image = HangMan.empty
        val placeholder = for _ <- 1 to word.size yield "_ "
        gameBoard = 
            image + "\n" + "\t" + placeholder.mkString(" ") + "\n"

    def update(currentNumWrong: Int, guess: Char): Unit = 
        if guessedChars.contains(guess) then
            println("Already guessed that letter!")
        else
            guessedChars = guess +: guessedChars
            val gameImage = chooseGameImage(currentNumWrong)
            val resultWord = 
                for i <- 0 until GameBoard.randomWord.size 
                yield 
                    if guessedChars.contains(randomWord(i)) then randomWord(i)
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

    def chooseLetter(): Char = 
        val input = StdIn.readLine()
        try input(0).toLower
        catch 
            case _: java.lang.StringIndexOutOfBoundsException =>
                'a'


object HangMan:
    val empty = 
        """
                _____________
              |              |
              |              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
        ______|______
        """

    val head =
        """
                _____________
              |              |
              |              |
              |           ___|___
              |          |       |
              |          |       |
              |          |_______|
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
        ______|______
        """

    val neck =
        """
                _____________
              |              |
              |              |
              |           ___|___
              |          |       |
              |          |       |
              |          |_______|
              |              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
              |
        ______|______
        """

    val oneArm =
        """
                _____________
              |              |
              |              |
              |           ___|___
              |          |       |
              |          |       |
              |          |_______|
              |              |
              |        -------
              |       |
              |       |   |
              |       |___|
              |
              |
              |
              |
              |
              |
              |
              |
              |
        ______|______
        """

    val twoArms =
        """
                _____________
              |              |
              |              |
              |           ___|___
              |          |       |
              |          |       |
              |          |_______|
              |              |
              |        --------------
              |       |              |
              |       |   |      |   |
              |       |___|      |___|
              |
              |
              |
              |
              |
              |
              |
              |
              |
        ______|______
        """

    val oneLeg =
        """
                _____________
              |              |
              |              |
              |           ___|___
              |          |       |
              |          |       |
              |          |_______|
              |              |
              |        --------------
              |       |              |
              |       |   |      |   |
              |       |___|      |___|
              |           |      |
              |           |  |
              |           |__|
              |
              |
              |
              |
              |
              |
        ______|______
        """

    val finishedMan =
        """
                _____________
              |              |
              |              |
              |           ___|___
              |          |       |
              |          |       |
              |          |_______|
              |              |
              |        --------------
              |       |              |
              |       |   |      |   |
              |       |___|      |___|
              |           |      |
              |           |  ||  |
              |           |__||__|
              |
              |
              |
              |
              |
              |
        ______|______
        """