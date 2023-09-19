test_that("Output should be a data frame", {
  input_species <- c("Saurauia lehmannii", "Schinus meyeri", "Ilex colombiana")
  output <- search_mtsta(input_species, max_distance = 0.1)
  expect_s3_class(output, "data.frame")
})

test_that("Output should have correct column names", {
  input_species <- c("Saurauia lehmannii", "Schinus meyeri", "Ilex colombiana")
  output <- search_mtsta(input_species, max_distance = 0.1)
  expected_columns <- c("name_submitted",
                        "name_matched",
                        "accepted_name",
                        "accepted_family",
                        "accepted_genus",
                        "iucn",
                        "distribution",
                        "unsure_distribution",
                        "elevation",
                        "assessor",
                        "description",
                        "taxonomic_status",
                        "distance")
  expect_equal(colnames(output), expected_columns)
})

test_that("Output should have correct number of rows", {
  input_species <- c("Saurauia lehmannii", "Schinus meyeri", "Ilex colombiana")
  output <- search_mtsta(input_species, max_distance = 0.1)
  expected_rows <- length(input_species)
  expect_equal(nrow(output), expected_rows)
})
