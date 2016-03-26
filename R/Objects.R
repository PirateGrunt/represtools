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

  obj <- lapply(x, get0)
  obj <- obj[!is.null(obj)]

  obj

}

#'
#' Describe the objects
#'
#' @export
DescribeObjects <- function(objects, FUNS){

  if (typeof(objects) != "list") objects <- as.list(objects)
  if (typeof(FUNS) != "list") FUNS <- as.list(FUNS)

  for (iObj in seq_along(objects)){
    for (iFun in seq_along(FUNS)){
      result <- do.call(FUNS[[iFun]], objects[iObj])
      if (!is.null(result)) print(result)
    }
  }
}
