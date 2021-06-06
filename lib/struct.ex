defmodule Fraction do
  defstruct x: nil, y: nil

  def new_fraction(x, y) do
    %Fraction{x: x, y: y}
  end

  def value(%Fraction{x: x, y: y}) do
    div(x, y)
  end

  # same as above but will run slower (noticable only when you have large structs)
  def value(fract) do
    div(fract.x, fract.y)
  end

  # structs are map at runtime
  # enum can nnt be called in structs
  # map functions can be used
  # maps can be pattern matched to structs but not vice versa
end
