mod hangman;
mod gameboard;

fn main() {
    let random_word = gameboard::choose_random_word();
    println!("{}", random_word);
}