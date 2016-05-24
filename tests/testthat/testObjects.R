library(represtools)
context("Objects")

test_that("List", {
  myEnv <- new.env()
  myEnv$mojo <- 1
  myEnv$gonzo <- "Monkey"

  lstObjects <- represtools::ListObjects("^m", myEnv)

  testthat::expect_equal(length(lstObjects), 1)
  testthat::expect_equal(lstObjects[[1]], "mojo")

})

test_that("Names", {

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

test_that("Describe", {
  mojo <- 1
  gonzo <- "abc"

  testthat::expect_output(represtools::DescribeObjects(list(mojo), list(str))
                          , "num 1")

  testthat::expect_output(represtools::DescribeObjects(list(mojo), str)
                          , "num 1")

  testthat::expect_output(represtools::DescribeObjects(list(mojo), "str")
                          , "num 1")

  testthat::expect_output(represtools::DescribeObjects(mojo, "str")
                          , "num 1")

  expect_error(represtools::DescribeObjects(list(mojo, gonzo), str), NA)

  # myEnv <- new.env()
  # myEnv$mojo <- 1
  # myEnv$gonzo <- "Monkey"
  #
  # lst <- represtools::ListObjects(c("^m", "^g"), myEnv)
  # lst <- represtools::NamesToObjects(lst, myEnv)
  #
  # lapply(lst, str)
  #
  # mojoStr <- represtools::DescribeObjects(lst, str, myEnv)
  #
  # testthat::expect_equal(mojoStr, "num 1")

})
