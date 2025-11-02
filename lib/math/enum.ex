defmodule Math.Enum do
  @moduledoc """
  Math.Enum defines Math-functions that work on any collection extending the Enumerable protocol.
  This means Maps, Lists, Sets, etc., and any custom collection types as well.
  """
  require Integer

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
    Enum.reduce(collection, &*/2)
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
    collection
    |> Enum.reduce({nil, 0}, fn
      elem, {nil, 0} -> {elem * 1.0, 1}
      elem, {mean, count} -> {(mean * count + elem) / (count + 1), count + 1}
    end)
    |> elem(0)
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
    mid_point = div(count, 2)

    cond do
      count == 0 ->
        nil

      # Middle element exists
      Integer.is_odd(count) ->
        collection
        |> Enum.sort()
        |> Enum.fetch!(mid_point)

      true ->
        collection
        |> Enum.sort()
        |> Enum.slice((mid_point - 1)..mid_point)
        |> Math.Enum.mean()
    end
  end

  @doc """
  Calculates the mode of a given collection of numbers.

  Always returns a list. An empty input results in an empty list. Supports bimodal/multimodal collections by returning a list with multiple values.

  ## Examples

      iex> Math.Enum.mode [1, 2, 3, 4, 1]
      [1]
      iex> Math.Enum.mode [1, 2, 3, 2, 3]
      [2, 3]
      iex> Math.Enum.mode []
      []
  """
  @spec mode(Enum.t()) :: Enum.t()
  def mode(collection)

  def mode(collection) do
    collection
    |> Enum.reduce(%{}, fn k, acc -> Map.update(acc, k, 0, &(&1 + 1)) end)
    |> Enum.group_by(&elem(&1, 1), &elem(&1, 0))
    |> Enum.max_by(&elem(&1, 0), fn -> {nil, []} end)
    |> elem(1)
  end

  @doc """
  Calculates the variance of a given collection of numbers.

  If the collection is empty, returns `nil`

  ## Examples
      iex> Math.Enum.variance [1, 2, 3, 4, 5]
      2.0
      iex> Math.Enum.variance 1..10
      8.25
      iex> Math.Enum.variance [1, 2, 3, 4, 5, -100]
      1475.138888888889
      iex> Math.Enum.variance []
      nil
  """

  @spec variance(Enum.t()) :: number | nil
  def variance(collection)

  def variance(collection) do
    count = Enum.count(collection)

    case count do
      0 -> nil
      _ ->
        mean_square = (Enum.map(collection, &Math.pow(&1, 2)) |> Enum.sum()) / count
        squared_mean = mean(collection) |> Math.pow(2)
        mean_square - squared_mean
    end
  end

  @doc """
  Calculates the standard deviation of a given collection of numbers.

  If the collection is empty, returns `nil`

  ## Examples
      iex> Math.Enum.stdev([1,2,3,4,5])
      1.4142135623730951
      iex> Math.Enum.stdev 1..10
      2.8722813232690143
      iex> Math.Enum.stdev [1,2,3,4,5,-100] 
      38.407536876098796
      iex> Math.Enum.stdev []              
      nil
  """

  @spec stdev(Enum.t()) :: number | nil
  def stdev(collection)

  def stdev(collection) do
    case variance(collection) do
      nil -> nil
      res -> Math.sqrt(res)
    end
  end
end
