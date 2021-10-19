test_that("add_powers correctly makes positive ranges", {
  # basic range generation
  expect_equal(add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = 8), 8^(1:4))
  expect_equal(add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = 2), 8*(2^(0:10)))
  expect_equal(add_powers(lo = 0, hi = bitwShiftL(a = 8, n = 10), mult = 8), 8^(0:4))
  expect_equal(add_powers(lo = 2, hi = 100, mult = 3), 3^(1:4))

  # things are floor-d
  expect_equal(
    add_powers(lo = 0, hi = bitwShiftL(a = 8, n = 10), mult = 3),
    add_powers(lo = 0, hi = bitwShiftL(a = 8, n = 10), mult = 3.5)
  )
})

test_that("add_powers errors for bad input", {
  # bad mult
  expect_error(add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = -1))
  expect_error(add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = 1))
  expect_error(add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = 0))
  expect_error(add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = Inf))
  expect_error(add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = -Inf))
  expect_error(add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = NULL))
  expect_error(add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = NA))
  expect_error(add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = NaN))

  # bad lo
  expect_error(add_powers(lo = -1, hi = bitwShiftL(a = 8, n = 10), mult = 2))
  expect_error(add_powers(lo = Inf, hi = bitwShiftL(a = 8, n = 10), mult = 2))
  expect_error(add_powers(lo = -Inf, hi = bitwShiftL(a = 8, n = 10), mult = 2))
  expect_error(add_powers(lo = NULL, hi = bitwShiftL(a = 8, n = 10), mult = 2))
  expect_error(add_powers(lo = NA, hi = bitwShiftL(a = 8, n = 10), mult = 2))
  expect_error(add_powers(lo = NaN, hi = bitwShiftL(a = 8, n = 10), mult = 2))

  # bad hi
  expect_error(add_powers(lo = 8, hi = -1, mult = -1))
  expect_error(add_powers(lo = 8, hi = 0, mult = 0))
  expect_error(add_powers(lo = 8, hi = 6, mult = 0))
  expect_error(add_powers(lo = 8, hi = -Inf, mult = 0))
  expect_error(add_powers(lo = 8, hi = Inf, mult = 0))
  expect_error(add_powers(lo = 8, hi = NULL, mult = 0))
  expect_error(add_powers(lo = 8, hi = NaN, mult = 0))
  expect_error(add_powers(lo = 8, hi = NA, mult = 0))

  # out of integer range (error from stopifnot(hi >= lo), warning from as.integer(2^31))
  add_powers(lo = 2, hi = (2^31), mult = 2) %>%
    expect_error() %>%
    expect_warning()
})

test_that("add_negated_powers correctly makes negative ranges", {
  # basic range generation
  expect_equal(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = -8, mult = 8), -8^c(4,3,2,1))
  expect_equal(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = -8, mult = 2), -8*(2^(10:0)))
  expect_equal(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = 0, mult = 2), -2^(13:0))
  expect_equal(add_negated_powers(lo = -100, hi = -2, mult = 3), -3^(4:1))

  # things are floor-d
  expect_equal(
    add_negated_powers(lo = -1e3, hi = -10, mult = 10),
    add_negated_powers(lo = -1e3, hi = -10, mult = 10.9)
  )
})

test_that("add_negated_powers errors for bad input", {
  # bad mult
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = -8, mult = -1))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), mult = 1))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), mult = 0))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), mult = Inf))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), mult = -Inf))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), mult = NULL))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), mult = NA))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), mult = NaN))

  # bad lo
  expect_error(add_negated_powers(lo = -6, hi = -8, mult = 2))
  expect_error(add_negated_powers(lo = 0, hi = -8, mult = 2))
  expect_error(add_negated_powers(lo = -Inf, hi = -8, mult = 2))
  expect_error(add_negated_powers(lo = Inf, hi = -8, mult = 2))
  expect_error(add_negated_powers(lo = NULL, hi = -8, mult = 2))
  expect_error(add_negated_powers(lo = NA, hi = -8, mult = 2))
  expect_error(add_negated_powers(lo = NaN, hi = -8, mult = 2))

  # bad hi
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = 1, mult = 2))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = Inf, mult = 2))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = -Inf, mult = 2))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = -bitwShiftL(a = 8, n = 11), mult = 2))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = NULL, mult = 2))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = NaN, mult = 2))
  expect_error(add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = NA, mult = 2))

  # out of integer range (error from stopifnot(hi >= lo), warning from as.integer(2^31))
  add_negated_powers(lo = -(2^31), hi = -2, mult = 2) %>%
    expect_error() %>%
    expect_warning()
})


test_that("create_range_exp correctly makes ranges", {

  # basic range generation
  expect_equal(create_range_exp(lo = 0, hi = 1024, mult = 2), c(0, 2^(0:10)))
  expect_equal(create_range_exp(lo = -1024, hi = 1024, mult = 2), c(-2^(10:0), 0, 2^(0:10)))
  expect_equal(create_range_exp(lo = -1024, hi = 1024, mult = 3), c(-1024, -3^(6:0), 0, 3^(0:6), 1024))
  expect_equal(create_range_exp(lo = 0, hi = 0), 0)
  expect_equal(create_range_exp(lo = 0,hi = 1), c(0, 1))
  expect_equal(create_range_exp(lo = 10, hi = 10), 10)

  # things are floor-d
  expect_equal(
    create_range_exp(lo = -1e3, hi = -10, mult = 10),
    create_range_exp(lo = -1e3, hi = -10, mult = 10.9)
  )
})

test_that("create_range_exp errors for bad input", {
  # bad mult
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), hi = -8, mult = -1))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), mult = 1))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), mult = 0))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), mult = Inf))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), mult = -Inf))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), mult = NULL))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), mult = NA))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), mult = NaN))

  # bad lo
  expect_error(create_range_exp(lo = -Inf, hi = -8, mult = 2))
  expect_error(create_range_exp(lo = Inf, hi = -8, mult = 2))
  expect_error(create_range_exp(lo = NULL, hi = -8, mult = 2))
  expect_error(create_range_exp(lo = NA, hi = -8, mult = 2))
  expect_error(create_range_exp(lo = NaN, hi = -8, mult = 2))

  # bad hi
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), hi = Inf, mult = 2))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), hi = -Inf, mult = 2))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), hi = NULL, mult = 2))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), hi = NaN, mult = 2))
  expect_error(create_range_exp(lo = -bitwShiftL(a = 8, n = 10), hi = NA, mult = 2))

  # bad range
  expect_error(create_range_exp(lo = 8, hi = 2, mult = 2))
  expect_error(create_range_exp(lo = -2, hi = -64, mult = 2))

  # out of integer range (error from stopifnot(hi >= lo), warning from as.integer(2^31))
  create_range_exp(lo = -(2^31), hi = -2, mult = 2) %>%
    expect_error() %>%
    expect_warning()
})

