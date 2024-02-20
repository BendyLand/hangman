defmodule StateManager do
    use GenServer

    # Public API
    def start_link(name, age) do
        initial_state = %{
            name: name,
            age: age,
            extras: []
        }
        GenServer.start_link(__MODULE__, initial_state)
    end

    def get_name(pid) do
        GenServer.call(pid, :get_name)
    end

    def add_item_to_extras(pid, item) do
        GenServer.cast(pid, {:add_item_to_extras, item})
    end

    def get_extras(pid) do
        GenServer.call(pid, :get_extras)
    end

    # GenServer callbacks
    def init(init_state) do
        {:ok, init_state}
    end

    def handle_call(:get_name, _from, state) do
        {:reply, state.name, state}
    end

    def handle_call(:get_extras, _from, state) do
        {:reply, state.extras, state}
    end

    def handle_cast({:add_item_to_extras, item}, state) do
        new_extras = [item | state.extras]
        new_state = %{state | extras: new_extras}
        {:noreply, new_state}
    end
end

{err, pid} = StateManager.start_link("Ben", 26)
if err == :ok do
    # name = StateManager.get_name(pid)
    # IO.puts name

    StateManager.add_item_to_extras(pid, "extra item 1")
    StateManager.add_item_to_extras(pid, "extra item 2")
    StateManager.add_item_to_extras(pid, "extra item 3")
    StateManager.add_item_to_extras(pid, "extra item 4")

    # extras = StateManager.get_extras(pid)
    # IO.inspect(extras)
else
    IO.puts "Error!"
end

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

    # count = Counter.get_count(pid)
    # IO.puts("Current count: #{count}")
else
    IO.puts "Error running Counter"
end
