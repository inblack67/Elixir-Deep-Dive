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

    # The throw/1 function gives us the ability to exit execution with a specific value we can catch and use
    try do
      for x <- 1..10 do
        if x == 5 do
          throw(x)
        else
          IO.puts("#{x}")
        end
      end
    catch
      x -> "Caught: #{x}"
    end
  end

  try do
    exit("reason for exit")
  catch
    :exit, reason -> IO.inspect("exit - reason #{reason}")
  end

  # While it is possible to catch an exit with try/catch doing so is extremely rare. In almost all cases it is advantageous to let the supervisor handle the process exit:
end

defmodule CustomError do
  defexception message: "custom error"
end
