defmodule ElixirSchool.ErrorHandling do
  def main do
    try do
      # raise "hacked!"
      # raise ArgumentError, message: "invalid"
      raise CustomError
    rescue
      e in ArgumentError -> IO.puts("args error #{e.message}")
      e in CustomError -> IO.puts("custom error #{e.message}")
      e -> IO.inspect(e.message)
    after
      IO.inspect("done rescuing")
    end
  end
end

defmodule CustomError do
  defexception message: "custom error"
end
