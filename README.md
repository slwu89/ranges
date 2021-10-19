# ranges

<!-- badges: start -->
[![R-CMD-check](https://github.com/slwu89/ranges/workflows/R-CMD-check/badge.svg)](https://github.com/slwu89/ranges/actions)
[![Codecov test coverage](https://codecov.io/gh/slwu89/ranges/branch/main/graph/badge.svg)](https://codecov.io/gh/slwu89/ranges?branch=main)
<!-- badges: end -->

Gives users tools to make integer ranges for benchmarking algorithms, especially for numerical or 
scientific computing, that need to be tested on arguments ranging over several
orders of magnitude. It can generate dense (linear) or sparse (exponential) ranges
and is designed to be used to generate input for benchmarking packages like:

  * [bench](https://bench.r-lib.org/)
  * [microbenchmark](https://cran.r-project.org/package=microbenchmark)
  * [rbenchmark](https://cran.r-project.org/package=rbenchmark)

Currently the available ranges are designed to replicate the range behavior from
the [Google Benchmark C++ library](https://github.com/google/benchmark).

The main function to interact with now is `create_range_exp`, which reproduces
the `Range` behavior of benchmark ([see here](https://github.com/google/benchmark/blob/main/docs/user_guide.md#passing-arguments)).

`BENCHMARK(BM_memcpy)->RangeMultiplier(2)->Range(8, 8<<10);` can be specified with
"ranges" by:

```
> ranges::create_range_exp(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = 2)
 [1]    8   16   32   64  128  256  512 1024 2048 4096 8192
```
