require_relative "hangman"

class Gameboard
    @@guessed_chars = []
    @@num_wrong = 0
    @@random_word = ""

    def initialize() 
        @@random_word = choose_random_word()
    end

    def choose_random_word() 
        lines = File.read("../words.txt").split("\n")
        return lines.sample()
    end

    def self.choose_game_image(num_wrong)
        case num_wrong
        when 0
            Hangman::EMPTY
        when 1
            Hangman::HEAD
        when 2
            Hangman::NECK
        when 3
            Hangman::ONE_ARM
        when 4
            Hangman::TWO_ARMS
        when 5 
            Hangman::ONE_LEG
        when 6 
            Hangman::FINISHED_MAN
        else 
            Hangman::DEAD_MAN
        end
    end 


end
