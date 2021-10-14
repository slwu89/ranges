# ranges

<!-- badges: start -->
[![R-CMD-check](https://github.com/slwu89/ranges/workflows/R-CMD-check/badge.svg)](https://github.com/slwu89/ranges/actions)
[![test-coverage](https://github.com/slwu89/ranges/workflows/test-coverage/badge.svg)](https://github.com/slwu89/ranges/actions)
<!-- badges: end -->

Gives users tools to make integer ranges for benchmarking algorithms, especially for numerical or 
scientific computing, that need to be tested on arguments ranging over several
orders of magnitude. It can generate dense (linear) or sparse (logarithmic) ranges
and is designed to be used to generate input for benchmarking packages like:

  * [bench](https://bench.r-lib.org/)
  * [microbenchmark](https://cran.r-project.org/package=microbenchmark)
  * [rbenchmark](https://cran.r-project.org/package=rbenchmark)
