#' Search Species Distribution of A Regional Red List of Montane Tree Species of the Tropical Andes
#'
#' This function searches the Montane Tree Species of the Tropical Andes distribution
#' database for a list of submitted species names and returns their distribution information.
#' The search allows for approximate string matching within a given maximum distance.
#'
#' @param splist Character vector of submitted plant species names for which distribution
#' data is to be searched.
#'
#' @param max_distance Numeric value representing the maximum allowed distance for approximate
#' string matching. The default value is 0.1.
#'
#' @param typedf "main" return a selected columns in from mtsta_distribution
#'               "full" return all data
#'
#' @return A data frame with the following columns:
#' \describe{
#'   \item{name_submitted}{Character vector with the submitted species names.}
#'   \item{name_matched}{Character vector with the matched species names in the database.}
#'   \item{accepted_name}{Character vector with the accepted names of the matched species.}
#'   \item{distribution}{Character vector with the distribution of the matched species.}
#'   \item{unsure_distribution}{Character vector with information about unsure distribution (if available).}
#'   \item{distribution_wcvp}{Character vector with the distribution from the World Check-list
#'   of Vascular Plants (WCVP) database for the matched species.}
#'   \item{taxonomic_status}{Character vector indicating the taxonomic status of the matched species.}
#'   \item{distance}{Numeric vector with the Levenshtein distance between submitted and matched species names.}
#' }
#'
#' @details The function uses approximate string matching with a maximum distance specified by
#' the \code{max_distance} argument. It searches the `mtsta` distribution database for submitted
#' species names that match the provided names within the given distance. The function then
#' retrieves distribution information, including the accepted name, distribution region, unsure
#' distribution (if available), distribution from the World Check-list of Vascular Plants (WCVP),
#' taxonomic status, and the Levenshtein distance between submitted and matched species names.
#'
#' @seealso \code{\link[mtsta]{mtsta_distribution}}
#'
#'
#' @examples
#' # Example usage of search_mtsta_distribution function
#' species_list <- c("Escallonia mirtilloydes", "Ilex rimbachii", "Saurauia lehmannii")
#' distribution_data <- search_mtsta_distribution(species_list, max_distance = 0.2)
#' print(distribution_data)
#'
#' @export
search_mtsta_distribution <- function(splist, max_distance = 0.1, typedf = "main") {

  # Defensive function here, check for user input errors
  if (is.factor(splist)) {
    splist <- as.character(splist)
  }
  # Fix species name
  splist_std <- standardize_names(splist)
  # create an output data container
  output_matrix <- matrix(nrow = length(splist_std), ncol = 8)
  colnames(output_matrix) <- c("name_submitted",
                               "name_matched",
                               "accepted_name",
                               "distribution",
                               "unsure_distribution",
                               "distribution_wcvp",
                               "taxonomic_status",
                               "distance")
  # loop code to find the matching string

  for (i in seq_along(splist_std)) {
    # Standardise max distance value
    if (max_distance < 1 & max_distance > 0) {
      max_distance_fixed <- ceiling(nchar(splist_std[i]) * max_distance)
    } else {
      max_distance_fixed <- max_distance
    }
    # fuzzy and exact match
    matches <- agrep(splist_std[i],
                     mtsta::mtsta_distribution$species_name, # base data column
                     max.distance = max_distance_fixed,
                     value = TRUE)
    # check non matching result
    if (length(matches) == 0) {
      matches1 <- "nill"
      dis_val_1 <- ""
    } else { # match result
      dis_value <- as.numeric(utils::adist(splist_std[i], matches))
      matches1 <- matches[dis_value <= max_distance_fixed]
      dis_val_1 <- dis_value[dis_value <= max_distance_fixed]
    }
    # build an output result from mtsta data
    if (matches1 == "nill") {
      row_data <- rep("nill", 6)
    } else {
      row_data <- as.matrix(mtsta::mtsta_distribution[mtsta::mtsta_distribution$species_name == matches1,])

    }
    output_matrix[i, ] <- c(splist_std[i], row_data, dis_val_1)
  }
output <- as.data.frame(output_matrix)

if(typedf == "main"){
  return(output[,c(1,2,3,6, 7, 8)])
}
else if(typedf == "full"){
  return(output)
}
}
