defmodule Main do
    {err, pid} = GameState.start_link()
    if err == :ok do
        # main logic
        IO.puts GameState.get_word(pid)
        GameState.guess_letter(pid, 'q')
        IO.inspect GameState.get_guesses(pid)
        IO.puts GameState.check_num_wrong(pid)

    else
        IO.puts "Unable to start game."
    end

end
