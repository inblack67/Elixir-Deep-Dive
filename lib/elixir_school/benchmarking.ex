defmodule ElixirSchool.BenchMarking do
  def main do
    list = Enum.to_list(1..10_000)
    map_fun = fn i -> [i, i * i] end

    Benchee.run(%{
      "job_flat_map" => fn -> Enum.flat_map(list, map_fun) end,
      "job_flatten" => fn -> list |> Enum.map(map_fun) |> List.flatten() end
    })
  end
end
