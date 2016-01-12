ConfirmExe <- function(exe){
  whereIsIt <- Sys.which(exe)

  if (nchar(whereIsIt) == 0){

  } else {

  }
}

#' Confirm existence of Make
#'
#' @return Boolean indicating
#'
#'
ConfirmMake <- function(){
  gotMake <- ConfirmExe()
}

ConfirmTeX <- function(){

}

ConfirmMarkdown <- function(){

}

ConfirmRStudio <- function(){

}
