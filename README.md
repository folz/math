# Math

[![Build Status](https://travis-ci.org/folz/math.svg?branch=master)](https://travis-ci.org/folz/math)
[![Module Version](https://img.shields.io/hexpm/v/math.svg)](https://hex.pm/packages/math)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/math/)
[![Total Download](https://img.shields.io/hexpm/dt/math.svg)](https://hex.pm/packages/math)
[![License](https://img.shields.io/hexpm/l/math.svg)](https://github.com/folz/math/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/folz/math.svg)](https://github.com/folz/math/commits/master)

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

- Interpolation
  - `Math.linear_interpolation(t,p0,p1)` Returns {x,y} of t in a linear interpolation
  - `Math.bezier_curve(t,[p0,p1 ...])` Returns {x,y} of t in a bezier_curve

- Working with Collections
  - `Math.Enum.product(collection)` The result of multiplying all elements in the passed collection.
  - `Math.Enum.mean(collection)` the mean of the numbers in the collection.
  - `Math.Enum.median(collection)` the median of the numbers in the collection.
  - `Math.Enum.mode(collection)` the mode of the numbers in the collection.
  - `Math.Enum.variance(collection)` variance of the numbers in the collection.
  - `Math.Enum.stdev(collection)` the standard deviation of the numbers in the collection.

## Installation

Math is [available in Hex](https://hex.pm/packages/math). The package can be installed by:

1. Add `:math` to your list of dependencies in `mix.exs`:

   ```elixir
   def deps do
     [
       {:math, "~> 0.6.0"}
     ]
   end
   ```

2. Require or import the Math library anywhere in your code you'd like:

   ```elixir
   require Math

   # or

   import Math
   ```

(Importing allows usage of the `<~>` operator)

## Changelog

- 0.7.0 adds `Math.linear_interpolation/3` and `Math.bezier_curve/2`. Thank you, @pcarvsilva !
- 0.6.0 Adds `Math.Enum.variance/1` and `Math.Enum.stdev/1`. Thank you, @TenTakano !
- 0.5.0 Adds `Math.mod_inv`, `Math.mod_inv!` and `Math.egcd`
- 0.4.0 Adds `Math.Enum.mode/1`.
- 0.3.1 Updates formatting to hide warnings in newer versions of Elixir.
- 0.3.0 Fixed incorrect median for lists with even number of items. Updated tests.
- 0.2.0 Added `factorial/1`, `nth_sqrt/2`, `k_permutations/2`, `k_combinations/2`, `gcd/2`, `lcm/2` and `Math.Enum` functions. Improved documentation.
- 0.1.0 Added integer variant of `pow/1`, `isqrt/2`, `deg2rad/1`, `rad2deg/1`. Improved documentation.
- 0.0.1 First implementation, mostly a wrapper around Erlang's `:math` library.

## Copyright and License

Copyright (c) 2016 Rodney Folz <rodney@rodneyfolz.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [https://www.apache.org/licenses/LICENSE-2.0](https://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
