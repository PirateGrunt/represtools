#' Run the make command
#'
#' @param target The make target to run
#'
#' @return NULL
#' @export
Make <- function(target){
  strMake <- "make"
  if (missing(target)) target <- "all"

  strMake <- paste(strMake, target, sep = " ")
  system(strMake)
}
