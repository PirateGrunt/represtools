
AtLeastOneAlphaNumeric <- function(x){
  y <- grepl("(?!_)(\\w+)", x, perl=TRUE)

  y
}

# wrong <- c("../", "", "_", " ", ".")
# right <- c("00", "ü", "Mojo_f", "Alpha.", ".alpha", "../mojo/")
#
# AtLeastOneAlphaNumeric(wrong)
# AtLeastOneAlphaNumeric(right)
