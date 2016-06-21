FindMake <- function(){

  strMakeCommand <- Sys.getenv("MAKE")

  if (nchar(strMakeCommand) == 0) strMakeCommand <- "make"

  unname(Sys.which(strMakeCommand))

}

#' Run the make command
#'
#' This will run the \code{make} program with whatever target the user selects. The default target is "all". The function works by calling
#' the \code{\link[base]{system2}} function. It is presumed that an appropriate \code{make} utilty exists on the user's computer. Further
#' note that the default makefile for an analysis project uses GNU extensions like wildcards.
#'
#' The function will to try to confirm
#'
#' @param target The make target to run
#' @param command User-supplied location of the \code{make} command
#' @param ... Additional arguments to the \code{\link[base]{system2}} function
#'
#' @return NULL
#' @export
#'
#' @seealso \code{\link[base]{system2}} \code{\link[base]{system}} \code{\link[base]{Sys.which}}
#'
#' @examples
#'
#' \dontrun{
#' Make()
#' Make("clean", command = "/usr/bin/gmake")
#' Make("gather")
#' Make("MyFile.rda")
#' }
Make <- function(target = "all", command = "", ...){

  if (missing(target)) target <- "all"

  if (missing(command)){
    command <- FindMake()

    if (nchar(command) == 0) stop("Could not find make command.")

  }

  system2(command, args = target, ...)
}
