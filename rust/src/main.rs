mod hangman;
mod gameboard;
use gameboard::Hangman;

fn main() {
    let random_word = gameboard::choose_random_word();
    println!("{}", random_word);
    greet();
    println!("{}",gameboard::choose_letter());
    println!("{}", gameboard::choose_game_image(Hangman::OneArm));
}

fn greet() {
    println!("Welcome to Hangman! We have already chosen a random word for you.");
}