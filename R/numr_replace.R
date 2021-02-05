#' Replace numerals in a string
#'
#' `numr_replace()` replaces the numerals in a string with another numeral
#' system. It is vectorised over `x`.
#'
#' @param x Character. Input vector.
#' @param system Two-letter language code of the replacement numeral system.
#'
#' @return
#' Character vector the same length as `x` with numerals replaced.
#'
#' @export
#'
#' @examples
#' numr_replace("0123456789", "ar")
numr_replace <- function(x, system) {
  # Uses internal dataset `numerals`, generated in data-raw/numerals.R
  numerals <- numerals
  stringi::stri_replace_all_coll(x, as.character(0:9), numerals[[system]],
                                 vectorize_all = FALSE)
}
