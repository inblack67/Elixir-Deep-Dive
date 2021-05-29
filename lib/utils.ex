defmodule Utils do
  # single line func macro
  def area(a, b), do: a * b

  defmodule Circle do
    def area(r), do: 3.14 * r * r
  end

  # func with no arg have optional parenthesis
  def greet, do: "hello worlds"

  # funcs ending with ! => could cause error at runtime
  # ? => might return a boolean val
  # no return keyword => returns the last line of the func

  def main do
    # first class citizens => function definition assigned to a var
    # anonymous func
    sum = fn a, b -> a + b end
    IO.puts(sum.(2, 2))

    # binding IO puts of one arg to a variable using & (capture operator)
    myputs = &IO.puts/1

    myputs.("ok world")
  end
end
