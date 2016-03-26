#' @title LoadInput
#' @export
#'
#' @name LoadInput
#'
#' @param params A list of parameters. Should include the named items inputDir and inputfiles
#'
#' @return Character vector of names of loaded objects
#'
#' @description Load files from a defined input directory and set of files
LoadInput <- function(params){

  if (setdiff(c("inputDir", "inputFiles"), names(params))){
    stop ("Missing inputDir or inputFiles from params.")
  }

  loadFiles <- paste0(params$inputDir, params$inputFiles, ".rda")
  lapply(loadFiles, load, .GlobalEnv)
  loadedObjects <- ls()
  loadedObjects <- loadedObjects[loadedObjects != "params"]
  loadedObjects
}

NamesToObjects <- function(lst){

}
