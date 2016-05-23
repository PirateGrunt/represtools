#' Read a SQL file
#'
#' @param filename A character variable with a filename
#' @param warn Warn if there is a missing final end of line. Default is TRUE
#'
#' @return String

#' @export
GetSQL <- function(filename, warn = FALSE){
  fileConn <- file(filename, open = "r")
  strSQL = readLines(fileConn, warn = warn)
  close(fileConn)

  strSQL <- paste(strSQL, collapse=" ")
  strSQL = gsub("\\t", " ", strSQL)
  strSQL
}


timestamp(prefix = "", suffix = "")
