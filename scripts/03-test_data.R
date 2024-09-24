#### Preamble ####
# Purpose: Tests cleaned Toronto deaths of shelter residents data
# Author: Kevin Cai
# Date: 27 September 2024
# Contact: kev.cai@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R, 02-data_cleaning.R
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)

#### Test data ####
cleaned <- read.csv("data/analysis_data/cleaned_data.csv")

# test for NAs
print("No NAs:")
is.na(data$deaths) |> min() <= 0

# test for for negative numbers
print("No negative numbers:")
data$deaths |> min() <= 0

# test for correct columns
print("Correct columns:")
data |> colnames() == c("year", "season", "deaths")

# test each season has same occurence
print("Each season has the same occurrence:")
season_counts <- cleaned %>%
    group_by(season) %>%
    summarise(count = n(), .groups = "drop")
n_distinct(season_counts$count) == 1

## test cleaned data
# test for correct number of total seasons
print("Correct number of rows (seasons):")
nrow(cleaned) == 4 * (2024 - 2007)

# test correct number of each season
print("17 occurence of each season:")
season_counts <- cleaned %>%
    group_by(season) %>%
    summarise(count = n(), .groups = "drop")
season_counts$count == 17
