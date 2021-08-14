defmodule ElixirSchool.Executable do
  # mix escript.build

  def main(args \\ []) do
    args
    |> parse_args()
    |> response()
    |> IO.puts()
  end

  defp parse_args(args) do
    IO.puts("args => ")
    IO.inspect(args)

    {opts, word, _} =
      args
      |> OptionParser.parse(switches: [upcase: :boolean])

    IO.puts("OptionParser res => ")
    IO.inspect(opts)
    IO.inspect(word)

    {opts, List.to_string(word)}
  end

  defp response({opts, word}) do
    if opts[:upcase], do: String.upcase(word), else: word
  end
end
