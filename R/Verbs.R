
#' @importFrom whisker whisker.render
CreateStepFile <- function(step, fileStem, title, inputFiles, outputFormat){

  if (missing(fileStem) & missing(title)) stop("Either fileStem or title argument must be present.")
  if (missing(title)) title <- fileStem
  if (missing(fileStem)) fileStem <- title
  if (!missing(inputFiles)){
    inputFiles <- paste0("\"", inputFiles, '"')
    inputFiles <- paste0("- ", inputFiles, collapse = "\n    ")
  } else {
    inputFiles <- ""
  }
  if (missing(outputFormat)) outputFormat <- "html_document"

  strFrom <- system.file("rmarkdown", "templates", step, "skeleton", "skeleton.Rmd", package = "represtools")
  strTo <- paste0(step, "/", fileStem, ".Rmd")

  title <- sprintf('"%s"', title)
  fileStem <- sprintf('"%s"', fileStem)

  strSkeleton <- whisker::whisker.render(readLines(strFrom)
                                         , list(FILE_STEM = fileStem
                                                , INPUT_FILES = inputFiles
                                                , TITLE = title
                                                , OUTPUT_FORMAT = outputFormat))
  writeLines(strSkeleton, strTo)
}

#' Create a gather file
#'
#' @param fileStem The file stem
#' @param title Title of the Gather document
#'
#' @return NULL
#' @export
Gather <- function(fileStem, title){
  myArgs <- as.list(match.call())
  myArgs[[1]] <- (step = "gather")
  do.call(CreateStepFile, myArgs, quote = TRUE)
}

#' Create a cook file
#'
#' @param fileStem The file stem
#' @param inputFiles A vector of files to load
#' @param title Title of the Cook document
#'
#' @return NULL
#' @export
Cook <- function(fileStem, inputFiles, title){
  myArgs <- as.list(match.call())
  myArgs[[1]] <- (step = "cook")
  eval(myArgs)
  do.call(CreateStepFile, myArgs)
}

#' Create an analysis file
#'
#' @param fileStem The file stem
#' @param inputFiles A vector of files to load
#' @param title Title of the document
#'
#' @return NULL
#' @export
Analyze <- function(fileStem, inputFiles, title){
  myArgs <- as.list(match.call())
  myArgs[[1]] <- (step = "analyze")
  eval(myArgs)
  do.call(CreateStepFile, myArgs, quote = TRUE)
}

#' Create a presentation file
#'
#' @param fileStem The file stem
#' @param inputFiles A vector of files to load
#' @param title Title of the document
#' @param outputFormat A string indicating the outputFormat
#'
#' @return NULL

#' @export
Present <- function(fileStem, inputFiles, title, outputFormat){
  myArgs <- as.list(match.call())
  myArgs[[1]] <- (step = "present")
  eval(myArgs)
  do.call(CreateStepFile, myArgs, quote = TRUE)
}
