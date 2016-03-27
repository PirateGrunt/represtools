library(represtools)
context("Objects")

test_that("Objects", {

  mojo <- 1
  gonzo <- "Monkey"
  lstMyObjs <- represtools::NamesToObjects(c("mojo", "gonzo"))

  testthat::expect_true(length(lstMyObjs) == 2)
  testthat::expect_named(lstMyObjs)
  testthat::expect_named(lstMyObjs, c("mojo", "gonzo"))
  # testthat::expect_equal(lstMyObjs$mojo, mojo)
  # testthat::expect_equal(lstMyObjs$gonzo, gonzo)

})
