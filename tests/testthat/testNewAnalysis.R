library(represtools)
context("New analysis")

test_that("All directories are created", {

  oldWD <- setwd(tempdir())
  represtools::NewAnalysis("Testing")

  testthat::expect_true(file.exists("./Testing/gather"))
  testthat::expect_true(file.exists("./Testing/gathered"))
  testthat::expect_true(file.exists("./Testing/cook"))
  testthat::expect_true(file.exists("./Testing/cooked"))
  testthat::expect_true(file.exists("./Testing/analyze"))
  testthat::expect_true(file.exists("./Testing/analyzed"))
  testthat::expect_true(file.exists("./Testing/publish"))
  testthat::expect_true(file.exists("./Testing/published"))

  testthat::expect_true(file.info("./Testing/gather")$isdir)
  testthat::expect_true(file.info("./Testing/gathered")$isdir)
  testthat::expect_true(file.info("./Testing/cook")$isdir)
  testthat::expect_true(file.info("./Testing/cooked")$isdir)
  testthat::expect_true(file.info("./Testing/analyze")$isdir)
  testthat::expect_true(file.info("./Testing/analyzed")$isdir)
  testthat::expect_true(file.info("./Testing/publish")$isdir)
  testthat::expect_true(file.info("./Testing/published")$isdir)

  unlink("Testing", recursive = TRUE)
  setwd(oldWD)

})

test_that("Can't create analysis under root", {

  f <- function(){
    NewAnalysis(path = "c:/", createNewDirectory = FALSE)
  }

  expect_error(f())
})

test_that("Makefile exists", {
  oldWD <- setwd(tempdir())
  represtools::NewAnalysis("Testing")

  testthat::expect_true(file.exists("./Testing/Makefile"))
  testthat::expect_false(file.info("./Testing/Makefile")$isdir)

  unlink("Testing", recursive = TRUE)
  setwd(oldWD)
})
