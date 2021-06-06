defmodule TaskList do
  def new, do: MultiStorage.new()

  # TaskList.new |> TaskList.add_task(~D[2021-01-01], "okay") |> TaskList.get_tasks(~D[2021-01-01])
  def add_task(task_list, date, body) do
    # insert body as init if list with date not found => if found update via lambda
    MultiStorage.add(task_list, date, body)
  end

  def get_tasks(task_list, date) do
    MultiStorage.get(task_list, date)
  end
end

defmodule MultiStorage do
  def new(), do: %{}

  def add(storage, key, value) do
    Map.update(storage, key, [value], fn values -> [value | values] end)
  end

  def get(storage, key) do
    # 3rd arg is default
    Map.get(storage, key, [])
  end

end
