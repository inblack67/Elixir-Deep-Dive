defmodule Tasks do
  defstruct id: 0, entries: %{}

  # def new, do: %Tasks{}

  # making it so, a new entry can be appended to the prev created tasks
  def new(entries \\ []) do
    Enum.reduce(
      entries,
      # init val of the acc
      %Tasks{},
      fn entry, acc -> add_task(acc, entry) end
    )
  end

  def add_task(task_list, new_task) do
    entry = Map.put(new_task, :id, task_list.id)
    new_entries = Map.put(task_list.entries, task_list.id, entry)

    %Tasks{
      task_list
      | entries: new_entries,
        id: task_list.id + 1
    }
  end

  def get_tasks(task_list) do
    task_list.entries
  end

  # map representation =>
  # [
  #   {0, %{id: 0, title: "t1"}},
  #   {1, %{id: 1, title: "t2"}},
  #   {2, %{id: 2, title: "t3"}},
  #   {3, %{id: 3, title: "t4"}}
  # ]
  def get_tasks_by_id(task_list, id) do
    # streams => async enums => they produce data only on on demand => or else they give
    task_list.entries
    # Stream<[enum: [...], funs: [fns signatures/2]]>
    |> Stream.filter(fn {_index, task} -> task.id === id end)
    # [{1, %{id: 1, title: "t2"}}] # o/p of map
    |> Enum.map(fn x -> x end)
  end

  def update_task(task_list, %{} = new_entry) do
    update_task(task_list, new_entry.id, fn _ -> new_entry end)
  end

  defp update_task(task_list, entry_id, update_fn) do
    case Map.fetch(task_list.entries, entry_id) do
      :error ->
        task_list

      {:ok, old_task} ->
        new_task = update_fn.(old_task)
        new_tasks = Map.put(task_list.entries, entry_id, new_task)
        %Tasks{task_list | entries: new_tasks}
    end
  end

  def delete_task(task_list, id) do
    case Map.fetch(task_list.entries, id) do
      :error ->
        task_list

      {:ok, _} ->
        new_tasks = Map.delete(task_list.entries, id)
        %Tasks{task_list | entries: new_tasks}
    end
  end
end

defmodule TaskServer do
  # client side
  def start do
    GenericServer.start(TaskServer)
  end

  def add_task(server_id, new_entry) do
    GenericServer.cast(server_id, {:add_task, new_entry})
  end

  def get_tasks(server_id) do
    GenericServer.call(server_id, {:get_tasks})
  end

  # server side
  def init do
    Tasks.new()
  end

  def handle_cast({:add_task, new_entry}, task_list) do
    Tasks.add_task(task_list, new_entry)
  end

  def handle_cast({:get_tasks}, task_list) do
    {Tasks.get_tasks(task_list), task_list}
  end
end
