defmodule ElixirSchool.Concurrency.Agents do
  # Agents are an abstraction around background processes maintaining state. We can access them from other processes within our application and node. The state of our Agent is set to our function’s return value:

  def main do
    {:ok, pid} = Agent.start_link(fn -> [1, 2, 3] end)

    Agent.update(pid, fn old_state -> old_state ++ [4, 5] end)

    Agent.get(pid, & &1)
    Agent.get(pid, fn state -> IO.inspect(state) end)

    # When we name an Agent we can refer to it by that instead of its PID:

    Agent.start_link(fn -> [5, 5, 5] end, name: :my_agent)

    Agent.get(:my_agent, & &1)
  end
end
