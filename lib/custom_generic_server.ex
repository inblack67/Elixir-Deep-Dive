defmodule GenericServer do
  def start(module) do
    spawn(fn ->
      init_state = module.init()
      loop(module, init_state)
    end)
  end

  defp loop(module, current_state) do
    receive do
      # caller => pid
      # {request, caller} ->
      #   {response, new_state} = module.handle_call(request, current_state)
      #   send(caller, {:response, response})
      #   loop(module, new_state)

      {:call, request, caller} ->
        {response, new_state} = module.handle_call(request, current_state)
        send(caller, {:response, response})
        loop(module, new_state)

      {:cast, request} ->
        new_state = module.handle_cast(request, current_state)
        loop(module, new_state)
    end
  end

  # sync reqs
  # def call(server_id, request) do
  #   send(server_id, {request, self()})

  #   receive do
  #     {:response, response} ->
  #       response
  #   end
  # end

  # async reqs => :call
  def call(server_id, request) do
    send(server_id, {:call, request, self()})

    receive do
      {:response, response} ->
        response
    end
  end

  def cast(server_id, request) do
    send(server_id, {:cast, request})
  end
end
