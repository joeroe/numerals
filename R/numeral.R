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

#' @export
vec_ptype2.numeral.numeral <- function(x, y, ...) {
  new_numeral(system = numr_system(x))
}

#' @export
vec_cast.numeral.numeral <- function(x, to, ...) {
  new_numeral(vec_data(x), system = numr_system(to))
}

#' @export
vec_ptype2.numeral.double <- function(x, y, ...) x

#' @export
vec_ptype2.double.numeral <- function(x, y, ...) y

#' @export
vec_cast.numeral.double <- function(x, to, ...) new_numeral(x, system = numr_system(to))

#' @export
vec_cast.double.numeral <- function(x, to, ...) vec_data(x)


# Arithmetic --------------------------------------------------------------

#' @method vec_arith numeral
#' @export
vec_arith.numeral <- function(op, x, y, ...) {
  UseMethod("vec_arith.numeral", y)
}

#' @method vec_arith.numeral default
#' @export
vec_arith.numeral.default <- function(op, x, y, ...) {
  stop_incompatible_op(op, x, y)
}

#' @method vec_arith.numeral numeral
#' @export
vec_arith.numeral.numeral <- function(op, x, y, ...) {
  new_numeral(vec_arith_base(op, x, y), numr_system(x))
}

#' @method vec_arith.numeral numeric
#' @export
vec_arith.numeral.numeric <- function(op, x, y, ...) {
  new_numeral(vec_arith_base(op, x, y), numr_system(x))
}

#' @method vec_arith.numeric numeral
#' @export
vec_arith.numeric.numeral <- function(op, x, y, ...) {
  new_numeral(vec_arith_base(op, x, y), numr_system(y))
}

#' @method vec_arith.numeral MISSING
#' @export
vec_arith.numeral.MISSING <- function(op, x, y, ...) {
  switch(op,
         `-` = x * -1,
         `+` = x,
         stop_incompatible_op(op, x, y))
}

# Attributes --------------------------------------------------------------

#' @export
numr_system <- function(x) attr(x, "system")
