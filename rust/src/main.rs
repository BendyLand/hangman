mod hangman;
mod gameboard;
use gameboard::{GameState};

use crate::gameboard::update_game_state;

fn main() {
    let random_word = gameboard::choose_random_word();
    greet();

    let initial_state = 
        GameState {
            word: random_word,
            wrong_guesses: 0,
            guessed_letters: vec![],
        };
    // Game loop
    loop {
        let guess = gameboard::guess_letter();
        let new_state = update_game_state(initial_state);
        println!("{}", guess);
        println!("{:?}", new_state);




        break;
    }
}

fn greet() {
    println!("Welcome to Hangman! We have already chosen a random word for you.");
}