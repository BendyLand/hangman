defmodule GameState do
    use GenServer

    def init(init_state) do
        {:ok, init_state}
    end

    # this is explicitly called at the start of Main
    def start_link() do
        GenServer.start_link(__MODULE__, %{
            word: choose_random_word(),
            guesses: ['a', 'b', 'c'], # just for testing; change later
            wrong_guesses: 0
        })
    end

    # this is called when the GenServer initializes with start_link()
    def choose_random_word() do
        GameBoard.choose_random_word()
        # testing to ensure proper message passing; change later
        "hangman"
    end

    # this is called from get_word()
    def handle_call(:get_word, _from, state) do
        {:reply, state.word, state}
    end

    # this is called from get_guesses()
    def handle_call(:get_guesses, _from, state) do
        {:reply, state.guesses, state}
    end

    # these get called from Main
    def get_word(pid) do
        GenServer.call(pid, :get_word)
    end

    def get_guesses(pid) do
        GenServer.call(pid, :get_guesses)
    end
end

defmodule Main do
    {:ok, pid} = GameState.start_link()
    word = GameState.get_word(pid)
    guesses = GameState.get_guesses(pid)

    # basic testing
    IO.puts word    == "hangman" # true
    IO.puts guesses == ['a', 'b', 'c'] # true
end
