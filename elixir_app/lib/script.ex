defmodule Main do
    {err, pid} = GameState.start_link()
    if err == :ok do
        GameBoard.run(pid)
    else
        IO.puts "Unable to start game."
    end
end
