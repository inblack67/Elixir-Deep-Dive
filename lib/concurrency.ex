defmodule Ok do
  def main do
    # sync_fn(1)
    # 5 seconds per x => 25 seconds in total => poor code
    # o/p => ["1", "2", "3", "4", "5"]
    # Enum.map(1..5, fn x -> sync_fn(x) end)

    # output all just after 5 seconds => all process executed in parallel => order is not guranteed
    # Enum.map(1..5, fn x -> async_fn(x) end)

    # messages between processes
    greet_youself()
  end

  def sync_fn(x) do
    # waits for 5 seconds
    Process.sleep(5000)
    "#{x}"
  end

  def async_fn(x) do
    spawn(fn -> IO.puts(sync_fn(x)) end)
  end

  # messages stays in the mail box of the process => until we access it
  # if mail box is empty and receive call is made => it will block the shell and wait for a new message to arrive => indefinitely
  # after => do something after calling receive => so afte code is not blocked
  def greet_youself do
    send(self(), "hello")

    receive do
      msg -> IO.puts("received #{msg}")
    after
      # to check => comment out the send line
      5000 -> IO.puts("error no message")
    end
  end

  # pattern matching gives error if not matched but in processes case => if a message is not matched => it will be put back in the mail box => message pattern checking => first to last

  def parallel_sum do
  end
end
