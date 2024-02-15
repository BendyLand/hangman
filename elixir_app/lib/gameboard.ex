defmodule GameBoard do
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
