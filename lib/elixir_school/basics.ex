defmodule ElixirSchool.Basics do
  def main do
    map1 = %{:foo => "bar", :hello => 1}

    IO.inspect(map1)

    # As of Elixir 1.2, variables are allowed as map keys:
    key = "hello"
    # hello worlds
    IO.inspect(%{key => "worlds"})

    # If a duplicate is added to a map, it will replace the former value:
    # foo will have :ok as it's value
    # IO.inspect(%{foo: "bar", foo: :ok})

    # update a map => key which needs to be updated must exist in the map or else raises error

    IO.inspect(%{map1 | :foo => "barss"})

    # add a new key to map
    IO.inspect(Map.put(map1, :new_key, :ok))
  end
end
