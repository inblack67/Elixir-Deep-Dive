defmodule ElixirSchool.ErrorHandling do
  def main do
    try do
      # raise "hacked!"
      raise ArgumentError, message: "invalid"
    rescue
      e in ArgumentError -> IO.puts("args error #{e.message}")
      e -> IO.inspect(e.message)
    after
      IO.inspect("done rescuing")
    end
  end
end
