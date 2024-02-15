defmodule Gameboard do
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
end


defmodule Main do
    IO.puts Gameboard.choose_random_word()
end
