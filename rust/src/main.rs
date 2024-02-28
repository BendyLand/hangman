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
    // Game loop
    loop {
        let guessed_state = gameboard::add_guess(initial_state);
        let updated_state = gameboard::update_num_wrong(guessed_state);

        println!("{:?}", updated_state);

        break;
    }
}

fn greet() {
    println!("Welcome to Hangman! We have already chosen a random word for you.");
}