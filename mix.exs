defmodule Math.Mixfile do
  use Mix.Project

  def project do
    [app: :math,
     version: "0.3.0",
     elixir: "~> 1.2",
     description: description(),
     package: package(),
     deps: deps(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    The Math module adds many useful functions that extend Elixir's standard library.

    - General Functions
      • a <~> b Comparison of floats, to check if they are _nearly_ equal.
      • Math.pow(x, n) Arithmetic exponentiation. Works both with integer powers and floats.
      • Math.sqrt(x) The square root of x.
      • Math.nth_root(x, n) The n-th root of x.
      • Math.isqrt(x)  The integer square root of x.
      • Math.gcd(a, b) The greatest common divisor of a and b.
      • Math.lcm(a, b) The least common multiple of a and b.
      • Math.factorial(n) The n-th factorial number.
      • Math.k_permutations(n, k) The number of distinct ways to create groups of size k from n distinct elements.
      • Math.k_combinations(n, k) The number of distinct ways to create groups of size k from n distinct elements where order does not matter.


    - Logarithms
      • Math.exp(x) Calculates ℯ to the xth power.
      • Math.log(x) Calculates the natural logarithm (base ℯ) of x.
      • Math.log(x, b) Calculates the base-b logarithm of x
      • Math.log2(x) Calculates the binary logarithm (base 2) of x.
      • Math.log10(x) Calculates the common logarithm (base 10) of x.
      • Math.e Returns a floating-point approximation of the number ℯ.

    - Trigonometry
      • Math.pi Returns a floating-point approximation of the number π.
      • Math.deg2rad(x) converts from degrees to radians.
      • Math.rad2deg(x) converts from radians to degrees.
      • Math.sin(x) The sine of x.
      • Math.cos(x) The cosine of x.
      • Math.tan(x) The tangent of x.
      • Math.asin(x) The inverse sine of x.
      • Math.acos(x) The inverse cosine of x.
      • Math.atan(x) The inverse tangent of x.
      • Math.atan2(x, y) The inverse tangent of x and y. This variant returns the inverse tangent in the correct quadrant, as the signs of both x and y are known.
      • Math.sinh(x) The hyperbolic sine of x.
      • Math.cosh(x) The hyperbolic cosine of x.
      • Math.tanh(x) The hyperbolic tangent of x.
      • Math.asinh(x) The inverse hyperbolic sine of x.
      • Math.acosh(x) The inverse hyperbolic cosine of x.
      • Math.atanh(x) The inverse hyperbolic tangent of x.

    - Working with Collections
      • Math.Enum.product(collection) The result of multiplying all elements in the passed collection.
      • Math.Enum.mean(collection) the mean of the numbers in the collection.
      • Math.Enum.median(collection) the median of the numbers in the collection.

    """
  end

  defp package do
    [
      maintainers: ["Rodney Folz"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub": "https://github.com/folz/math"}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, ">= 0.11.4", only: [:dev]}
    ]
  end
end
