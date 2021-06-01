defmodule Deepdive.Recursion do
  def main do
    print(3)
    sum([1, 2, 3])

    # tail call optimization => function which call another function or itself => it's the last thing that a function does (tail recursion)
    #  no extra stack space is allocated
    # no additional memory
    # function can run virtually forever without consuming any memory

    # fib_started = :os.system_time(:seconds)
    # IO.puts(fib(40))
    # fib_ended = :os.system_time(:seconds)
    # IO.puts("fib took #{fib_ended - fib_started} seconds") # 2

    optimized_fib_started = :os.system_time(:seconds)
    IO.puts(optimized_fib(40))
    optimized_fib_ended = :os.system_time(:seconds)
    # 0
    IO.puts("optimized_fib took #{optimized_fib_ended - optimized_fib_started} seconds")

    perfom_enums()
  end

  def print(0), do: :ok

  def print(n) do
    print(n - 1)
    IO.puts(n)
  end

  def sum([]), do: 0

  def sum([head | tail]) do
    head + sum(tail)
  end

  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) when n < 0, do: :error
  # not tail recursion => last thing fib does is addition => not a function call
  def fib(n), do: fib(n - 1) + fib(n - 2)

  # tail recursion
  def optimized_fib(n) when n < 0, do: :error
  def optimized_fib(n), do: optimized_fib(n, 1, 0)
  defp optimized_fib(0, _, result), do: result
  defp optimized_fib(n, next, result), do: optimized_fib(n - 1, next + result, next)

  def perfom_enums do
    # 15 => x will have accumulator's value (initially 0) and y will have list's item value
    Enum.reduce([1, 2, 3, 4, 5], 0, fn x, y -> x + y end)

    # comprehension
    _res1 = for x <- [1, 2, 3], do: x * x

    # nested
    _res2 = for x <- [1, 2, 3], y <- [1, 2, 3], do: {x, y, x + y}

    table = for x <- 1..9, y <- 1..9, x < y, into: %{}, do: {{x, y}, x * y}

    table[{1, 2}]
  end
end
