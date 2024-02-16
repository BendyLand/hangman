defmodule Counter do
    use GenServer

    # Public API
    def start_link() do
        GenServer.start_link(__MODULE__, 0)
    end
    def add(pid, num) do
        GenServer.cast(pid, {:add, num})
    end
    def get_count(pid) do
        GenServer.call(pid, :get_count)
    end

    # GenServer callbacks
    def init(initial_state) do
        {:ok, initial_state}
    end
    def handle_cast({:add, new_num}, state) do
        {:noreply, state + new_num}
    end
    def handle_call(:get_count, _from, state) do
        {:reply, state, state}
    end
end

{err, pid} = Counter.start_link()
if err == :ok do
    Counter.add(pid, 1)
    Counter.add(pid, 3)
    Counter.add(pid, 5)
    count = Counter.get_count(pid)
    IO.puts("Current count: #{count}")
else
    IO.puts "Error running Counter"
end
