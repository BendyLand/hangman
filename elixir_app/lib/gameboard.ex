defmodule GameBoard do
    def run(pid) do
        {game_image, placeholder} = GameBoard.get_info(pid)
        old_len = Enum.count(GameState.get_guesses(pid))
        GameBoard.display(game_image, placeholder)

        guess = GameBoard.make_guess()
        GameState.guess_letter(pid, guess)
        new_len = Enum.count(GameState.get_guesses(pid))

        if old_len != new_len do
            GameState.check_last_guess(pid)
        end

        game_over = GameState.check_game_over(pid)
        if not game_over do
            run(pid)
        end
    end

    def choose_random_word() do
        {err, file} = File.read("../words.txt")
        word = 
            case err do
                :ok ->
                    lst = String.split(file)
                    len = Enum.count(lst)
                    num = Enum.random(0..len)
                    Enum.at(lst, num)
                _ ->
                    "Error reading file"
            end
        String.downcase(word)
    end

    def select_game_image(num_wrong) do
        case num_wrong do
            0 -> Hangman.empty()
            1 -> Hangman.head()
            2 -> Hangman.neck()
            3 -> Hangman.one_arm()
            4 -> Hangman.two_arms()
            5 -> Hangman.one_leg()
            6 -> Hangman.finished_man()
            _ -> Hangman.dead_man()
        end
    end

    def get_info(pid) do
        num_wrong = GameState.check_wrong_guesses(pid)
        game_image = GameBoard.select_game_image(num_wrong)
        placeholder = GameBoard.construct_placeholder(
            GameState.get_guesses(pid),
            GameState.get_word(pid)
        )
        {game_image, placeholder}
    end

    def make_guess() do
        guess = IO.gets(:stdio, "Please enter a letter: ") |> String.trim()
        guess =
            case guess do
                "" ->
                    IO.puts "Invalid input. Defaulting to 'a'"
                    "a"
                c when c != "" -> 
                    String.at(c, 0) |> String.downcase
            end
        guess
    end

    def construct_placeholder(guesses, random_word) do
        random_word_letters = 
            String.split(random_word, "") 
            |> Enum.filter(fn (x) -> x != "" end)

        str = 
            Enum.map(random_word_letters, fn (c) ->
                case Enum.member?(guesses, c) do
                    true  -> c 
                    false -> "_"
                end
            end)
            |> Enum.join(" ")

        str
    end

    def display(game_image, placeholder) do
        IO.puts(game_image <> "\n" <> placeholder <> "\n")
    end
end
