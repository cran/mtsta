#' Search for Matching Species Names in the Red List of Montane Tree Species of
#' the Tropical Andes
#'
#' This function searches for matching species names in the Red List of Montane
#' Tree Species of the Tropical Andes (`mtsta` package) based on a provided
#' list of species names. The function performs approximate matching using the
#' Levenshtein distance algorithm to find similar names within a specified
#' maximum distance.
#'
#' @param splist A character vector containing the species names to be matched.
#' @param max_distance  The distance used is a generalized Levenshtein distance that indicates
#' the total number of insertions, deletions, and substitutions allowed to
#' match the two names. It can be expressed as an integer or as the fraction of
#' the binomial name.
#' A value between 0 and 1 will be treated as a percentage of the string length.
#' A value greater than 1 will be treated as an absolute number of allowed changes.
#' For example, a name with length 10, and a max_distance = 0.1, allow only one
#' change (insertion, deletion, or substitution). A max_distance = 2, allows two changes.
#' @param ... Additional arguments (currently unused).
#'
#' @return A data frame with the following columns:
#' \itemize{
#'   \item \code{name_submitted}: The submitted species names.
#'   \item \code{name_matched}: The matched species names from the mtsta data.
#'   \item \code{accepted_name}: The accepted scientific name of the matched species.
#'   \item \code{accepted_family}: The accepted family name of the matched species.
#'   \item \code{accepted_genus}: The accepted genus name of the matched species.
#'   \item \code{taxonomic_status}: The taxonomic status of the matched species.
#'   \item \code{iucn}: The conservation status of the matched species according to the IUCN Red List Categories.
#'   \item \code{distribution}: The distribution range of the matched species.
#'   \item \code{unsure_distribution}: Information about the uncertainty in the distribution data.
#'   \item \code{elevation}: The elevation range where the species is found.
#'   \item \code{assessor}: The person or group responsible for assessing the species.
#'   \item \code{description}: Additional information or description of the species.
#'   \item \code{distance}: The Levenshtein distance between the submitted name and the matched name.
#' }
#' If no match is found, the \code{name_matched} column will contain "nill",
#' and the other columns will be empty.
#'
#' @examples
#' # Assuming you have the mtsta package loaded with the necessary data
#' search_result <- search_mtsta(c("Aphelandra acantasa",
#'                                 "Saurauia lehmani",
#'                                 "Saurauia bullosaa",
#'                                 "Schinus meyerii",
#'                                 "Ilex colombiana",
#'                                 "Ilex rimbachii",
#'                                 "Ilex scopulorum"),
#'                               max_distance = 0.1)
#'
#' @seealso
#' \code{mtsta::mtsta_tab}
#'
#'
#' @export
search_mtsta <- function(splist, max_distance = 0.1, ...) {

  # Defensive function here, check for user input errors
  if (is.factor(splist)) {
    splist <- as.character(splist)
  }
  # Fix species name
  splist_std <- standardize_names(splist)

  # create an output data container
  output_matrix <- matrix(nrow = length(splist_std), ncol = 13)
  colnames(output_matrix) <- c("name_submitted",
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
                     mtsta::mtsta_tab$species_name, # base data column
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
      row_data <- rep("nill", 11)
    } else {
      row_data <- as.matrix(mtsta::mtsta_tab[mtsta::mtsta_tab$species_name == matches1,])
    }
    output_matrix[i, ] <- c(splist_std[i], row_data, dis_val_1)
  }

  return(as.data.frame(output_matrix))
}
