# numerals.R
# Prepares internal dataset `numerals`

numerals <- data.frame(
  en = as.character(0:9),
  ar = c("\u0660", "\u0661", "\u0662", "\u0663", "\u0664", "\u0665", "\u0666", "\u0667", "\u0668", "\u0669"),
  fa = c("\u06F0", "\u06F1", "\u06F2", "\u06F3", "\u06F4", "\u06F5", "\u06F6", "\u06F7", "\u06F8", "\u06F9"),
  bn = c("\u09E6", "\u09E7", "\u09E8", "\u09E9", "\u09EA", "\u09EB", "\u09EC", "\u09ED", "\u09EE", "\u09EF")
)

usethis::use_data(numerals, internal = TRUE, overwrite = TRUE)
