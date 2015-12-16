#' Create a new analysis
#'
#' @param path A character variable indicating the name of the project to create
#' @param packrat Boolean indicating whether or not packrat should be used. Default is TRUE.
#' @param RStudio Boolean indicating whether or not to create an RStudio project. Default is TRUE.
#' @param git Boolean indicating whether to initialize a new git repository. Default is TRUE.
#' @param overwrite Overwrite the directory if it already exists. Default is FALSE.
#' @param createNewDirectory Create a new directory? Default is TRUE.
#'
#' @return NewAnalysis will invisibly return the name of the project.
#'
#'
NewAnalysis <- function(path = ".", RStudio = TRUE
                        , git = TRUE, packrat = TRUE
                        , overwrite = FALSE
                        , createNewDirectory = TRUE){

  # If we're not creating a new directory, we must sit under a parent. To get the parent
  # name, we have to temporarily switch to that directory. This allows us to get the base name
  # if the user has provided a relative path.
  if (!createNewDirectory){
    if (!AtLeastOneAlphaNumeric(path)) {
      oldWD <- setwd(path)
      path <- getwd()
      setwd(oldWD)
    }

    if (!dir.exists(path)){
      stop ("The path you've entered does not exist. Did you mean to set createNewDirectory to TRUE?")
    }
  }

  projectName <- ProjectName(path)

  dir.create(file.path(path, "gather"), recursive = TRUE)
  dir.create(file.path(path, "gathered"), recursive = TRUE)
  dir.create(file.path(path, "cook"), recursive = TRUE)
  dir.create(file.path(path, "cooked"), recursive = TRUE)
  dir.create(file.path(path, "analyze"), recursive = TRUE)
  dir.create(file.path(path, "analyzed"), recursive = TRUE)
  dir.create(file.path(path, "publish"), recursive = TRUE)
  dir.create(file.path(path, "published"), recursive = TRUE)

  NewMakefile(path)

  if (RStudio) AddRStudio(path, projectName)

#   if (packrat) AddPackrat()
#

#
#   if (git) AddGit()

  invisible(path)
}

NewMakefile <- function(path){

  makefile <- system.file("templates", "Makefile", package = "represtools")
  makefile <- readLines(makefile)

  outFile <- file(file.path(path, "Makefile"))
  writeLines(makefile, con=outFile)

  close(outFile)

}

AddRStudio <- function(path, projectName){

  rproj <- system.file("templates", "rstudio.Rproj", package = "represtools")
  rproj <- readLines(rproj)

  filename <- paste0(projectName, ".Rproj")
  outFile <- file(file.path(path, filename))
  writeLines(rproj, con=outFile)

  close(outFile)
}

ProjectName <- function(path){
  root <- basename(path)
  if (!AtLeastOneAlphaNumeric(root)) {
    stop ("Project directory must have at least one alphnumeric character. Root directory may not be used.")
  }
  root
}
