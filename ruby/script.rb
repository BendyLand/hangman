require_relative "gameboard"

def greet_player()
    puts "Welcome to Hangman! We have already chosen a random word for you.\n"\
         "Let's start by choosing a letter: "
end

def start_game()
    greet_player()
    board = Gameboard.new
    until board.game_over
        choice = board.choose_letter()
        board.update_placeholder()
        board.calculate_num_wrong()
        board.check_game_over()
        board.display(board.num_wrong)
    end
    board.check_game_over()
end

start_game()
