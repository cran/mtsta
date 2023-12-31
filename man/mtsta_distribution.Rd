% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mtstadata.R
\docType{data}
\name{mtsta_distribution}
\alias{mtsta_distribution}
\title{mtsta_distribution: Distribution Data for Species in mtsta_tab}
\format{
A tibble
\describe{
\item{accepted_name}{Character vector with the current accepted name of the species.}
\item{distribution}{Character vector indicating the distribution range of the species.}
\item{distribution_wcvp}{Character vector indicating the distribution according to the World
Checklist of Vascular Plants (\href{https://powo.science.kew.org/}{WCVP}).}
\item{taxonomic_status}{Character vector indicating the taxonomic status of the species of the submitted name (e.g., "Accepted").}
}
}
\usage{
mtsta_distribution
}
\description{
This dataset contains distribution data for species included in A Regional
Red List of Montane Tree Species of the Tropical Andes - 2014.
It provides information on the current accepted names, distribution range, and
taxonomic status for each species. The data is original diatribution data and the
updated distribution information for the included species.
}
\details{
The dataset contains information on the distribution of species in A Regional
Red List of Montane Tree Species of the Tropical Andes - 2014.
The distribution data includes the geographical range of each species, including countries where
the species can be found.
}
\examples{
# Load the mtsta_distribution dataset
data("mtsta_distribution")
}
\keyword{datasets}
