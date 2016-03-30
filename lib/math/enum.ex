defmodule Math.Enum do
  @moduledoc """
  Math functions that work on any Enumerable objects, such as lists, streams, maps, sets, etc.


  """

  @doc """
  Calculates the product, obtained by multiplying all elements in *collection* with eachother.
  """
  def product(collection)

  # General implementation for any enumerable.
  def product(collection) do
    Enum.reduce(collection, &(&1*&2))
  end


end