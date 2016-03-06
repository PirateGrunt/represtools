#' Read a SQL file
#'
#' @param filename A character variable with a filename
#'
#' @return String

#' @export
GetSQL <- function(filename){
  fileConn <- file(filename, open = "r")
  strSQL = readLines(fileConn)
  close(fileConn)

  strSQL <- paste(strSQL, collapse=" ")
  strSQL = gsub("\\t", " ", strSQL)
  strSQL
}


timestamp(prefix = "", suffix = "")
