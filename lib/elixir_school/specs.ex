defmodule ElixirSchool.Specs do
  @spec product_with_and_sum(integer) :: number
  def product_with_and_sum(num) do
    [1, 2, 3]
    |> Enum.map(fn x -> x * num end)
    |> Enum.sum()
  end
end
