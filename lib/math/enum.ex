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

    @doc """
  Calculates an histogram of a given collection of numbers.

  An optional parameter defines the number of buckets, default is to 10

  If the collection is empty, returns `nil`

  ## Examples
      iex> Math.Enum.histogram(1..11) |> Enum.at(0)
      {{1.0, 2.0}, 1}
      iex> Math.Enum.histogram([])
      nil
  """
  @spec stdev(Enum.t()) :: Enum.t() | nil
  def histogram([], buckets \\ 10 ) do
    nil
  end

  def histogram(collection, buckets) do
      collection
      |> Enum.min_max()
      |> build_histogram(collection, buckets)
  end

  @doc """
  Similar to `histogram/2`, but with a key function to map the data.

  """

  @spec stdev(Enum.t()) :: Enum.t() | nil
  def histogram_by([], key_fun) do
    nil
  end

  def histogram_by(collection, key_fun, buckets) do
    collection
    |> Enum.map(key_fun)
    |> histogram(buckets)
  end

  defp build_histogram({same_value, same_value}, collection, buckets) do
    {{same_value, same_value}, collection |> Enum.count()}
  end

  defp build_histogram({min, max}, collection, buckets) do
    interval_size = max - min

    bucket_size = interval_size / buckets

    collection
    |> Enum.frequencies_by(fn element -> trunc((element - min) / bucket_size) end)
    |> Enum.map(fn {key, frequency} ->
      bucket_min = (key * bucket_size) + min
      bucket_max = min(max, bucket_min + bucket_size)
      {{bucket_min, bucket_max}, frequency }
    end)

  end

end
