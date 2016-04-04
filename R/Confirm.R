ConfirmExe <- function(exe){
  whereIsIt <- unname(Sys.which(exe))

  nchar(whereIsIt) != 0

}

ConfirmMake <- function(){
  gotMake <- ConfirmExe("make")
}

ConfirmTeX <- function(){

}

ConfirmMarkdown <- function(){

}

ConfirmRStudio <- function(){

}
