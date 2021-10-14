# ranges

Gives users tools to Make integer ranges for benchmarking algorithms, especially for numerical or 
scientific computing, that need to be tested on arguments ranging over several
orders of magnitude. It can generate dense (linear) or sparse (logarithmic) ranges
and is designed to be used to generate input for benchmarking packages like:

  * [bench](https://bench.r-lib.org/)
  * [microbenchmark](https://cran.r-project.org/package=microbenchmark)
  * [rbenchmark](https://cran.r-project.org/package=rbenchmark)
