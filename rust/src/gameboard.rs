use std::{fs::read_to_string, io::stdin};
use rand::{Rng, thread_rng};

pub fn choose_random_word() -> String {
    let path = "../words.txt";
    let contents = read_to_string(path).expect("Error reading file.");
    let lines: Vec<&str> = contents.split("\n").collect();
    let rand_num = thread_rng().gen_range(0..lines.len());
    String::from(lines[rand_num])
}

pub fn choose_letter() -> char {
    println!("Please enter a letter: ");
    let mut input = String::new();
    match stdin().read_line(&mut input) {
        Ok(_) => {
            let result = input.trim();
            if !result.is_empty() {
                result
                    .chars()
                    .next()
                    .unwrap()
                    .to_ascii_lowercase()
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
    }
}