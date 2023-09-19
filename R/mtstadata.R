#' @name mtsta_tab
#' @docType data
#' @title Montane Tree Species of the Tropical Andes - Base Data
#' @description
#' This is the curated base data of montane tree species found in the Tropical Andes region. The data is stored as a tibble with 132 rows and 11 columns. Each row represents a species and contains information such as the species name, accepted name, accepted family, accepted genus, IUCN status, distribution, elevation range, assessor, description, and taxonomic status.
#'
#' @details
#' The columns in the base data tibble are as follows:
#'
#' - `species_name`: The scientific name of the species.
#' - `accepted_name`: The currently accepted name for the species.
#' - `accepted_family`: The family to which the species belongs.
#' - `accepted_genus`: The genus to which the species belongs.
#' - `taxonomic_status`: The taxonomic status of the species.
#' - `iucn`: The conservation status of the species according to the IUCN Red List Categories.
#' - `distribution`: The distribution range of the species.
#' - `unsure_distribution`: Information about the uncertainty in the distribution data.
#' - `elevation`: The elevation range where the species is found.
#' - `assessor`: The person or group responsible for assessing the species.
#' - `description`: Additional information or description of the species.
#'
#'
#' The base species list used in the mtsta package has been carefully reviewed and
#' validated with the assistance of the Taxonomic Name Resolution Service (TNRS).
#' By utilizing the TNRS, the base species list in the mtsta package guarantees
#' accuracy and consistency in the representation of species names, enhancing the
#' reliability of the package's functionalities.
#'
#'
#' @format
#' A tibble with 132 rows and 11 columns.
#'
#' @source
#' The data for this package was obtained from [A Regional Red List of Montane Tree Species of the Tropical Andes - 2014](https://www.bgci.org/resources/bgci-tools-and-resources/the-regional-red-list-of-montane-tree-species-of-the-tropical-andes).
#'
#' @seealso
#' Use `search_mtsta()` function to search and match species names using this base data.
#'
#' @keywords datasets
#' @examples
#' data("mtsta_tab")
#'
"mtsta_tab"


#' mtsta_distribution: Distribution Data for Species in mtsta_tab
#'
#' This dataset contains distribution data for species included in A Regional
#' Red List of Montane Tree Species of the Tropical Andes - 2014.
#' It provides information on the current accepted names, distribution range, and
#' taxonomic status for each species. The data is original diatribution data and the
#' updated distribution information for the included species.
#'
#' @format A tibble
#' \describe{
#'   \item{accepted_name}{Character vector with the current accepted name of the species.}
#'   \item{distribution}{Character vector indicating the distribution range of the species.}
#'   \item{distribution_wcvp}{Character vector indicating the distribution according to the World
#'   Checklist of Vascular Plants ([WCVP](https://powo.science.kew.org/)).}
#'   \item{taxonomic_status}{Character vector indicating the taxonomic status of the species of the submitted name (e.g., "Accepted").}
#' }
#'
#' @details The dataset contains information on the distribution of species in A Regional
#' Red List of Montane Tree Species of the Tropical Andes - 2014.
#' The distribution data includes the geographical range of each species, including countries where
#' the species can be found.
#'
#'
#' @name mtsta_distribution
#' @docType data
#' @keywords datasets
#' @examples
#' # Load the mtsta_distribution dataset
#' data("mtsta_distribution")
"mtsta_distribution"
