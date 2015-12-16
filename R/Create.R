CreateFolders <- function(path){
  folders <- c("gather", "raw"
               , "process", "processed"
               , "analyze", "analyzed"
               , "present")

  result <- sapply(file.path(path, folders)
                   , dir.create, showWarnings = FALSE, recursive = TRUE)

  sum(result) == length(folders)
}

CreateMakefile <- function(path){

}

NewAnalysis <- function(path = "."){
  CreateFolders(path)
  CreateMakefile(path)
}
