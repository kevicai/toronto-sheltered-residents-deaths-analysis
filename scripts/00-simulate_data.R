#### Preamble ####
# Purpose: Simulates the cleaned data
# Author: Kevin Cai
# Date: 27 September 2024
# Contact: kev.cai@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(3090)

years <- 2007:2023
seasons <- c("Winter", "Spring", "Summer", "Fall")

# create a table
data <- expand.grid(year = years, season = seasons)

# simulate deaths for each year-season combination
data <-
  data |>
  mutate(deaths = rpois(nrow(data), lambda = 5)) |>
  arrange(year)

#### Write_csv
write_csv(data, file = "data/analysis_data/simulated.csv")
