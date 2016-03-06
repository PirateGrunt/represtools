Gather <- function(mojo){

}

Cook <- function(fileStem, inputFiles){
  strFrom <- system.file("rmarkdown", "templates", "cook", "skeleton", "skeleton.Rmd", package = "represtools")
  strTo <- paste0("cook/", fileStem, ".Rmd")

  # file.copy(strFrom, strTo)

  mojo <- whisker::whisker.render(readLines(strFrom), list(COOK_STEM = fileStem))
  writeLines(mojo, strTo)
}

Analyze <- function(mojo){

}

Present <- function(mojo){

}
