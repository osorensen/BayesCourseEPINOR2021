library(tidyverse)

# Birthweight data downloaded from Wolfram Research, "Sample Data: Birth Weight Risk" from the Wolfram Data Repository (2016) https://doi.org/10.24097/wolfram.85529.data

dat <- read_csv("data/Sample-Data-Birth-Weight-Risk.csv")

dat %>% 
  select(Low, Age, LWT, Smoker, Hypertension) %>% 
  mutate(
    across(c(Age, LWT), ~ as.numeric(str_extract(., "[:digit:]+"))),
    LWT = 0.45359237 * LWT,
    Low = as.integer(Low)
  ) %>% 
  saveRDS("data/bwt.rds")
