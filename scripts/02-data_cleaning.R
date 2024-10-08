#### Preamble ####
# Purpose: Cleans the raw Toronto deaths of shelter residents data
# Author: Kevin Cai
# Date: 27 September 2024
# Contact: kev.cai@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)

# Returns the season given month in 3 letter string
get_season <- function(month) {
  if (month == "Jan" || month == "Feb") {
    return("Winter")
  } else if (month == "Mar" || month == "Apr" || month == "May") {
    return("Spring")
  } else if (month == "Jun" || month == "Jul" || month == "Aug") {
    return("Summer")
  } else {
    return("Fall")
  }
}

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

filtered_data <-
  raw_data |>
  janitor::clean_names() |>
  # Filter unwanted months to ensure equal number of seasons (17)
  filter(
    !(
      (year == 2007 & month %in% c("Jan", "Feb")) |
        (year == 2024 & month %in% c("Mar", "Apr", "May", "Jun", "Jul", "Aug"))
    )
  )

cleaned_data <- 
  filtered_data |>
  select(year, month, deaths = total_decedents)

grouped_data <-
  cleaned_data |>
  mutate(
    season = ifelse(month == "Dec", "Winter", sapply(month, get_season)),
    # Treat Dec as winter of next year
    year = ifelse((month == "Jan" | month == "Feb"), year - 1, year)
  ) |>
  group_by(year, season) |>
  # Sum deaths of all months in a season
  summarise(deaths = sum(deaths))

# Create a summary of data 
summarized_data <-
  grouped_data |>
  group_by(season) |>
  summarize(sum = sum(deaths), mean = round(mean(deaths), 2))
# summarized_data 

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/cleaned_data.csv")
write_csv(grouped_data, "data/analysis_data/grouped_data.csv")
write_csv(summarized_data, "data/analysis_data/summarized_data.csv")
