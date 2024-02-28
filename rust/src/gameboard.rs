#![allow(dead_code)]
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

pub fn update_num_wrong(state: GameState) -> GameState {
    let num_wrong = 
        state.guessed_letters
            .iter()
            .filter(|x| !state.word.contains(**x))
            .collect::<Vec<&char>>()
            .len() as u8;
    GameState {
        wrong_guesses: num_wrong,
        ..state
    }
}

pub fn add_guess(state: GameState) -> GameState {
    println!("Please enter a letter: ");
    let mut temp = state.guessed_letters.clone();
    let mut input = String::new();
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
                temp.push(final_result);
                GameState {
                    guessed_letters: temp,
                    ..state
                }
            }
            else {
                println!("Error getting input. Defaulting to 'a'");
                temp.push('a');
                GameState {
                    guessed_letters: temp,
                    ..state
                }
            }
        },
        Err(err) => {
            println!("Error reading input: {}. Defaulting to 'a'", err);
            temp.push('a');
            GameState {
                guessed_letters: temp,
                ..state
            }
        }
    }
}

pub fn choose_game_image(state: Hangman) -> String {
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