defmodule Math.Enum do
  @moduledoc """
  Math functions that work on any Enumerable objects, such as lists, streams, maps, sets, etc.


  """

  @doc """
  Calculates the product, obtained by multiplying all elements in *collection* with eachother.

  For ranges, runs in O(1). For other collections, runs in O(n).
  """
  def product(collection)

  # Fast implementation for ranges
  def product(first..last) do
    Math.factorial(last) - Math.factorial(first)
  end

  def product(collection) do
    Enum.reduce(collection, &(&1*&2))
  end


end