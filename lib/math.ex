defmodule Math do
  @moduledoc """
  Mathematical functions and constants.
  """

  # Arbitrary precision for "nearish". 1e-15
  @epsilon 0.000000000000001
  # Taken from Java's Float.MAX_VALUE
  @max_value 3.4028234663852886e38

  @type x :: number
  @type y :: number

  @doc """
  The mathematical constant PI.
  """
  @spec pi :: float
  defdelegate pi, to: :math

  @doc """
  The mathematical constant TAU.
  """
  @spec tau :: float
  def tau, do: pi * 2

  @doc """
  The mathematical constant E (e).
  """
  @spec e :: float
  def e, do: 2.718281828459045

  @doc """
  Equality-ish test for whether x and y are nearly equal.
  """
  @spec number <~> number :: boolean
  def x <~> y do
    absX = abs(x)
    absY = abs(y)
    diff = abs(x - y)

    # Hacky comparison for floats that are nearly equal.
    cond do
      x == y ->
        true
      x == 0 or y == 0 ->
        diff < @epsilon
      true ->
        diff / min((absX + absY), @max_value) < @epsilon
    end
  end

  @doc """
  Computes the sine of x.
  """
  @spec sin(x) :: float
  defdelegate sin(x), to: :math

  @doc """
  Computes the cosine of x.
  """
  @spec cos(x) :: float
  defdelegate cos(x), to: :math

  @doc """
  Computes the tangent of x (expressed in radians).
  """
  @spec tan(x) :: float
  defdelegate tan(x), to: :math

  @doc """
  Computes the arc sine of x.
  """
  @spec asin(x) :: float
  defdelegate asin(x), to: :math

  @doc """
  Computes the arc cosine of x.
  """
  @spec acos(x) :: float
  defdelegate acos(x), to: :math

  @doc """
  Computes the arc tangent of x.
  """
  @spec atan(x) :: float
  defdelegate atan(x), to: :math

  @doc """
  Computes the arc tangent given y and x.
  """
  @spec atan2(y, x) :: float
  defdelegate atan2(y, x), to: :math

  @doc """
  Computes the hyperbolic sine of x (expressed in radians).
  """
  @spec sinh(x) :: float
  defdelegate sinh(x), to: :math

  @doc """
  Computes the hyperbolic cosine of x (expressed in radians).
  """
  @spec cosh(x) :: float
  defdelegate cosh(x), to: :math

  @doc """
  Computes the hyperbolic tangent of x (expressed in radians).
  """
  @spec tanh(x) :: float
  defdelegate tanh(x), to: :math

  @doc """
  Computes the inverse hyperbolic sine of x.
  """
  @spec asinh(x) :: float
  defdelegate asinh(x), to: :math

  @doc """
  Computes the inverse hyperbolic cosine of x.
  """
  @spec acosh(x) :: float
  defdelegate acosh(x), to: :math

  @doc """
  Computes the inverse hyperbolic tangent of x.
  """
  @spec atanh(x) :: float
  defdelegate atanh(x), to: :math

  @doc """
  Returns e to the xth power.
  """
  @spec exp(x) :: float
  defdelegate exp(x), to: :math

  @doc """
  Returns the natural logarithm (base e) of x.
  """
  @spec log(x) :: float
  defdelegate log(x), to: :math

  @doc """
  Returns the logarithm (base 2) of x.
  """
  @spec log2(x) :: float
  defdelegate log2(x), to: :math

  @doc """
  Computes the logarithm (base 10) of x.
  """
  @spec log10(x) :: float
  defdelegate log10(x), to: :math

  @doc """
  Returns x to the yth power.
  """
  @spec pow(x, y) :: float
  defdelegate pow(x, y), to: :math

  @doc """
  Returns the non-negative square root of x.
  """
  @spec sqrt(x) :: float
  defdelegate sqrt(x), to: :math

end
