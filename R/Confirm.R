ConfirmExe <- function(exe){
  whereIsIt <- unname(Sys.which(exe))

  nchar(whereIsIt) != 0

}

#' Confirm existence of Make
#'
#' @return Boolean indicating
#'
#'
ConfirmMake <- function(){
  gotMake <- ConfirmExe("make")
}

ConfirmTeX <- function(){

}

ConfirmMarkdown <- function(){

}

ConfirmRStudio <- function(){

}
