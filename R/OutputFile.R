#' @export
#'
#' @description Construct an output file from a params list.
#'
#' @name OutputFile
#'
#' @title OutputFile
#'
#' @param params List object with output directory and file stem elements
#'
OutputFile <- function(params){
  outFile <- paste0(params$outputDir, params$fileStem, ".rda")
  outFile
}
