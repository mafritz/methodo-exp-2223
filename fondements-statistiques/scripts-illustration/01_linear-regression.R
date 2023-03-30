set.seed(6167)
library(tidyverse)
library(broom)
library(see)
library(effectsize)
library(report)
library(scales)
library(equatiomatic)
library(afex)
library(ids)
library(papaja)
theme_set(theme_apa(box = TRUE))


# Principe de base de la regression lineaire ------------------------------

n_points_lm = 9

data_lm <- tibble(
  x = rnorm(n_points_lm, 100, 40),
  y = x + rnorm(n_points_lm, 0, 15)
) |> add_row(
  x = 130,
  y = 210
) |> mutate(
  x = rescale(x, to = c(10, 20)),
  y = rescale(y, to = c(50, 200))
)

model_lm <- lm(y ~ x, data_lm)
summary(model_lm)


data_lm_plus <- augment(model_lm) |>
  transmute(
    i = 1:nrow(data_lm),
    x = x,
    y = y,
    .fitted = .fitted,
    diff = y - .fitted,
    diff_squared = (y - .fitted)^2
  )

data_lm_mean <- data_lm |>
  transmute(
    i = 1:nrow(data_lm),
    x = x,
    y = y,
    mean_y = mean(data_lm$y),
    diff = y - mean_y,
    diff_squared = (y - mean_y)^2
  )

equation_lm <- equatiomatic::extract_eq(model_lm, intercept = "beta")
equation_lm_coeff <- equatiomatic::extract_eq(model_lm, use_coefs = TRUE, intercept = "beta")

graph_lm <- ggplot(data_lm_plus, aes(x = x, y = y)) +
  geom_smooth(method = "lm", se = FALSE, formula = y ~ x, color = "blue", linewidth = 1) +
  geom_segment(aes(xend = x, yend = .fitted), color = "#970000", size = 1) +
  geom_point(size = 3, color = "black") +
  labs(x = "X", y = "Y") +
  NULL
