use std::{fs::read_to_string, io::stdin};
use rand::{Rng, thread_rng};
use crate::hangman;

#[derive(Debug)]
pub enum Hangman {
    Empty,
    Head,
    Neck,
    OneArm,
    TwoArms,
    OneLeg,
    FinishedMan,
    DeadMan,
}

#[derive(Debug, Clone)]
pub struct GameState {
    pub word: String,
    pub wrong_guesses: u8,
    pub guessed_letters: Vec<char>,
}

pub fn guess_letter(state: &GameState) -> Vec<char> {
    println!("Please enter a letter: ");
    let mut input = String::new();
    let letter =
        match stdin().read_line(&mut input) {
            Ok(_) => {
                let result = input.trim();
                if !result.is_empty() {
                    let final_result =
                        result
                            .chars()
                            .next()
                            .unwrap()
                            .to_ascii_lowercase();
                    final_result
                }
                else {
                    println!("Error getting input. Defaulting to 'a'");
                    'a'
                }
            },
            Err(err) => {
                println!("Error reading input: {}. Defaulting to 'a'", err);
                'a'
            }
        };
    add_guess(letter, &state.guessed_letters)
}

fn add_guess(guess: char, current_guesses: &Vec<char>) -> Vec<char> {
    let mut new_vec = current_guesses.clone();
    if current_guesses.contains(&guess) {
        println!("Already guessed that letter!");
        new_vec
    }
    else {
        new_vec.push(guess);
        new_vec.dedup();
        new_vec
    }
}

fn get_hangman_state(num_wrong: u8) -> Hangman {
    match num_wrong {
        0 => Hangman::Empty,
        1 => Hangman::Head,
        2 => Hangman::Neck,
        3 => Hangman::OneArm,
        4 => Hangman::TwoArms,
        5 => Hangman::OneLeg,
        6 => Hangman::FinishedMan,
        _ => Hangman::DeadMan,
    }
}

pub fn check_num_wrong(state: &GameState) -> u8 {
    let num_wrong =
        state.guessed_letters
            .iter()
            .filter(|x| !state.word.contains(**x))
            .collect::<Vec<&char>>()
            .len() as u8;
    num_wrong
}

pub fn check_game_over(state: &GameState) -> bool {
    let correct_guesses =
        state.guessed_letters.len() - check_num_wrong(&state) as usize;
    let mut random_word_as_vec = state.word.chars().collect::<Vec<char>>();
    random_word_as_vec.dedup();
    let correct_num_letters = random_word_as_vec.len();
    if state.wrong_guesses >= 7 {
        println!("Game over. The word was {}", state.word);
        true
    }
    else if correct_guesses >= correct_num_letters {
        println!("You win! The word was {}", state.word);
        true
    }
    else {
        false
    }
}

pub fn display_game_board(state: &GameState) {
    let hangman = get_hangman_state(state.wrong_guesses);
    let image = choose_game_image(hangman);
    let char_vector =
        state.word
            .chars()
            .map(|c|
                if state.guessed_letters.contains(&c) { c }
                else { '_' }
            )
            .collect::<Vec<char>>();
    let mut result_string: String = String::new();
    for c in char_vector {
        result_string += c.to_string().as_str();
        result_string += " ";
    }
    result_string = result_string.trim_end().to_string();
    println!("{}\n{}\n", image, result_string);
}

fn choose_game_image(state: Hangman) -> String {
    match state {
        Hangman::Empty       => String::from(hangman::EMPTY),
        Hangman::Head        => String::from(hangman::HEAD),
        Hangman::Neck        => String::from(hangman::NECK),
        Hangman::OneArm      => String::from(hangman::ONE_ARM),
        Hangman::TwoArms     => String::from(hangman::TWO_ARMS),
        Hangman::OneLeg      => String::from(hangman::ONE_LEG),
        Hangman::FinishedMan => String::from(hangman::FINISHED_MAN),
        Hangman::DeadMan     => String::from(hangman::DEAD_MAN),
    }
}

pub fn choose_random_word() -> String {
    let path = "../words.txt";
    let contents =
        match read_to_string(path) {
            Ok(file) => file,
            Err(err) => {
                println!("Error: {:?}\nDefaulting to word \"error\"", err);
                String::from("error")
            },
        };
    let lines: Vec<&str> = contents.split("\n").collect();
    let rand_num = thread_rng().gen_range(0..lines.len());
    String::from(lines[rand_num])
}