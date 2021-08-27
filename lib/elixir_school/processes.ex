defmodule ElixirSchool.Concurrency.Processes do
  def main do
    # sync
    add(1, 2)
    spawn(__MODULE__, :add, [1, 3])
    pid = spawn(__MODULE__, :listen, [])
    send(pid, {:ok, "yo"})

    # One problem with spawn is knowing when a process crashes. For that we need to link our processes using spawn_link. Two linked processes will receive exit notifications from one another:

    # spawn_link(__MODULE__, :boom, [])

    trap()
    monitor()
  end

  def add(a, b), do: a + b

  def listen do
    receive do
      {:ok, message} ->
        IO.inspect(message)
    end

    # to keep listening after receiving the message
    # listen()
  end

  def boom, do: exit(:boom)

  def trap do
    # Sometimes we don’t want our linked process to crash the current one. For that we need to trap the exits using Process.flag/2. It uses erlang’s process_flag/2 function for the trap_exit flag. When trapping exits (trap_exit is set to true), exit signals will be received as a tuple message: {:EXIT, from_pid, reason}.

    Process.flag(:trap_exit, true)
    spawn_link(__MODULE__, :boom, [])

    receive do
      {:EXIT, _pid, reason} ->
        IO.puts("crashed because of #{reason}")
    end
  end

  def monitor do
    # What if we don’t want to link two processes but still be kept informed? For that we can use process monitoring with spawn_monitor. When we monitor a process we get a message if the process crashes without our current process crashing or needing to explicitly trap exits.

    spawn_monitor(__MODULE__, :boom, [])

    receive do
      {:DOWN, _ref, :process, _pid, reason} ->
        IO.inspect("monitored process crashed with reason #{reason}")
    end
  end
end
