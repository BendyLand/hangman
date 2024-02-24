use std::fs;
use rand::Rng;

pub fn choose_random_word() -> String {
    let path = "../words.txt";
    let contents = fs::read_to_string(path).expect("Error reading file.");
    let lines: Vec<&str> = contents.split("\n").collect();
    let rand_num = ((rand::thread_rng().gen::<u16>()) % lines.len() as u16) as usize;
    String::from(lines[rand_num])
}