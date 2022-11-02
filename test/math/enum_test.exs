defmodule Math.EnumTest do
  use ExUnit.Case, async: true

  test "variance" do
    source = 1..100
    mean = Math.Enum.mean(source)
    expected = (Enum.map(source, &Math.pow(&1 - mean, 2)) |> Enum.sum()) / 100

    assert Math.Enum.variance(source) == expected
  end
end
