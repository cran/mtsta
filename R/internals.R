#' Get Plant Distribution from POWO
#'
#' This function retrieves the distribution data for a list of plant species
#' from the Plants of the World Online (POWO) database.
#'
#' @param splist Character vector of plant species names for which distribution
#' data is to be retrieved.
#'
#' @return A data frame with the following columns:
#' \describe{
#'   \item{area_code_l3}{Character vector with the code representing the country or
#'   region where the species occurs.}
#'   \item{occurrence_type}{Character vector indicating the occurrence type of the species,
#'   which can be "native", "introduced", "location_doubtful", or "extinct".}
#'   \item{country}{Character vector with the full name of the country or region where the species occurs.}
#'   \item{level_3_name}{Character vector with the name of the level 3 area where the species occurs.}
#' }
#'
#' @details The function first determines the occurrence type (native, introduced,
#' location doubtful, or extinct) for each species based on the provided information
#' about the species' introduction status, extinction status, and location doubtfulness.
#' It then retrieves the corresponding country or region code for each species from the
#' Plants of the World Online (POWO) database. The retrieved data is then merged with the
#' World Geographical Scheme for Recording Plant Distributions (WGSRPD) mapping to obtain
#' full country or region names and level 3 area names where each species occurs.
#'
#'
#' @keywords internal
#' get_distribution_from_powo <- function(splist){
#'
#'   #####
#'   determine_occurrence_type_ <- function(introduced, extinct, location_doubtful) {
#'
#'     if (any(introduced + extinct + location_doubtful == 0)) {
#'       return("native")
#'     }
#'
#'     if (any(introduced == 1)) {
#'       return("introduced")
#'     }
#'
#'     if (any(location_doubtful == 1)) {
#'       return("location_doubtful")
#'     }
#'
#'     return("extinct")
#'   }
#'   #####
#'
#'   # get plant name id
#'   plant_id <-
#'     rWCVPdata::wcvp_names |>
#'     filter(taxon_name == splist) |>
#'     filter(taxon_status == "Accepted") |>
#'     select(taxon_name, plant_name_id) |>
#'     pull(plant_name_id)
#'   # get country name level 3 code
#'   country_names <-
#'     rWCVPdata::wcvp_distributions |>
#'     filter(plant_name_id %in%  plant_id) |>
#'     group_by(area_code_l3) %>%
#'     summarise(
#'       occurrence_type = determine_occurrence_type_(
#'         .data$introduced, .data$extinct, .data$location_doubtful
#'       ),
#'       .groups="drop"
#'     )
#'
#'   full_country_name <- rWCVP::wgsrpd_mapping |>
#'     dplyr::filter(LEVEL3_COD %in% unique(country_names$area_code_l3))
#'
#'   output <-
#'     country_names |>
#'     left_join(full_country_name,
#'               by = c("area_code_l3" = "LEVEL3_COD")) |>
#'     select(area_code_l3, occurrence_type,
#'            country = COUNTRY,
#'            level_3_name = LEVEL3_NAM)
#'   return(output)
#' }
