
#' @export
numr_replace <- function(x, system) {
  # Uses internal dataset `numerals`, generated in data-raw/numerals.R
  numerals <- numerals
  stringi::stri_replace_all_coll(x, as.character(0:9), numerals[[system]],
                                 vectorize_all = FALSE)
}
