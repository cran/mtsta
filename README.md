
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mtsta <a href='https://github.com/PaulESantos/mtsta'><img src='man/figures/mtstarl.png' align="right" height="220" width="150" /></a>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![CRAN
status](https://www.r-pkg.org/badges/version/mtsta)](https://CRAN.R-project.org/package=mtsta)
[![](http://cranlogs.r-pkg.org/badges/grand-total/mtsta?color=green)](https://cran.r-project.org/package=mtsta)
[![](http://cranlogs.r-pkg.org/badges/last-week/mtsta?color=green)](https://cran.r-project.org/package=mtsta)

[![R-CMD-check](https://github.com/PaulESantos/mtsta/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/PaulESantos/mtsta/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/PaulESantos/mtsta/branch/main/graph/badge.svg)](https://app.codecov.io/gh/PaulESantos/mtsta?branch=main)
<!-- badges: end -->

## Overview

The `mtsta` package provides a powerful tool for searching and matching
species names in the montane forests of the Tropical Andes region. It
allows users to input a list of species names and find the closest
matching names from a curated base data of montane tree species in the
region. The matching process takes into account both exact matches and
fuzzy matches based on a user-defined maximum distance threshold.

## Installation

You can install the `mtsta` package from GitHub using:

``` r
pak::pak("PaulESantos/mtsta")
```

## Usage

To use the `mtsta` package, simply load it and call the `search_mtsta()`
function with your list of species names as the input:

``` r
library(mtsta)

# Example species list
splist <- c("Aphelandra acantasa",
            "Saurauia lehmani",
            "Saurauia bullosaa",
            "Schinus meyerii",
            "Ilex colombiana",
            "Ilex rimbachii",
            "Ilex scopulorum")

mtsta::search_mtsta(splist, max_distance = 0.1) |> 
  dplyr::select(name_submitted, name_matched, accepted_name, accepted_family,
                taxonomic_status, distance) |> 
  tibble::as_tibble()
#> # A tibble: 7 × 6
#>   name_submitted     name_matched accepted_name accepted_family taxonomic_status
#>   <chr>              <chr>        <chr>         <chr>           <chr>           
#> 1 Aphelandra acanta… nill         nill          nill            nill            
#> 2 Saurauia lehmani   Saurauia le… Saurauia leh… Actinidiaceae   Accepted        
#> 3 Saurauia bullosaa  Saurauia bu… Saurauia bul… Actinidiaceae   Accepted        
#> 4 Schinus meyerii    Schinus mey… Schinus meye… Anacardiaceae   Accepted        
#> 5 Ilex colombiana    Ilex colomb… Ilex colombi… Aquifoliaceae   Accepted        
#> 6 Ilex rimbachii     Ilex rimbac… Ilex rimbach… Aquifoliaceae   Accepted        
#> 7 Ilex scopulorum    Ilex scopul… Ilex scopulo… Aquifoliaceae   Accepted        
#> # ℹ 1 more variable: distance <chr>
```

- Species distribution

``` r

mtsta::search_mtsta_distribution(splist = splist) |> 
  tibble::as_tibble()
#> # A tibble: 7 × 6
#>   name_submitted   name_matched accepted_name distribution_wcvp taxonomic_status
#>   <chr>            <chr>        <chr>         <chr>             <chr>           
#> 1 Aphelandra acan… nill         nill          nill              nill            
#> 2 Saurauia lehmani Saurauia le… Saurauia leh… Colombia - Ecuad… Accepted        
#> 3 Saurauia bullos… Saurauia bu… Saurauia bul… Colombia - Ecuad… Accepted        
#> 4 Schinus meyerii  Schinus mey… Schinus meye… Argentina - Boli… Accepted        
#> 5 Ilex colombiana  Ilex colomb… Ilex colombi… Colombia - Ecuad… Accepted        
#> 6 Ilex rimbachii   Ilex rimbac… Ilex rimbach… Ecuador - Peru    Accepted        
#> 7 Ilex scopulorum  Ilex scopul… Ilex scopulo… Ecuador - Peru -… Accepted        
#> # ℹ 1 more variable: distance <chr>
```

## Description

The `search_mtsta()` and `search_mtsta_distribution()` functions takes a
list of species names (`splist`) and a maximum distance value
(`max_distance`) as input. It performs fuzzy matching and exact matching
to find the closest matching species names in the curated base data of
montane tree species in the Tropical Andes region. The output is a data
frame with data for the submitted species name. If no match is found
within the specified maximum distance, the result will show `"nill"` for
the matched species name.

## Acknowledgments

A team of Regional Red List of Montane Tree Species of the Tropical
Andes (2014). The research was carried out by Natalia Tejedor Garavito
from Bournemouth University in collaboration with BGCI and over 20
regional experts. Source data
[here](https://www.bgci.org/resources/bgci-tools-and-resources/the-regional-red-list-of-montane-tree-species-of-the-tropical-andes/)

The curated base data used in this package was reviewed and validated
using the [Taxonomic Name Resolution Service
TNRS](https://tnrs.biendata.org/). The TNRS is a computer-assisted tool
for standardizing plant scientific names, correcting spelling errors,
and resolving out-of-date names to the current accepted names. We are
grateful for the contribution of the TNRS in validating the accuracy of
the base data.
