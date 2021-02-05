# numeral.R
# S3 vector class numeral (numr): numerics in other numeral systems

methods::setOldClass(c("numeral", "vctrs_vctr"))

# Construct ---------------------------------------------------------------

#' @export
numeral <- function(x = numeric(), system = c("en", "ar", "fa")) {
  x <- vec_cast(x, numeric())
  system <- rlang::arg_match(system)
  new_numeral(x, system)
}

new_numeral <- function(x = numeric(), system = character()) {
  vec_assert(x, numeric())
  vec_assert(system, character())
  new_vctr(x, system = system, class = "numeral")
}


# Validate ----------------------------------------------------------------

is_numeral <- function(x) {
  inherits(x, "numeral")
}


# Print/format ------------------------------------------------------------

#' @export
vec_ptype_abbr.numeral <- function(x, ...) "numr"

#' @export
format.numeral <- function(x, ...) {
  out <- format(vec_data(x))
  out <- numr_replace(out, numr_system(x))
  out
}


# Cast/coerce -------------------------------------------------------------


# Attributes --------------------------------------------------------------

#' @export
numr_system <- function(x) attr(x, "system")
