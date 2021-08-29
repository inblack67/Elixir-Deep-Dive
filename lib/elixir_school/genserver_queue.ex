defmodule ElixirSchool.Concurrency.GenServers.Queue do
  use GenServer

  # An OTP server is a module with the GenServer behavior that implements a set of callbacks. At its most basic level a GenServer is a single process which runs a loop that handles one message per iteration passing along an updated state.

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state), do: {:ok, state}

  # It’s often necessary to interact with GenServers in a synchronous way, calling a function and waiting for its response. To handle synchronous requests we need to implement the GenServer.handle_call/3 callback which takes: the request, the caller’s PID, and the existing state; it is expected to reply by returning a tuple: {:reply, response, state}.

  # synchronous

  def handle_call(:dequeue, _from, [first | rest]) do
    {:reply, first, rest}
  end

  def handle_call(:dequeue, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:queue, _from, state) do
    {:reply, state, state}
  end

  # Asynchronous requests are handled with the handle_cast/2 callback. This works much like handle_call/3 but does not receive the caller and is not expected to reply.

  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  def queue, do: GenServer.call(__MODULE__, :queue)
  def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value})
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end
