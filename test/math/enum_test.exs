defmodule Math.EnumTest do
  use ExUnit.Case, async: true

  test "variance" do
    source = 1..100
    mean = Math.Enum.mean(source)
    expected = (Enum.map(source, &Math.pow(&1 - mean, 2)) |> Enum.sum()) / 100

    assert Math.Enum.variance(source) == expected
  end

  test "histogram" do

    result =
      1..11
      |> Math.Enum.histogram()

    expected =
      1..11
      |> Enum.map(
        fn n ->
          first = n
          second = min(n + 1)

          {{first, second}, 1}
        end
      )


    assert result == expected


    result =
      1..10
      |> Math.Enum.histogram(9)

    expected =
      1..10
      |> Enum.map(
        fn n ->
          first = n
          second = min(n + 1)

          {{first, second}, 1}
        end
      )


    assert result == expected

  end

  test "histogram_by" do

    result =
      0..11
      |> Enum.map(fn number -> %{element: number} end)
      |> Math.Enum.histogram_by(fn map -> map.element end)

    expected =
      0..11
      |> Enum.map(
        fn n ->
          first = n
          second = min(n + 1, 10)

          {{first, second}, 1}
        end
      )


    assert result == expected

    result =
      0..10
      |> Enum.map(fn number -> %{element: number} end)
      |> Math.Enum.histogram_by(fn map -> map.element end, 9)

    expected =
      0..10
      |> Enum.map(
        fn n ->
          first = n
          second = min(n + 1, 10)

          {{first, second}, 1}
        end
      )


    assert result == expected
  end

end
