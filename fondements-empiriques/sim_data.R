library(tidyverse)
library(papaja)

set.seed(23655)

n_participants = 500
sim_data <- tibble(
  id = paste0("P", 1:n_participants),
  age = sample(18:65, size = n_participants, replace = TRUE),
  interest_X0 = sample(1:7, size = n_participants, replace = TRUE, prob = c(1,4,4,3,2,2,1)),
  interest_X1 = sample(1:7, size = n_participants, replace = TRUE, prob = c(1,1,1,4,5,5,3))
)

average_data_random <- sim_data |>
  mutate(
    VI = sample(c("X0", "X1"), size = n_participants, replace = TRUE),
  ) |>
  group_by(VI) |>
  summarise(
    n = n(),
    age = collapse_m_sd(mean(age), sd(age)),
    interest_X0 = collapse_m_sd(mean(interest_X0), sd(interest_X0)),
    interest_X1 = collapse_m_sd(mean(interest_X1), sd(interest_X1)),
  )

average_data_preference <- sim_data |>
  mutate(
    VI = if_else(interest_X0 >= interest_X1, "X0", "X1"),
  ) |>
  group_by(VI) |>
  summarise(
    n = n(),
    age = collapse_m_sd(mean(age), sd(age)),
    interest_X0 = collapse_m_sd(mean(interest_X0), sd(interest_X0)),
    interest_X1 = collapse_m_sd(mean(interest_X1), sd(interest_X1)),
  )
