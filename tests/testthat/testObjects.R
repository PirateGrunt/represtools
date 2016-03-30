library(represtools)
context("Objects")

test_that("Objects", {

  myEnv <- new.env()
  myEnv$mojo <- 1
  myEnv$gonzo <- "Monkey"
  lstMyObjs <- represtools::NamesToObjects(c("mojo", "gonzo"), myEnv)

  testthat::expect_true(length(lstMyObjs) == 2)
  testthat::expect_named(lstMyObjs)
  testthat::expect_named(lstMyObjs, c("mojo", "gonzo"))
  # testthat::expect_equal(lstMyObjs$mojo, mojo)
  # testthat::expect_equal(lstMyObjs$gonzo, gonzo)

})

test_that("Load", {

  mojo <- 1
  gonzo <- "abc"

  myfile <- tempfile("testLoad")

  save(file = myfile
       , gonzo, mojo)

  loadedObjects <- represtools::LoadObjects(loadFiles = myfile)

  testthat::expect_equal(length(loadedObjects), 2)

  myfile2 <- tempfile("testLoad2")

  cazart <- data.frame(rnorm(500))
  save(file = myfile2, cazart)

  loadFiles <- c(myfile, myfile2)

  loadedObjects <- represtools::LoadObjects(loadFiles = loadFiles)

  testthat::expect_equal(length(loadedObjects), 3)

  unlink(myfile)
  unlink(myfile2)

})
