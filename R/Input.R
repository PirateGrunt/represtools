#' @title LoadInput
#' @export
#'
#' @name LoadInput
#'
#' @return Character vector of names of loaded objects
#'
#'
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
