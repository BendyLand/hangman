mod hangman;
mod gameboard;

fn main() {
    let random_word = gameboard::choose_random_word();
    println!("{}", random_word);
    greet();
    println!("{}",gameboard::choose_letter())
}

fn greet() {
    println!("Welcome to Hangman! We have already chosen a random word for you.");
}