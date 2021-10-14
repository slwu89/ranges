test_that("add_powers correctly makes ranges", {
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

