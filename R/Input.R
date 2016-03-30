#' @title LoadInput
#' @export
#'
#' @name LoadInput
#'
#' @param params A list of parameters. Should include the named items inputDir and inputfiles
#'
#' @return Character vector of names of loaded objects
#'
#' @description Load objects from a defined input directory and set of files.
#' Objects are loaded into the Global environment.
LoadInput <- function(params){

  paramElements <- intersect(c("inputDir", "inputFiles"), names(params))

  if (length(paramElements) != 2){
    stop ("Missing inputDir or inputFiles from params.")
  }

  loadFiles <- paste0(params$inputDir, params$inputFiles, ".rda")

  currentObjects <- ls(envir = .GlobalEnv)

  lapply(loadFiles, load, .GlobalEnv)

  loadedObjects <- ls(envir = .GlobalEnv)
  replacedObjects <- intersect(loadedObjects, currentObjects)
  newObjects <- setdiff(loadedObjects, currentObjects)
  loadedObjects <- unique(c(newObjects, replacedObjects))

  loadedObjects

}
