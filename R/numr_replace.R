#' Replace numbers with numerals
#'
#' Use these functions to turn a number into a string of Unicode digits from
#' another numeral system.
#' `numr_replace()` takes character vectors and uses string replacement.
#' `numr_substitute()` takes a numeric vector.
#'
#' @param x Input vector.
#' @param system Two-letter language code of the replacement numeral system.
#'
#' @details
#' `numr_substitute()` is vectorised over `x` and `system`, which are
#' [recycled][vctrs::vec_recycle] to their common length.
#' `numr_replace()` is vectorised over `x`.
#'
#' @return
#' Character vector the same length as `x` with numerals replaced.
#'
#' @export
#'
#' @examples
#' numr_replace("0123456789", "fa")
#' numr_substitute(0123459789, "fa")
numr_replace <- function(x, system) {
  # Uses internal dataset `numerals`, generated in data-raw/numerals.R
  numerals <- numerals
  stringi::stri_replace_all_coll(x,
                                 c(as.character(0:9), ".", ","),
                                 numerals[system,],
                                 vectorize_all = FALSE)
}

#' @rdname numr_replace
#' @export
numr_substitute <- function(x, system) {
  # Uses internal dataset `numerals`, generated in data-raw/numerals.R
  numerals <- numerals
  c(x, system) %<-% vec_recycle_common(x, system)

  xdig <- purrr::map(x, digits, base = 10L)
  xsub <- purrr::map2(system, xdig, ~numerals[.x, .y + 1])
  purrr::map_chr(xsub, paste0, collapse = "")
}

digits <- function(x, base = 10L) {
  x <- vec_cast(x, integer())
  d <- x %% base
  if (!x / base < 1) d <- c(digits(x %/% base, base), d)
  return(d)
}
