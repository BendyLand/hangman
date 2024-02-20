defmodule GameBoard do
    def run(pid) do
        IO.puts GameState.get_word(pid) # for debugging

        guess = IO.gets(:stdio, "Please enter a letter: ") |> String.trim()
        guess =
            case guess do
                c when c != "" -> String.at(c, 0) |> String.downcase
                "" ->
                    IO.puts "Invalid input. Defaulting to 'a'"
                    "a"
            end

        GameState.guess_letter(pid, guess)
        GameState.check_last_guess(pid)

        IO.inspect(GameState.get_guesses(pid)) # for debugging
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

defmodule GameState do
    use GenServer

    # Public api
    def start_link() do
        GenServer.start_link(__MODULE__, %{
            word: choose_random_word(),
            guesses: [],
            wrong_guesses: 0
        })
    end

    def choose_random_word() do
        GameBoard.choose_random_word()
    end

    def check_game_over(pid) do
        GenServer.call(pid, :check_game_over)
    end

    def check_last_guess(pid) do
        GenServer.call(pid, :check_last_guess)
    end

    def guess_letter(pid, letter) do
        GenServer.cast(pid, {:guess_letter, letter})
    end

    def check_wrong_guesses(pid) do
        GenServer.call(pid, :check_wrong_guesses)
    end

    def get_word(pid) do
        GenServer.call(pid, :get_word)
    end

    def get_guesses(pid) do
        GenServer.call(pid, :get_guesses)
    end

    # GenServer callbacks
    def init(init_state) do
        {:ok, init_state}
    end

    def handle_cast({:guess_letter, letter}, state) do
        new_guesses = [letter | state.guesses]
        new_state = %{state | guesses: new_guesses}
        {:noreply, new_state}
    end

    def handle_call(:check_game_over, _from, state) do
        wrong_guesses = state.wrong_guesses
        random_word = state.word
        guesses = state.guesses
        correct_guesses = Enum.filter(guesses, fn (guess) ->
            String.contains?(random_word, guess)
        end)
        cond do
            wrong_guesses >= 7 ->
                IO.puts "Game over. The word was #{random_word}"
                {:reply, true, state}
            Enum.count(correct_guesses) == String.length(random_word) ->
                IO.puts "You win! The word was #{random_word}"
                {:reply, true, state}
            true ->
                {:reply, false, state}
        end
    end

    def handle_call(:get_state, _from, state) do
        {:reply, state, state}
    end

    def handle_call(:check_last_guess, _from, state) do
        random_word = state.word
        last_guess = hd(state.guesses)
        IO.puts last_guess
        contains = String.contains?(random_word, last_guess)
        IO.puts contains
        if contains do
            {:reply, true, state}
        else
            new_wrong_guesses = state.wrong_guesses + 1
            new_state = %{state | wrong_guesses: new_wrong_guesses}
            {:reply, false, new_state}
        end
    end

    def handle_call(:check_wrong_guesses, _from, state) do
        {:reply, state.wrong_guesses, state}
    end

    def handle_call(:get_word, _from, state) do
        {:reply, state.word, state}
    end

    def handle_call(:get_guesses, _from, state) do
        {:reply, state.guesses, state}
    end
end
