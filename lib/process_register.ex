defmodule Server do
  def start do
    Process.register(GenericServer.start(Server), :server)
  end

  def init do
    []
  end

  def call_server(message) do
    GenericServer.call(:server, {:request, "Message #{message}"})
  end

  # avoid bottlenecks => mailbox can take unlimited memory so it might crash the system
  # 5 process in parallel but one process sleeps for 1 second and it finalizes the rest of the 4 process in it's code => so now this process will define the performance of the app => try splitting it into further processes
  def handle_call({:request, message}, _state) do
    Process.sleep(1000)
    {message, []}
  end
end
