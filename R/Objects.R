#' @title LoadObjects
#' @export
#'
#' @name LoadObjects
#'
#' @param params A list of parameters. Should include the named items inputDir and inputFiles.
#' @param env An environment in which to load objects. Defaults to the global environment.
#' @param loadFiles A character vector of files containing saved data.
#'
#' @return Character vector containing the names of loaded objects.
#'
#' @description This function will load a set of objects stored in .rda files. By default, objects are
#' loaded into the Global environment.
#'
#' @details The params object is defined within an RMarkdown file and contains named items "inputDir" and "inputFiles".
#' As an expedient, one may pass a vector of filenames. This vector will only be used if the params argument has been
#' omitted.
#'
#' @examples
#' \dontrun{
#' loadedObjects <- LoadObjects(params)
#' }
#'
LoadObjects <- function(params, env = .GlobalEnv, loadFiles){

  if (!missing(params)) {
    paramElements <- intersect(c("inputDir", "inputFiles"), names(params))

    if (length(paramElements) != 2){
      stop ("Missing inputDir or inputFiles from params.")
    }

    loadFiles <- paste0(params$inputDir, params$inputFiles, ".rda")

  }

  if (missing (env) ) env <- .GlobalEnv

  strResult <- lapply(loadFiles, load, env)

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
#' @details x is given as either a character vector containing names of objects to return, or
#' a list. If x is a list, it will first be converted to character. If objects do not exist, no error
#' or warning will be generated.
#'
#' @param x Vector or list of named objects
#' @param envir Environment in which to search
#'
#' @return A list of objects
#'
#' @export
#'
#' @examples
#' \dontrun{
#' mojo <- 4
#' gonzo <- "Moe"
#' lstObjects <- NamesToObjects(c("mojo", "gonzo"))
#' }
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

#' I'm throwing in the towel on this function. I'm just not clear on the behavior that I'd like:
#'
#' 1. Given a vector of objects, apply a vector of functions. This is most common when I want to
#'    apply both `str` and `summary` to a data frame.
#'
#' 2. How is that implemented in practice? I either want the output printed or I want to capture the
#'    output to print later, but I'm not sure. The easiest option would be to print everything.
#'
#' 3. And that's what I'll do.
#'
#'
#' Describe the objects
#'
#' @export
#'
#' @param objects A list of objects to be described
#' @param FUNS the functions which will describe the objects
#' @param env An enviroment. If missing, the global environment will be used.
#'
#' @description This will apply functions to a vector of objects.
#'
#' @details This may be used to quickly summarize a set of objects. Note that functions are called for their
#' side effects of printing output
#'
#' x may be given as a character vector or a list.
#'
#'
#' @examples
#' \dontrun{
#' myFit1 <- lm(myData, y ~ x1 + x2)
#' myFit2 <- lm(myData, y ~ x3)
#'
#' DesribeObjects(list(myFit1, myFit2), broom::tidy)
#' }
#'
DescribeObjects <- function(objects, FUNS, env){

  if (missing(env)) env <- .GlobalEnv

  if (missing(FUNS)){
    FUNS <- list(utils::str)
  }

  # if (typeof(objects) == "character"){
  #   objects <- NamesToObjects(objects)
  # }

  # if (typeof(objects) != "list") objects <- as.list(objects)

  if(typeof(FUNS) == "character") FUNS <- as.list(FUNS)
  if (typeof(FUNS) != "list") FUNS <- list(FUNS)

  # names(objects) <- "object"

  # result <- list(length(FUNS))

  for (iFun in seq_along(FUNS)){
    # for (iObj in seq_along(objects)){

      lapply(objects, FUNS[[iFun]])

      # argName <- formalArgs(FUNS[[iFun]])[1]
      # names(objects) <- argName
      # result[] <- do.call(FUNS[[iFun]], objects[iObj], envir = env)
      # if (!is.null(result)) print(result)
    # }
  }

  return(NULL)
}

#'
#' List objects
#'
#' Form a character vector of the names of objects, based on patterns.
#'
#' @return character vector
#'
#' @export
#'
#' @param patterns A vector of patterns
#' @param env An enviroment. If missing, the global environment will be used.
#'
#' @details This will collect objects based on a vector of character patterns.
#'
ListObjects <- function(patterns = c("^df", "^plt", "^fit"), env){

  if (missing(env)) env <- .GlobalEnv

  patterns <- unique(patterns)

  strObjects <- list(length(patterns))
  for (i in seq_along(patterns)){
    strObjects[[i]] <- ls(pattern = patterns[i], envir = env)
  }

  strObjects <- unlist(strObjects)

  strObjects
}
