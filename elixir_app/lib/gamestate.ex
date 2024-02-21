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
        if not Enum.member?(state.guesses, letter) do
            new_guesses = [letter | state.guesses]
            new_state = %{state | guesses: new_guesses}
            {:noreply, new_state}
        else
            IO.puts "Already guessed that letter!"
            {:noreply, state}
        end

    end

    def handle_call(:check_game_over, _from, state) do
        correct_guesses = Enum.filter(state.guesses, fn (guess) ->
            String.contains?(state.word, guess)
        end)

        random_word_length = 
            state.word
            |> String.split("")
            |> Enum.uniq()
            |> Enum.join("")
            |> String.length()

        cond do
            state.wrong_guesses >= 7 ->
                IO.puts GameBoard.select_game_image(7)
                IO.puts "Game over. The word was #{state.word}"
                {:reply, true, state}

            Enum.count(correct_guesses) == random_word_length ->
                image = GameBoard.select_game_image(state.wrong_guesses)
                placeholder = GameBoard.construct_placeholder(
                    state.guesses,
                    state.word
                )
                GameBoard.display(image, placeholder)
                IO.puts "You win! The word was #{state.word}"
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
        contains = String.contains?(random_word, last_guess)
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