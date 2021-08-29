defmodule ElixirSchool.Concurrency.Tasks do
  # Tasks provide a way to execute a function in the background and retrieve its return value later. They can be particularly useful when handling expensive operations without blocking the application execution.

  def main do
    task = Task.async(__MODULE__, :calculate_something, [10])
    Task.await(task)
  end

  @spec calculate_something(number) :: number
  def calculate_something(input) do
    :timer.sleep(500)
    input * input
  end
end
