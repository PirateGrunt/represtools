AtLeastOneAlphaNumeric <- function(x){
  y <- grepl("(?!_)(\\w+)", x, perl=TRUE)

  y
}

#' Create a new Research
#'
#' @param path A character variable indicating the name of the project to create
#' @param RStudio Boolean indicating whether or not to create an RStudio project. Default is TRUE.
#' @param useExistingDirectory Overwrite the directory if it already exists. Default is FALSE.
#'
#' @return NewResearch will invisibly return the name of the project.
#'
#' @export
#'
NewResearch <- function(path = "."
                        , RStudio = TRUE
                        , useExistingDirectory = FALSE){

  # If we're not creating a new directory, we must sit under a parent. To get the parent
  # name, we have to temporarily switch to that directory. This allows us to get the base name
  # if the user has provided a relative path.
  if (useExistingDirectory){
    if (!AtLeastOneAlphaNumeric(path)) {
      # oldWD <- setwd(path)
      path <- path.expand(path)
      # setwd(oldWD)
    }

    if (!dir.exists(path)){
      stop ("The path you've entered does not exist. Did you mean to set useExistingDirectory to FALSE?")
    }
  }

  projectName <- ProjectName(path)

  folders <- c("gather", "gathered"
               , "cook", "cooked"
               , "analyze", "analyzed"
               , "present", "presented")

  result <- sapply(file.path(path, folders)
                   , dir.create, showWarnings = FALSE, recursive = TRUE)

  sum(result) == length(folders)

  NewMakefile(path)

  if (RStudio) AddRStudio(path, projectName)

#   if (packrat) AddPackrat()
#

#
#   if (git) AddGit()

  setwd(path)

  invisible(path)
}

NewMakefile <- function(path){

  makefile <- system.file("templates", "Makefile.win", package = "represtools")
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

packageEnv <- new.env()
packageEnv$researchDir <- path.expand("~")
packageEnv$researchName <- ""

OpenResearch <- function(path){

  if (missing(path)){
    invisible(packageEnv$researchDir)
  } else {
    if (packageEnv$ResearchDir != "" |
        packageEnv$researchDir != character(0) &
        packageEnv$researchDir ) {
        # We want to handle the
        warning("")
      }
    packageEnv$researchDir <- path
  }

  invisible(packageEnv$researchDir)

}

