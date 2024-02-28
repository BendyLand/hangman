mod hangman;
mod gameboard;
use gameboard::{GameState, check_num_wrong, guess_letter};

fn main() {
    let initial_state = greet();

    let mut state =
        GameState {
            word: initial_state.word,
            wrong_guesses: 0,
            guessed_letters: vec![],
        };

    // Game loop
    while !gameboard::check_game_over(&state) {
        state.guessed_letters = guess_letter(&state);
        state.wrong_guesses = check_num_wrong(&state);
        gameboard::display_game_board(&state);
    }
}

fn greet() -> GameState {
    println!("Welcome to Hangman! We have already chosen a random word for you.");
    let random_word = gameboard::choose_random_word();
    let initial_state =
        GameState {
            word: random_word,
            wrong_guesses: 0,
            guessed_letters: vec![]
        };
    gameboard::display_game_board(&initial_state);
    initial_state
}