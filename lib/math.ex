defmodule Math do
  @vsn "0.2.0"

  @moduledoc """
  Mathematical functions and constants.
  """

  # For practical uses floats can be considered equal if their difference is less than this value. See <~>.
  @epsilon 1.0e-15

  # Theoretical limit is 1.80e308, but Erlang errors at that value, so the practical limit is slightly below that one.
  @max_value 1.79_769_313_486_231_580_793e308

  @type x :: number
  @type y :: number

  @doc """
  The mathematical constant *π* (pi).

  The ratio of a circle's circumference to its diameter.
  The returned number is a floating-point approximation (as π is irrational)
  """
  @spec pi :: float
  defdelegate pi, to: :math

  @rad_in_deg 180 / :math.pi()

  @doc """
  The mathematical constant *τ* (tau).

  The ratio of a circle's circumference to its radius.
  Defined as 2 * π, but preferred by some mathematicians.
  The returned number is a floating-point approximation (as τ is irrational)
  """
  @spec tau :: float
  def tau, do: pi() * 2

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
    abs_x = abs(x)
    abs_y = abs(y)
    diff = abs(x - y)

    # Hacky comparison for floats that are nearly equal.
    cond do
      x == y ->
        true

      x == 0 or y == 0 ->
        diff < @epsilon

      true ->
        diff / min(abs_x + abs_y, @max_value) < @epsilon
    end
  end

  # General

  @doc """
  Arithmetic exponentiation. Calculates *x* to the *n* -th power.

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
  defp _pow(x, n, y) when n < 0, do: _pow(1 / x, -n, y)
  defp _pow(x, n, y) when rem(n, 2) == 0, do: _pow(x * x, div(n, 2), y)
  defp _pow(x, n, y), do: _pow(x * x, div(n - 1, 2), x * y)

  @doc """
  Calculates the non-negative square root of *x*.
  """
  @spec sqrt(x) :: float
  defdelegate sqrt(x), to: :math

  @doc """
  Calculates the non-negative nth-root of *x*.

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
  Calculates the non-negative integer square root of *x* (rounded towards zero)

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
  @spec isqrt(integer) :: integer
  def isqrt(x)

  def isqrt(x) when x < 0, do: raise(ArithmeticError)

  def isqrt(x), do: _isqrt(x, 1, div(1 + x, 2))

  defp _isqrt(x, m, n) when abs(m - n) <= 1 and n * n <= x, do: n
  defp _isqrt(_x, m, n) when abs(m - n) <= 1, do: n - 1

  defp _isqrt(x, _, n) do
    _isqrt(x, n, div(n + div(x, n), 2))
  end

  #
  @doc """
  Calculates the Greatest Common divisor of two numbers.

  This is the largest positive integer that divides both *a* and *b* without leaving a remainder.

  Also see `Math.lcm/2`

  ## Examples

      iex> Math.gcd(2, 4)
      2
      iex> Math.gcd(2, 3)
      1
      iex> Math.gcd(12, 8)
      4
      iex> Math.gcd(54, 24)
      6
      iex> Math.gcd(-54, 24)
      6
  """
  @spec gcd(integer, integer) :: non_neg_integer

  def gcd(a, b) when is_integer(a) and is_integer(b), do: egcd(a, b) |> elem(0)

  @doc """
  Calculates integers  `gcd`, `s`, and `t` for `as + bt = gcd(a, b)`

  Also see `Math.gcd/2`.

  Returns a tuple: `{gcd, s, t}`

  ## Examples

      iex> Math.egcd(2, 4)
      {2, 1, 0}
      iex> Math.egcd(2, 3)
      {1, -1, 1}
      iex> Math.egcd(12, 8)
      {4, 1, -1}
      iex> Math.egcd(54, 24)
      {6, 1, -2}
      iex> Math.egcd(-54, 24)
      {6, 1, -2}
  """
  @spec egcd(integer, integer) :: non_neg_integer
  def egcd(a, b) when is_integer(a) and is_integer(b), do: _egcd(abs(a), abs(b), 0, 1, 1, 0)

  defp _egcd(0, b, s, t, _u, _v), do: {b, s, t}

  defp _egcd(a, b, s, t, u, v) do
    q = div(b, a)
    r = rem(b, a)

    m = s - u * q
    n = t - v * q

    _egcd(r, a, u, v, m, n)
  end

  @doc """
  Calculates the Least Common Multiple of two numbers.

  This is the smallest positive integer that can be divided by both *a* by *b* without leaving a remainder.

  Also see `Math.gcd/2`

  ## Examples

      iex> Math.lcm(4, 6)
      12
      iex> Math.lcm(3, 7)
      21
      iex> Math.lcm(21, 6)
      42
  """
  @spec lcm(integer, integer) :: non_neg_integer
  def lcm(a, b)

  def lcm(0, 0), do: 0

  def lcm(a, b) do
    abs(Kernel.div(a * b, gcd(a, b)))
  end

  @precompute_factorials_up_to 1000
  @doc """
  Calculates the factorial of *n*: 1 * 2 * 3 * ... * *n*

  To make this function faster, values of *n* up to `#{@precompute_factorials_up_to}` are precomputed at compile time.

  ## Examples

      iex> Math.factorial(1)
      1
      iex> Math.factorial(5)
      120
      iex> Math.factorial(20)
      2432902008176640000
  """
  @spec factorial(non_neg_integer) :: pos_integer
  def factorial(n)

  def factorial(0), do: 1

  for {n, fact} <-
        1..@precompute_factorials_up_to
        |> Enum.scan({0, 1}, fn n, {_prev_n, prev_fact} -> {n, n * prev_fact} end) do
    def factorial(unquote(n)), do: unquote(fact)
  end

  def factorial(n) when n >= 0 do
    n * factorial(n - 1)
  end

  @doc """
  Calculates the k-permutations of *n*.

  This is the number of distinct ways to create groups of size *k* from *n* distinct elements.

  Notice that *n* is the first parameter, for easier piping.

  ## Examples

      iex> Math.k_permutations(10, 2)
      90
      iex> Math.k_permutations(5, 5)
      120
      iex> Math.k_permutations(3, 4)
      0

  """
  @spec k_permutations(non_neg_integer, non_neg_integer) :: non_neg_integer
  def k_permutations(n, k)

  def k_permutations(n, k) when k > n, do: 0

  def k_permutations(n, k) do
    div(factorial(n), factorial(n - k))
  end

  @doc """
  Calculates the k-combinations of *n*.

  ## Examples
      iex> Math.k_combinations(10, 2)
      45
      iex> Math.k_combinations(5, 5)
      1
      iex> Math.k_combinations(3, 4)
      0
  """
  @spec k_combinations(non_neg_integer, non_neg_integer) :: non_neg_integer
  def k_combinations(n, k)

  def k_combinations(n, k) when k > n, do: 0

  def k_combinations(n, k) do
    div(factorial(n), factorial(k) * factorial(n - k))
  end

  # Logarithms and exponentiation

  @doc """
  Calculates ℯ to the xth power.
  """
  @spec exp(x) :: float
  defdelegate exp(x), to: :math

  @doc """
  Calculates the natural logarithm (base `ℯ`) of *x*.

  See also `Math.e/0`.
  """
  @spec log(x) :: float
  defdelegate log(x), to: :math

  @doc """
  Calculates the base-*b* logarithm of *x*

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
  Calculates the binary logarithm (base `2`) of *x*.

  See also `Math.log/2`.
  """
  @spec log2(x) :: float
  defdelegate log2(x), to: :math

  @doc """
  Calculates the common logarithm (base `10`) of *x*.

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

  This variant returns the inverse tangent in the correct quadrant, as the signs of both *x* and *y* are known.
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

  @doc """
  Computes the modular multiplicatibe inverse of `a` under modulo `m`

  In other words, given integers `a` and `m` calculate a value `b` for `ab = 1 (mod m)`

  Returns an `{:ok, b}` tuple or `{:error, :not_coprime}` when `b` cannot be calculated for the inputs.

  ## Examples

      iex> Math.mod_inv 3, 11
      {:ok, 4}
      iex> Math.mod_inv 10, 17
      {:ok, 12}
      iex> Math.mod_inv 123, 455
      {:ok, 37}
      iex> Math.mod_inv 123, 456
      {:error, :not_coprime}

  """
  @spec mod_inv(a :: integer, m :: integer) :: {:ok, integer} | {:error, :not_coprime}
  def mod_inv(a, m)

  def mod_inv(a, m) when is_float(a) or is_float(m),
    do: raise(ArgumentError, "Inputs cannot be of type float")

  def mod_inv(a, m) when is_integer(a) and is_integer(m) do
    case egcd(a, m) do
      {1, s, _t} -> {:ok, rem(s + m, m)}
      _ -> {:error, :not_coprime}
    end
  end

  @doc """
  Computes the modular multiplicatibe inverse of `a` under modulo `m`

  Similar to `mod_in/2`, but returns only the value or raises an error.

  ## Examples

      iex> Math.mod_inv! 3, 11
      4
      iex> Math.mod_inv! 10, 17
      12
      iex> Math.mod_inv! 123, 455
      37
      iex> Math.mod_inv! 123, 456
      ** (ArithmeticError) Inputs are not coprime!

  """
  @spec mod_inv!(a :: integer, m :: integer) :: integer
  def mod_inv!(a, m)

  def mod_inv!(a, m) do
    case mod_inv(a, m) do
      {:ok, b} -> b
      _ -> raise ArithmeticError, "Inputs are not coprime!"
    end
  end
end
