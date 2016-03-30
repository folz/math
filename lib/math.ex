defmodule Math do
  @moduledoc """
  Mathematical functions and constants.
  """

  # For practical uses floats can be considered equal if their difference is less than this value. See <~>.
  @epsilon 1.0e-15
  
  # Theoretical limit is 1.80e308, but Erlang errors at that value, so the practical limit is slightly below that one.
  @max_value 1.79769313486231580793e308

  @type x :: number
  @type y :: number


  @doc """
  The mathematical constant *π* (pi).

  The ratio of a circle's circumference to its diameter.
  The returned number is a floating-point approximation (as π is irrational)
  """
  @spec pi :: float
  defdelegate pi, to: :math

  @rad_in_deg (180/:math.pi)


  @doc """
  The mathematical constant *τ* (tau).

  The ratio of a circle's circumference to its radius.
  Defined as 2 * π, but preferred by some mathematicians.
  The returned number is a floating-point approximation (as τ is irrational)
  """
  @spec tau :: float
  def tau, do: pi * 2

  @doc """
  The mathematical constant *ℯ* (e).


  """
  @spec e :: float
  def e, do: 2.718281828459045

  @doc """
  Equality-test for whether *x* and *y* are _nearly_ equal.

  This is useful when working with floating-point numbers, as these introduce small rounding errors.

  ## Examples

      iex> 2.3 - 0.3 == 2.0
      false
      iex> 2.3 - 0.3 <~> 2.0
      true 
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

  # General

  @doc """
  Arithmetic exponentiation. Returns *x* to the *n* -th power.

  When both *x* and *n* are integers and *n* is positive, returns an `integer`.
  When *n* is a negative integer, returns a `float`.
  When working with integers, the Exponentiation by Squaring algorithm is used, to allow for a fast and precise result.

  When one of the numbers is a float, returns a `float` by using erlang's `:math.pow/2` function.

  It is possible to calculate roots by choosing *n* between  0.0 and 1.0 (To calculate the *p* -th-root, pass 1/*p* to the function)  

  ## Examples

      iex> Math.pow(2, 4)
      16
      iex> Math.pow(2.0, 4)
      16.0
      iex> Math.pow(2, 4.0)
      16.0
      iex> Math.pow(5, 100)
      7888609052210118054117285652827862296732064351090230047702789306640625
      iex> Math.pow(5.0, 100)
      7.888609052210118e69
      iex> Math.pow(2, (1 / 2))
      1.4142135623730951
  """
  @spec pow(number, number) :: number
  def pow(x, n)

  def pow(x, n) when is_integer(x) and is_integer(n), do: _pow(x, n)

  # Float implementation. Uses erlang's math library.
  def pow(x, n) do
    :math.pow(x, n)
  end

  # Integer implementation. Uses Exponentiation by Squaring. 
  defp _pow(x, n, y \\ 1)
  defp _pow(_x, 0, y), do: y
  defp _pow(x, 1, y), do: x * y
  defp _pow(x, n, y) when (n < 0), do: _pow(1 / x, -n, y)
  defp _pow(x, n, y) when rem(n, 2) == 0, do: _pow(x * x, div(n, 2), y)
  defp _pow(x, n, y), do: _pow(x * x, div((n - 1), 2), x * y)

  @doc """
  Returns the non-negative square root of *x*.
  """
  @spec sqrt(x) :: float
  defdelegate sqrt(x), to: :math

  @doc """
  Returns the non-negative nth-root of *x*.

  ## Examples

      iex> Math.nth_root(27, 3)
      3.0
      iex> Math.nth_root(65536, 8)
      4.0
  """
  @spec nth_root(x, number) :: float
  def nth_root(x, n)
  def nth_root(x, n), do: pow(x, 1 / n)

  @doc """
  Returns the non-negative integer square root of *x* (rounded towards zero)

  Does not accept negative numbers as input.

  ## Examples

      iex> Math.isqrt(100)
      10
      iex> Math.isqrt(16)
      4
      iex> Math.isqrt(65536)
      256
      iex> Math.isqrt(10)
      3
  """
  def isqrt(x)

  def isqrt(x) when x < 0, do: raise ArithmeticError

  def isqrt(x), do: _isqrt(x, 1, div((1 + x), 2))
    
  defp _isqrt(x, m, n) when abs(m - n) <= 1 and n * n <= x, do: n
  defp _isqrt(_x, m, n) when abs(m - n) <= 1, do: n - 1

  defp _isqrt(x, _, n) do
    _isqrt(x, n, div(n + div(x, n), 2))
  end


  # 
  @doc """
  Calculates the Greatest Common divisor of two numbers.

  This is the largest positive integer that divides both *a* and *b* without leaving a remainder.

  ## Examples

      iex> Math.gcd(2, 4)
      2
      iex> Math.gcd(2, 3)
      1
      iex> Math.gcd(12, 8)
      4
      iex> Math.gcd(54, 24)
      6
  """  
  def gcd(a, 0), do: abs(a)
  
  def gcd(0, b), do: abs(b)
  def gcd(a, b), do: gcd(b, rem(a,b))

  @doc """
  Calculates the Least Common Multiple of two numbers.

  This is the smallest positive integer that can be divided by both *a* by *b* without leaving a remainder.

  ## Examples

      iex> Math.lcm(4, 6)
      12
      iex> Math.lcm(3, 7)
      21
      iex> Math.lcm(21, 6)
      42
  """
  def lcm(a, b)

  def lcm(0, 0), do: 0
  def lcm(a, b) do
    Kernel.div(a * b, gcd(a, b))
  end

  @doc """
  Returns ℯ to the xth power.
  """
  @spec exp(x) :: float
  defdelegate exp(x), to: :math

  @doc """
  Returns the natural logarithm (base `ℯ`) of *x*.

  See also `Math.e/0`.
  """
  @spec log(x) :: float
  defdelegate log(x), to: :math

  @doc """
  Returns the base-*b* logarithm of *x*

  Note that variants for the most common logarithms exist that are faster and more precise.

  See also `Math.log/1`, `Math.log2/1` and `Math.log10/1`.

  ## Examples

      iex> Math.log(5, 5)
      1.0
      iex> Math.log(20, 2) <~> Math.log2(20) 
      true
      iex> Math.log(20, 10) <~> Math.log10(20)
      true
      iex> Math.log(2, 4)
      0.5
      iex> Math.log(10, 4)
      1.6609640474436813
  """
  @spec log(x, number) :: float
  def log(x, x), do: 1.0
  def log(x, b) do
    :math.log(x) / :math.log(b)
  end

  @doc """
  Returns the binary logarithm (base `2`) of *x*.

  See also `Math.log/2`.
  """
  @spec log2(x) :: float
  defdelegate log2(x), to: :math

  @doc """
  Computes the common logarithm (base `10`) of *x*.

  See also `Math.log/2`.
  """
  @spec log10(x) :: float
  defdelegate log10(x), to: :math


  # Trigonometry

  @doc """
  Converts degrees to radians

  ## Examples

      iex>Math.deg2rad(180)
      3.141592653589793
      
  """
  @spec deg2rad(x) :: float
  def deg2rad(x) do
    x / @rad_in_deg
  end

  @doc """
  Converts radians to degrees
  
  ## Examples

      iex>Math.rad2deg(Math.pi)
      180.0
  """
  @spec rad2deg(x) :: float
  def rad2deg(x) do
    x * @rad_in_deg
  end

  @doc """
  Computes the sine of *x*.

  *x* is interpreted as a value in radians.
  """
  @spec sin(x) :: float
  defdelegate sin(x), to: :math

  @doc """
  Computes the cosine of *x*.

  *x* is interpreted as a value in radians.
  """
  @spec cos(x) :: float
  defdelegate cos(x), to: :math

  @doc """
  Computes the tangent of *x* (expressed in radians).
  """
  @spec tan(x) :: float
  defdelegate tan(x), to: :math

  @doc """
  Computes the arc sine of *x*. (expressed in radians)
  """
  @spec asin(x) :: float
  defdelegate asin(x), to: :math

  @doc """
  Computes the arc cosine of *x*. (expressed in radians)
  """
  @spec acos(x) :: float
  defdelegate acos(x), to: :math

  @doc """
  Computes the arc tangent of *x*. (expressed in radians)
  """
  @spec atan(x) :: float
  defdelegate atan(x), to: :math

  @doc """
  Computes the arc tangent given *y* and *x*. (expressed in radians)
  """
  @spec atan2(y, x) :: float
  defdelegate atan2(y, x), to: :math

  # Advanced Trigonometry

  @doc """
  Computes the hyperbolic sine of *x* (expressed in radians).
  """
  @spec sinh(x) :: float
  defdelegate sinh(x), to: :math

  @doc """
  Computes the hyperbolic cosine of *x* (expressed in radians).
  """
  @spec cosh(x) :: float
  defdelegate cosh(x), to: :math

  @doc """
  Computes the hyperbolic tangent of *x* (expressed in radians).
  """
  @spec tanh(x) :: float
  defdelegate tanh(x), to: :math

  @doc """
  Computes the inverse hyperbolic sine of *x*.
  """
  @spec asinh(x) :: float
  defdelegate asinh(x), to: :math

  @doc """
  Computes the inverse hyperbolic cosine of *x*.
  """
  @spec acosh(x) :: float
  defdelegate acosh(x), to: :math

  @doc """
  Computes the inverse hyperbolic tangent of *x*.
  """
  @spec atanh(x) :: float
  defdelegate atanh(x), to: :math

end
