use std::fs::{read_to_string};
use rand::{Rng, thread_rng};

pub fn choose_random_word() -> String {
    let path = "../words.txt";
    let contents = read_to_string(path).expect("Error reading file.");
    let lines: Vec<&str> = contents.split("\n").collect();
    let rand_num = thread_rng().gen_range(0..lines.len());
    String::from(lines[rand_num])
}