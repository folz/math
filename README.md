# Math

[![hex.pm version](https://img.shields.io/hexpm/v/math.svg)](https://hex.pm/packages/math)
[![Build Status](https://travis-ci.org/folz/math.svg?branch=master)](https://travis-ci.org/folz/math)

The Math module adds many useful functions that extend Elixir's standard library.

- General Functions
  - `a <~> b` Comparison of floats, to check if they are effectively equal (if their absolute difference is less than `@epsilon`).
  - `Math.pow(x, n)` Arithmetic exponentiation. Works both with integer powers and floats.
  - `Math.sqrt(x)` The square root of *x*.
  - `Math.nth_root(x, n)` The n-th root of *x*.
  - `Math.isqrt(x)`  The integer square root of *x*.
  - `Math.gcd(a, b)` The greatest common divisor of *a* and *b*.
  - `Math.egcd(a, b)` Calculates integers *gcd*, *s*, and *t* in `as + bt = gcd(a,b)`. See also `Math.gcd(a, b)`
  - `Math.lcm(a, b)` The least common multiple of *a* and *b*.
  - `Math.factorial(n)` The *n*-th factorial number.
  - `Math.k_permutations(n, k)` The number of distinct ways to create groups of size *k* from *n* distinct elements.
  - `Math.k_combinations(n, k)` The number of distinct ways to create groups of size *k* from *n* distinct elements where order does not matter.
  - `Math.mod_inv(a, m)` An integer *b* that fufills `ab = 1 (mod m)`. Returns an ok/error tuple.
  - `Math.mod_inv!(a, m)` See `Math.mod_inv(a, m)`, but returns the value or raises an error.


- Logarithms
  - `Math.exp(x)` Calculates ℯ to the xth power.
  - `Math.log(x)` Calculates the natural logarithm (base `ℯ`) of *x*.
  - `Math.log(x, b)` Calculates the base-*b* logarithm of *x*
  - `Math.log2(x)` Calculates the binary logarithm (base `2`) of *x*.
  - `Math.log10(x)` Calculates the common logarithm (base `10`) of *x*.
  - `Math.e` Returns a floating-point approximation of the number ℯ.

- Trigonometry
  - `Math.pi` Returns a floating-point approximation of the number *π*.
  - `Math.deg2rad(x)` converts from degrees to radians.
  - `Math.rad2deg(x)` converts from radians to degrees.
  - `Math.sin(x)` The sine of *x*.
  - `Math.cos(x)` The cosine of *x*.
  - `Math.tan(x)` The tangent of *x*.
  - `Math.asin(x)` The inverse sine of *x*.
  - `Math.acos(x)` The inverse cosine of *x*.
  - `Math.atan(x)` The inverse tangent of *x*.
  - `Math.atan2(x, y)` The inverse tangent of *x* and *y*. This variant returns the inverse tangent in the correct quadrant, as the signs of both *x* and *y* are known.
  - `Math.sinh(x)` The hyperbolic sine of *x*.
  - `Math.cosh(x)` The hyperbolic cosine of *x*.
  - `Math.tanh(x)` The hyperbolic tangent of *x*.
  - `Math.asinh(x)` The inverse hyperbolic sine of *x*.
  - `Math.acosh(x)` The inverse hyperbolic cosine of *x*.
  - `Math.atanh(x)` The inverse hyperbolic tangent of *x*.

- Working with Collections
  - `Math.Enum.product(collection)` The result of multiplying all elements in the passed collection.
  - `Math.Enum.mean(collection)` the mean of the numbers in the collection.
  - `Math.Enum.median(collection)` the median of the numbers in the collection.
  - `Math.Enum.mode(collection)` the mode of the numbers in the collection.

## Installation

Math is [available in Hex](https://hex.pm/packages/math). The package can be installed by:

1. Add `math` to your list of dependencies in `mix.exs`:

```ex
def deps do
  [
    {:math, "~> 0.4.0"}
  ]
end
```

2. Require or import the Math library anywhere in your code you'd like:

```ex
require Math

# or

import Math
```

(Importing allows usage of the `<~>` operator)

## Changelog
- 0.5.0 Adds `Math.mod_inv`, `Math.mod_inv!` and `Math.egcd`
- 0.4.0 Adds `Math.Enum.mode/1`.
- 0.3.1 Updates formatting to hide warnings in newer versions of Elixir.
- 0.3.0 Fixed incorrect median for lists with even number of items. Updated tests.
- 0.2.0 Added `factorial/1`, `nth_sqrt/2`, `k_permutations/2`, `k_combinations/2`, `gcd/2`, `lcm/2` and `Math.Enum` functions. Improved documentation.
- 0.1.0 Added integer variant of `pow/1`, `isqrt/2`, `deg2rad/1`, `rad2deg/1`. Improved documentation.
- 0.0.1 First implementation, mostly a wrapper around Erlang's `:math` library.
