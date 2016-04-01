#' @title LoadObjects
#' @export
#'
#' @name LoadObjects
#'
#' @param params A list of parameters. Should include the named items inputDir and inputFiles
#' @param loadFiles A list of
#'
#' @return Character vector of names of loaded objects
#'
#' @description Load objects from a defined input directory and set of files.
#' Objects are loaded into the Global environment.
LoadObjects <- function(params, loadFiles){

  if (!missing(params)) {
    paramElements <- intersect(c("inputDir", "inputFiles"), names(params))

    if (length(paramElements) != 2){
      stop ("Missing inputDir or inputFiles from params.")
    }

    loadFiles <- paste0(params$inputDir, params$inputFiles, ".rda")

  }

  strResult <- lapply(loadFiles, load, .GlobalEnv)

  loadedObjects <- unlist(strResult)

  loadedObjects

}

#'
#' Return a list of named objects
#'
#' @title  NamesToObjects
#'
#' @description Returns a list of the objects named in x
#'
#' @param x Vector or list of named objects
#' @param envir Environment in which to search
#'
#' @return A list of objects
#'
#' @export
#'
NamesToObjects <- function(x, envir){

  if (missing(envir)) envir <- globalenv()
  x <- unique(x)

  if (is.list(x)){
    x <- unlist(x)

    nonChar <- lapply(x, typeof)
    nonChar <- nonChar[nonChar != "character"]
    if (length(nonChar) != 0){
      warning("Some non-character elements in x. These will be converted into characters.")
    }
  } else {
    if (typeof(x) != "character") {
      warning("x is not a character vector. It will be converted to character.")
    }
  }

  x <- as.character(x)

  obj <- lapply(x, get0, envir = envir)
  validObjects <- sapply(obj, is.null)
  validObjects <- !validObjects
  obj <- obj[validObjects]

  names(obj) <- x[validObjects]

  obj

}

#'
#' Describe the objects
#'
#' @export
#'
#' @param objects The objects to be described
#' @param FUNS the functions which will describe the objects
DescribeObjects <- function(objects, FUNS){

  if (typeof(objects) == "character"){
    objects <- NamesToObjects(objects)
  }

  if (typeof(objects) != "list") objects <- as.list(objects)
  if (typeof(FUNS) != "list") FUNS <- as.list(FUNS)

  for (iObj in seq_along(objects)){
    for (iFun in seq_along(FUNS)){
      result <- do.call(FUNS[[iFun]], objects[iObj])
      if (!is.null(result)) print(result)
    }
  }
}

#'
#' Gather objects
#'
#' @export
#'
#' @param patterns A vector of patterns
#' @param env An enviroment. If missing, the global environment will be used.
#'
GatherObjects <- function(patterns = c("^df", "^plt", "^fit"), env){

  if (missing(env)) env <- .GlobalEnv

  patterns <- unique(patterns)

  strObjects <- list(length(patterns))
  for (i in seq_along(patterns)){
    strObjects[[i]] <- ls(pattern = patterns[i], envir = env)
  }

  strObjects <- unlist(strObjects)

  strObjects
}
