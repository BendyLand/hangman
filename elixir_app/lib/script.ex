defmodule Main do
    {err, pid} = GameState.start_link()
    if err == :ok do
        IO.puts "Welcome to Hangman! We have already chosen a random word for you."
        GameBoard.run(pid)
    else
        IO.puts "Unable to start game."
    end
end
