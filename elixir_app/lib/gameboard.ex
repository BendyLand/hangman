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

defmodule GameState do
    use GenServer

    def init(init_state) do
        {:ok, init_state}
    end

    def start_link() do
        GenServer.start_link(__MODULE__, %{
            word: choose_random_word(),
            guesses: [],
            wrong_guesses: 0
        })
    end

    def guess_letter(pid, letter) do
        GenServer.cast(pid, {:guess_letter, letter})
    end

    def handle_cast({:guess_letter, letter}, state) do
        new_guesses = [letter | state.guesses]
        new_state = %{state | guesses: new_guesses}
        {:noreply, new_state}
    end

    def check_num_wrong(pid) do
        GenServer.call(pid, :check_num_wrong)
    end

    def handle_call(:check_num_wrong, _from, state) do
        {:reply, state.wrong_guesses, state}
    end

    def choose_random_word() do
        GameBoard.choose_random_word()
    end

    def get_word(pid) do
        GenServer.call(pid, :get_word)
    end

    def get_guesses(pid) do
        GenServer.call(pid, :get_guesses)
    end

    def handle_call(:get_word, _from, state) do
        {:reply, state.word, state}
    end

    def handle_call(:get_guesses, _from, state) do
        {:reply, state.guesses, state}
    end
end
