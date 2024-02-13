require_relative "hangman"

class Gameboard
    attr_accessor :random_word, :guessed_chars, :num_wrong, :placeholder, :game_over
    
    def initialize() 
        @random_word = choose_random_word()
        @guessed_chars = []
        @num_wrong = 0
        @placeholder = ""
        @game_over = false
    end

    def choose_random_word() 
        lines = File.read("../words.txt").split("\n")
        @random_word = lines.sample()
    end

    def choose_game_image()
        case @num_wrong
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

    def choose_letter() 
        input = gets.chomp
        begin
            input = input[0]
            input = input.downcase
            unless @guessed_chars.include?(input)
                @guessed_chars.push(input) 
            else
                puts "Already guessed that letter!"    
            end
        rescue
            puts "Invalid input! Defaulting to 'a'"
            unless @guessed_chars.include?('a')
                @guessed_chars.push('a')
            end
        end 
    end

    def update_placeholder()
        @placeholder = ""
        @random_word.length.times do |i|
            @placeholder += @guessed_chars.include?(@random_word[i]) ? 
                @random_word[i] + " " :  "_ " 
        end
        @placeholder = @placeholder.chomp
    end

    def calculate_num_wrong()
        correct_guesses = @guessed_chars.select do |c| 
            random_word.include?(c) 
        end 
        @num_wrong = @guessed_chars.length - correct_guesses.length
    end

    def display()
        image = choose_game_image()
        puts image + "\n" + @placeholder + "\n"
    end

    def check_game_over()
        correct_guesses = @guessed_chars.select do |c| 
            random_word.include?(c) 
        end 
        random_word_length = @random_word.split("").uniq.join("").length
        if @num_wrong >= 7 
            puts "Game over! The word was #{@random_word}"
            @game_over = true
        elsif correct_guesses.length >= random_word_length
            puts "You win! The word was #{@random_word}"
            @game_over = true
        else 
            @game_over = false
        end
    end
end