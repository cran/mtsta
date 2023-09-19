
# Test 1: Basic test to check if the function runs without errors
test_that("search_mtsta_distribution runs without errors", {
  # Sample data
  species_list <- c("Escallonia mirtilloydes", "Ilex rimbachii", "Saurauia lehmannii")

  # Test function execution without errors
  expect_no_error(search_mtsta_distribution(species_list))
})

# Test 2: Check if the output is a data frame
test_that("search_mtsta_distribution returns a data frame", {
  # Sample data
  species_list <- c("Escallonia mirtilloydes", "Ilex rimbachii", "Saurauia lehmannii")

  # Execute the function
  result <- search_mtsta_distribution(species_list)

  # Test if the output is a data frame
  expect_s3_class(result, "data.frame")
})

# Test 3: Check if the output data frame has the correct columns
test_that("search_mtsta_distribution returns data frame with correct columns", {
  # Sample data
  species_list <- c("Escallonia mirtilloydes", "Ilex rimbachii", "Saurauia lehmannii")

  # Execute the function
  result <- search_mtsta_distribution(species_list)

  # Expected column names
  expected_columns <- c("name_submitted", "name_matched", "accepted_name",
                        "distribution_wcvp", "taxonomic_status", "distance")

  # Test if the output data frame has the correct columns
  expect_identical(colnames(result), expected_columns)
})

# Test 4: Check if the Levenshtein distance is within the specified max_distance
test_that("search_mtsta_distribution returns Levenshtein distance within max_distance", {
  # Sample data
  species_list <- c("Escallonia mirtilloydes", "Ilex rimbachii", "Saurauia lehmannii")
  max_distance <- ceiling(nchar(species_list) * 0.2)
  # Execute the function
  result <- search_mtsta_distribution(species_list, max_distance = 0.2)
  # Get the Levenshtein distance column
  levenshtein_distances <- result$distance
  # Test if all Levenshtein distances are within the specified max_distance
  expect_true(all(levenshtein_distances <= max_distance))
})
