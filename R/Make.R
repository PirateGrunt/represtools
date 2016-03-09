#' Run the make command
#'
#' @param title Title of the Gather document
#'
#' @return NULL
#' @export
Make <- function(target){
  strMake <- "make"
  if (missing(target)) target <- "all"

  strMake <- paste(strMake, target, sep = " ")
  system(strMake)
}
