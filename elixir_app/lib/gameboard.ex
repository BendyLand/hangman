defmodule GameBoard do
    def run(pid) do
        num_wrong = GameState.check_wrong_guesses(pid)
        IO.puts GameBoard.select_game_image(num_wrong)

        guess = IO.gets(:stdio, "Please enter a letter: ") |> String.trim()
        guess =
            case guess do
                "" ->
                    IO.puts "Invalid input. Defaulting to 'a'"
                    "a"
                c when c != "" -> 
                    String.at(c, 0) |> String.downcase
            end

        temp_len = Enum.count(GameState.get_guesses(pid))
        GameState.guess_letter(pid, guess)
        new_len = Enum.count(GameState.get_guesses(pid))

        if temp_len != new_len do
            GameState.check_last_guess(pid)
        end

        game_over = GameState.check_game_over(pid)
        if game_over == false do
            run(pid)
        end
    end

    def choose_random_word() do
        {err, file} = File.read("../words.txt")
        case err do
            :ok ->
                lst = String.split(file)
                len = Enum.count(lst)
                num = Enum.random(0..len)
                Enum.at(lst, num)
            _ ->
                "Error reading file"
        end
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
end
