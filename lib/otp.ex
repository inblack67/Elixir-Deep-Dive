defmodule OTP do
  def main do
    first_class()
  end

  def first_class do
    io_module = IO
    io_module.puts("hello")
  end
end
