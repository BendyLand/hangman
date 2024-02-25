mod hangman;
mod gameboard;
use gameboard::{GameState};

fn main() {
    let random_word = gameboard::choose_random_word();
    greet();

    let initial_state = 
        GameState {
            word: random_word,
            wrong_guesses: 0,
            guessed_letters: vec![],
        };

    println!("Random word: {:?}", initial_state.word);
}

fn greet() {
    println!("Welcome to Hangman! We have already chosen a random word for you.");
}