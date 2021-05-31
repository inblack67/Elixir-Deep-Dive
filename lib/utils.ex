defmodule Utils do
  # single line func macro
  def area(a, b), do: a * b

  defmodule Circle do
    def area(r), do: 3.14 * r * r
  end

  # func with no arg have optional parenthesis
  def greet, do: "hello worlds"

  # funcs ending with ! => could cause error at runtime
  # ? => might return a boolean val
  # no return keyword => returns the last line of the func

  def main do
    # first class citizens => function definition assigned to a var
    # anonymous func
    sum = fn a, b -> a + b end
    IO.puts(sum.(2, 2))

    # binding IO puts of one arg to a variable using & (capture operator)
    myputs = &IO.puts/1

    myputs.("ok world")

    # create anonymous functions using capture operator
    lamba = &(&1 * &2 + &3)
    IO.puts(lamba.(2, 3, 4))

    # closure
    global = 10
    closure = fn data -> IO.puts(data) end
    # 10
    closure.(global)
    global = 200
    # 10
    # keeps the ref to prev var (10)
    closure.(global)
    # 200
    IO.puts(global)

    # reference type => unique piece of info inside beam instance
    # 2^80 seconds call after => ref will repeat itself => highly unlikely
    # ref will be generated whenever iex(beam) instance restarts so uniqueness is only guranteed during the iex session

    # pids => process ids
    # port identifier => talk with outside world
    IO.puts("uses ports to log output in iex shell")

    # range => map with boundaries
    range = 1..10
    IO.inspect(range)
    IO.puts(1 in range)

    # keyword lists => list of elements with key and value where key  is an atom and value could be any type => any lookup operation will have linear complexity
    # can contain multiple values of the same key
    # maintains order
    # both of the above => map cant
    # useful in diff types of arguments requied by functions
    alpha = [{:a, 1}, {:b, 2}]
    IO.inspect(alpha)
    # 2
    IO.puts(Keyword.get(alpha, :b))
    IO.puts(alpha[:c])

    IO.inspect([1, 2, 3], width: 1, limit: 1)

    # mapsets => keys of a hashmap => enumerable
    keys = MapSet.new([:a, :b, :c])
    # false
    MapSet.member?(keys, :d)
    _new_keys = MapSet.put(keys, :d)

    # dates
    # YYYY-MM-DD
    date = ~D[2021-06-01]
    IO.puts(date.year)
    IO.puts(date.month)
    IO.puts(date.day)

    time = ~T[12:31:23.0001]
    IO.puts(time.hour)
    IO.puts(time.minute)
    IO.puts(time.second)

    naive_datetime = ~N[2021-06-01 12:31:23.0001]
    IO.puts(naive_datetime.year)

    datetime = DateTime.from_naive!(naive_datetime, "Etc/UTC")
    IO.puts(datetime.time_zone)

    # pin opeator
    # cannot be rematched (constant binding)
    x = 10
    # now x will only match 10
    {^x, _} = {10, 11}
    # now it can match anything
    {x, _} = {12, 11}
    IO.puts(x)

    [min | _] = Enum.sort([1, 2, 3, 4])
    IO.puts(min)

    # partial pattern matching in maps
    %{age: age} = %{name: "john", age: 22}
    IO.puts(age)

    # = => not assignment but pattern matching
    # valid
    1 = 1

    area({2, 3})
    # functions can be overloaded as log as each function uses different patterns in it's args
    # IO.puts(get_area({:circle, 4}))
    # IO.puts(get_area({:rectangle, 4, 2}))
    # IO.inspect(get_area({:none, 5, 5, 5, 5}))

    IO.puts(test(-1))
    IO.puts(test(0))
    IO.puts(test(1))
    # will satisft >0 condition and return positive so better check if x is a number or not
    # IO.puts(test(:atom))

    # can compare anything => precedence
    # number < atom < reference < function < port < pid < tuple < map < list < bitstring (binary)

    # lambda functions
    cool_lambda = fn
      x when is_number(x) and x < 0 ->
        :negative

      0 ->
        :zero

      x when is_number(x) and x > 0 ->
        :positive
    end

    cool_lambda.(12)
  end

  def area({a, b}) do
    a * b
  end

  # def get_area({:cicle, r}) do
  #   r * r * 3.14
  # end

  # def get_area({:rectangle, a, b}) do
  #   a * b
  # end

  # def get_area(unkown) do
  #   {:error, {:unknown_shape, unkown}}
  # end

  # guards
  # order of functions using when(guards)matters
  def test(x) when is_number(x) and x < 0, do: :negative
  def test(0), do: :zero
  def test(x) when is_number(x) and x > 0, do: :positive

  # conditional macros => if, else, unless, cond
  def max(a, b) do
    cond do
      a >= b -> a
      # if above conditions fail => default this
      true -> b
    end
  end

  # case
  def max_2(a, b) do
    case a >= b do
      true -> a
      false -> b
      # catch
      _ -> :error
    end
  end

  # with clause
  def extract_user(user) do
    with {:ok, login} <- extract_login(user),
         {:ok, email} <- extract_email(user),
         {:ok, password} <- extract_password(user) do
      {:ok, %{login: login, email: email, password: password}}
    end
  end

  defp extract_login(%{"login" => login}), do: {:ok, login}
  defp extract_login(_), do: {:error, "login missing"}
  defp extract_email(%{"email" => email}), do: {:ok, email}
  defp extract_email(_), do: {:error, "email missing"}
  defp extract_password(%{"password" => password}), do: {:ok, password}
  defp extract_password(_), do: {:error, "password missing"}
end
