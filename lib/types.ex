defmodule Types do
  # every operation, every function, every block is an expression
  # and each expression returns something
  # pattern matching 10 to variable x
  x = 10
  IO.inspect(x)

  _bigNumber = 100_00_00

  # atoms => literal named constants => enums
  _atom1 = :atom
  _atom2 = :"atom with space"

  # whatever put after : (atom text) is kept inside the atom table
  # and the value is the data that goes into the atoms table and it's merely a ref to the atom table
  # atoms are efficient both, in memory and in perfomance => that's why they are used as named constants
  # var contains the ref to the atom
  _var = :atom2

  # aliases => prefixed by Elixir. and stored as an atom
  # alias IO, as: io

  # boolean => both are atoms
  # true === :true
  # false === :false

  # null
  # nil === :nil

  # false and nil are falsy and everything else is truthy

  # tuples => untyped structs used to group fixed number of types together
  # tuples are fixed size
  # oth index
  anime = {"dbz", "1999"}
  # dbz
  _name = elem(anime, 0)
  _anime2 = put_elem(anime, 0, "Shippuden")

  # lists => dynamic size => singly linked list
  nums = [1, 2, 3]
  IO.inspect(Enum.at(nums, 0))
  IO.inspect(3 in nums)
  IO.inspect(List.replace_at(nums, 0, -1))
  IO.inspect([1, 2] ++ [3, 4])
  [head | tails] = [1, 2, 3]
  # 1
  IO.inspect(head)
  # rest
  IO.inspect(tails)
  # constant time
  # returns head of the list
  IO.inspect(hd(nums))
  # returns tail of the list
  IO.inspect(tl(nums))

  # maps or hashmaps => key value pairs
  sqrs = %{1 => 1, 2 => 4, 3 => 9}
  # 9
  IO.inspect(sqrs[3])
  # if key does not exist we get nil

  # maps with atoms
  # name and year are atoms
  anime = %{name: "dbz", year: 1999}
  IO.inspect(anime.name)
  IO.inspect(anime[:name])

  # spread
  new_anime = %{anime | year: 2013}
  # %{name: "dbz", year: 2013}
  IO.inspect(new_anime)

  # binaries and bit strings
  # 0 => max was 255
  IO.inspect(<<256>>)
  # change size of bit string
  <<256::16>>
  # concat bit strings
  <<1, 2>> <> <<3, 4>>

  # strings => underneath represented as binary consecutive bytes
  str = "hello"

  # sigils => but no string interpolation here
  _str = ~s('yo')
  # 'yo'
  IO.inspect(str)
  concat = "hello " <> "worlds"
  IO.inspect(concat)

  # list of ints where each element represents a single character
  # [65, 66, 67]
  _character_list = 'ABC'

  ~c(Character sigil)
end
