test_that("serial integer primary keys are produced", {
  expect_equal(serial_id("count"), 1)
  expect_equal(serial_id("count"), 2)
  expect_equal(serial_id("count"), 3)
  clean_filedocumentr("count")
})

test_that("library initiation works", {
  # add entries with similar number of vars
  expect_snapshot(
    library_entry("my-library", foo = 1, bar = "a", baz = "b")
    )
  expect_snapshot(
    library_entry("my-library", foo = 2, bar = "a", baz = "b")
    )
  expect_snapshot(
    library_entry("my-library", foo = 3, bar = "a", baz = "b")
    )
  # complete original library to include a new var
  expect_snapshot(
    add_variable(
      readRDS("my-library/my-library.RDS"),
      c(foo = 3, bar = "a", baz = "b", fruit = "Apple")
      )
    )
  # add new entry with additional var to library
  expect_snapshot(
    library_entry("my-library",foo = 3, bar = "a", baz = "b", fruit = "Apple")
    )
  clean_filedocumentr("my-library")
})
