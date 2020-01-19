defmodule Math.Enum do
  @moduledoc """
  Math.Enum defines Math-functions that work on any collection extending the Enumerable protocol.
  This means Maps, Lists, Sets, etc., and any custom collection types as well.
  """

  @doc """
  Calculates the product, obtained by multiplying all elements in *collection* with eachother.

  ## Examples

      iex> Math.Enum.product [1,2,3]
      6
      iex> Math.Enum.product 1..10
      3628800
      iex> Math.Enum.product [1,2,3,4,5, -100]
      -12000
  """
  def product(collection)

  # General implementation for any enumerable.
  def product(collection) do
    Enum.reduce(collection, &(&1 * &2))
  end

  @doc """
  Calculates the mean of a collection of numbers.

  This is the sum, divided by the amount of elements in the collection.

  If the collection is empty, returns `nil`

  Also see `Math.Enum.median/1`

  ## Examples
      iex> Math.Enum.mean [1,2,3]
      2.0
      iex> Math.Enum.mean 1..10
      5.5
      iex> Math.Enum.mean [1,2,3,4,5, -100]
      -14.166666666666666
      iex> Math.Enum.mean []
      nil
  """
  @spec mean(Enum.t()) :: number
  def mean(collection)

  def mean(collection) do
    count = Enum.count(collection)

    case count do
      0 -> nil
      _ -> Enum.sum(collection) / count
    end
  end

  @doc """
  Calculates the median of a given collection of numbers.

  - If the collection has an odd number of elements, this will be the middle-most element of the (sorted) collection.
  - If the collection has an even number of elements, this will be mean of the middle-most two elements of the (sorted) collection.

  If the collection is empty, returns `nil`

  Also see `Math.Enum.mean/1`

  ## Examples

      iex> Math.Enum.median [1,2,3]
      2
      iex> Math.Enum.median 1..10
      5.5
      iex> Math.Enum.median [1,2,3,4,5, -100]
      2.5
      iex> Math.Enum.median [1,2]
      1.5
      iex> Math.Enum.median []
      nil
  """
  @spec median(Enum.t()) :: number | nil
  def median(collection)

  def median(collection) do
    count = Enum.count(collection)

    cond do
      count == 0 ->
        nil

      # Middle element exists
      rem(count, 2) == 1 ->
        Enum.sort(collection) |> Enum.at(div(count, 2))

      true ->
        # Take two middle-most elements.
        sorted_collection = Enum.sort(collection)

        [
          Enum.at(sorted_collection, div(count, 2)),
          Enum.at(sorted_collection, div(count, 2) - 1)
        ]
        |> Math.Enum.mean()
    end
  end
end
