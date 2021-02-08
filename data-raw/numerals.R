# numerals.R
# Prepares internal dataset `numerals`
#
# Column format for base 10, positional numeral systems:
#   <language> = c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ",")
#
# <language> should be the two-letter ISO 639-1 code of the language which
# matches the unicode block that the numerals are found in, e.g. U+09E6 to
# U+09EF is "Bengali" (bn), even though the same digits are used in other
# languages.
#
# The order of the character vector roughly follows the unicode code blocks for
# digits, i.e. the last two elements are the decimal separator and the
# thousands separator.
# The thousand separator character currently isn't used for anything, but might
# be in the future.
#
# <https://www.compart.com/> is useful for finding unicode numerals and block
# names.
#
# Non-positional and/or non-base 10 systems need special handling and aren't
# yet supported.

numerals <- rbind(
  en = c("0",      "1",      "2",      "3",      "4",      "5",      "6",      "7",      "8",      "9",      ".",      ","),
  ar = c("\u0660", "\u0661", "\u0662", "\u0663", "\u0664", "\u0665", "\u0666", "\u0667", "\u0668", "\u0669", "\u066B", "\u066C"),
  bn = c("\u09E6", "\u09E7", "\u09E8", "\u09E9", "\u09EA", "\u09EB", "\u09EC", "\u09ED", "\u09EE", "\u09EF", ".",      "\u2009"),
  fa = c("\u06F0", "\u06F1", "\u06F2", "\u06F3", "\u06F4", "\u06F5", "\u06F6", "\u06F7", "\u06F8", "\u06F9", "\u066B", "\u066C"),
  my = c("\u1040", "\u1041", "\u1042", "\u1043", "\u1044", "\u1045", "\u1046", "\u1047", "\u1048", "\u1049", ".",      "\u2009")
)
colnames(numerals) <- c(0:9, ".", ",")

usethis::use_data(numerals, internal = TRUE, overwrite = TRUE)
