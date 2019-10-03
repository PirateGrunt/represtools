library(represtools)
context("New research")

test_that("All directories are created", {

  oldWD <- setwd(tempdir())
  represtools::NewResearch("Testing")

  testthat::expect_true(file.exists("./gather"))
  testthat::expect_true(file.exists("./gathered"))
  testthat::expect_true(file.exists("./cook"))
  testthat::expect_true(file.exists("./cooked"))
  testthat::expect_true(file.exists("./analyze"))
  testthat::expect_true(file.exists("./analyzed"))
  testthat::expect_true(file.exists("./present"))
  testthat::expect_true(file.exists("./presented"))

  testthat::expect_true(file.info("./gather")$isdir)
  testthat::expect_true(file.info("./gathered")$isdir)
  testthat::expect_true(file.info("./cook")$isdir)
  testthat::expect_true(file.info("./cooked")$isdir)
  testthat::expect_true(file.info("./analyze")$isdir)
  testthat::expect_true(file.info("./analyzed")$isdir)
  testthat::expect_true(file.info("./present")$isdir)
  testthat::expect_true(file.info("./presented")$isdir)

  unlink("Testing", recursive = TRUE)
  setwd(oldWD)

})

test_that("Can't create analysis under root", {

  f <- function(){
    NewResearch(path = "c:/", createNewDirectory = FALSE)
  }

  expect_error(f())
})

test_that("Makefile exists", {
  oldWD <- setwd(tempdir())
  represtools::NewResearch("Testing")

  testthat::expect_true(file.exists("./Makefile"))
  testthat::expect_false(file.info("./Makefile")$isdir)

  unlink("Testing", recursive = TRUE)
  setwd(oldWD)
})

test_that("RProj exists", {
  oldWD <- setwd(tempdir())
  represtools::NewResearch("Testing")

  testthat::expect_true(file.exists("./Testing.Rproj"))

  unlink("Testing", recursive = TRUE)
  setwd(oldWD)
})
