#
# range.R
#
# Created on Oct 13, 2021
#   Author: Sean L. Wu
#


#' @title Append the powers of `mult` in the closed interval \[`lo`, `hi`\]
#' @description Generate a sequence consisting of the powers of `mult` on the closed interval \[`lo`, `hi`\].
#' This function works on integer sequences, so if an interval is requested outside of
#' the maximum representable range of integers \eqn{[-(2^{31} - 1), 2^{31} - 1]} it
#' will throw an error. This function will only produce sequences of positive integers.
#' @note This is not intended to be called directly by users, but it is exported
#' in case it is useful to be imported into another package.
#' @param lo bottom of the interval
#' @param hi top of the interval
#' @param mult multiplier
#' @return an `integer` vector
#' @examples add_powers(lo = 8, hi = bitwShiftL(a = 8, n = 10))
#' @export
add_powers <- function(lo, hi, mult = 8) {

  stopifnot(length(c(lo, hi, mult)) == 3)
  stopifnot(all(is.finite(c(lo, hi, mult))))

  lo <- as.integer(lo)
  hi <- as.integer(hi)
  mult <- as.integer(mult)

  stopifnot(lo >= 0)
  stopifnot(hi >= lo)
  stopifnot(mult >= 2)

  kmax <- .Machine$integer.max

  # space out the values in multiples of mult, to get from lo to hi.
  # max(lo,1) in case lo=0, we still want to make a range from 1 in that case
  start <- ceiling(log(base = mult, x = max(lo, 1L)))
  end <- floor(log(base = mult, x = hi))
  dst <- mult^(start:end)

  return(as.integer(dst))
}


#' @title Create a sequence of negative powers on a closed interval
#' @description Calls [add_powers] to produce sequences of negative powers. This
#' function will only produce sequences of negative integers.
#' @note This is not intended to be called directly by users, but it is exported
#' in case it is useful to be imported into another package.
#' @param lo bottom of the interval
#' @param hi top of the interval
#' @param mult multiplier
#' @return an `integer` vector
#' @examples add_negated_powers(lo = -bitwShiftL(a = 8, n = 10), hi = -8, mult = 8)
#' @export
add_negated_powers <- function(lo, hi, mult = 8) {

  stopifnot(length(c(lo, hi, mult)) == 3)
  stopifnot(all(is.finite(c(lo, hi, mult))))

  lo <- as.integer(lo)
  hi <- as.integer(hi)
  mult <- as.integer(mult)

  kmin <- -.Machine$integer.max

  stopifnot(lo >= kmin)
  stopifnot(hi >= kmin)
  stopifnot(hi >= lo)
  stopifnot(hi <= 0L)

  hi_inner = min(hi, -1L);

  lo_complement <- -lo
  hi_complement <- -hi_inner

  dst <- add_powers(lo = hi_complement, hi = lo_complement, mult = mult)
  dst <- rev(-dst)

  return(as.integer(dst))
}


#' @title Create a logarithmic range of integers
#' @description Create a range from the powers of `mult` on the closed interval \[`lo`, `hi`\].
#' The endpoints are included, even if they are not multiples of `mult`. The range
#' may go from negative to positive values if requested.
#' This function works on integer sequences, so if an interval is requested outside of
#' the maximum representable range of integers \eqn{[-(2^{31} - 1), 2^{31} - 1]} it
#' will throw an error.
#' @param lo bottom of the interval
#' @param hi top of the interval
#' @param mult multiplier
#' @param exclude_zero include `0` in the interval or not
#' @examples add_range(lo = 8, hi = bitwShiftL(a = 8, n = 10), mult = 2)
#' @export
create_range_log <- function(lo, hi, mult = 8, exclude_zero = FALSE) {

  stopifnot(length(c(lo, hi, mult)) == 3)
  stopifnot(all(is.finite(c(lo, hi, mult))))

  lo <- as.integer(lo)
  hi <- as.integer(hi)
  mult <- as.integer(mult)

  stopifnot(hi >= lo)
  stopifnot(mult >= 2)

  dst <- lo

  # special cases
  if (lo == hi) {
    return(dst)
  }

  if (lo + 1L == hi) {
    dst <- c(dst, hi)
    return(dst)
  }

  # Add all powers of 'mult' in the range [lo+1, hi-1] (inclusive).
  lo_inner = lo + 1L;
  hi_inner = hi - 1L;

  # insert negative values
  if (lo_inner < 0L) {
    dst_n <- add_negated_powers(lo = lo_inner, hi = min(hi_inner, -1L), mult = mult)
    dst <- c(dst, dst_n)
  }

  # treat 0 as a special case
  if (lo < 0L & hi >= 0L & !exclude_zero) {
    dst <- c(dst, 0L)
  }

  # insert positive values
  if (hi_inner > 0L) {
    dst_p <- add_powers(lo = max(lo_inner, 1L), hi = hi_inner, mult = mult)
    dst <- c(dst, dst_p)
  }

  # add "hi" if different from last value
  if (hi != dst[length(dst)]) {
    dst <- c(dst, hi)
  }

  return(dst)
}
