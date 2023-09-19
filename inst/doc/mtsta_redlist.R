## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(mtsta)

## ----echo=FALSE---------------------------------------------------------------
summ_df <- tibble::tribble(
     ~Conservation.status, ~tag, ~Number.of.species,
  "Critically Endangered", "CR",                 1L,
             "Endangered", "EN",                42L,
             "Vulnerable", "VU",                27L,
        "Near Threatened", "NT",                20L,
          "Least Concern", "LC",                29L,
         "Data Deficient", "DD",                 8L,
          "Not Evaluated", "NE",                 0L
  )

summ_df |> 
  dplyr::select(1,3) |> 
  janitor::adorn_totals() |> 
  knitr::kable()

## ----summary_2, echo=FALSE, fig.align='center'--------------------------------
summ_2 <- tibble::tribble(
               ~Country, ~CR,  ~EN,  ~VU, ~NT, ~LC, ~DD, ~Subtotal,  ~NE, ~Total,
              "Ecuador",  2L,  36L,  52L,  9L,  5L,  1L,      105L,  61L,   166L,
                 "Peru",  9L,  31L,  15L,  2L,  3L, 10L,       70L,  50L,   120L,
             "Colombia",  4L,   5L,   5L,  2L,  1L,  0L,       17L,  60L,    77L,
              "Bolivia",  0L,   5L,   1L,  0L,  0L,  1L,        7L,  94L,   101L,
            "Argentina",  0L,   0L,   0L,  0L,  0L,  0L,        0L,   3L,     3L,
            "Venezuela",  0L,   0L,   0L,  0L,  0L,  0L,        0L,   0L,     0L,
        "Total endemic", 15L,  77L,  73L, 13L,  9L, 12L,      199L, 268L,   467L,
  "Regional assessment",  1L,  42L,  27L, 20L, 29L,  8L,      127L,   0L,   127L,
          "Total Andes", 16L, 119L, 100L, 33L, 38L, 20L,      326L, 268L,   594L
  )

summ_2 |> 
  knitr::kable()

## ----echo=FALSE---------------------------------------------------------------
summarie_3 <- mtsta::mtsta_distribution |> 
  dplyr::select(accepted_name, distribution) |> 
  dplyr::mutate(distribution = dplyr::case_when(
    stringr::str_detect(distribution, "\\(Bolivia,\\) ") ~ stringr::str_remove(distribution, "\\(Bolivia,\\) "),
    stringr::str_detect(distribution, "\\(Colombia,\\) ") ~ stringr::str_remove(distribution, "\\(Colombia,\\) "),
    stringr::str_detect(distribution, "\\(Colombia\\) \\- ") ~ stringr::str_remove(distribution, "\\(Colombia\\) \\- "),
    stringr::str_detect(distribution, " \\- \\(Peru \\- Venezuela\\)") ~ stringr::str_remove(distribution, " \\- \\(Peru \\- Venezuela\\)"),
    TRUE ~ distribution
  )) |> 
  tidyr::separate_rows(distribution, sep = " - ") |> 
  dplyr::group_by(distribution) |> 
  dplyr::summarise(n_species = dplyr::n_distinct(accepted_name))

## ----echo=FALSE, fig.height=5, fig.width= 8-----------------------------------
summarie_3 |> 
  ggplot2::ggplot(ggplot2::aes(forcats::fct_reorder(distribution, n_species, .desc = TRUE),
                               n_species)) +
  ggplot2::geom_col() +
  ggplot2::labs(y = "Species per country",
                x = "Countries") +
  ggplot2::theme_bw()


