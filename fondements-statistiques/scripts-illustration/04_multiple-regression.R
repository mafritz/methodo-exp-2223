set.seed(617)
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

n_points_lm_multiple = 200

data_lm_multiple <- tibble(
  x = rnorm(n_points_lm_multiple, 100, 40),
  w = rnorm(n_points_lm_multiple, 100, 30),
  z = sample(c(1, 2, 3), n_points_lm_multiple, replace = TRUE),
  y = x + rnorm(n_points_lm_multiple, 0, 15) + rnorm(n_points_lm_multiple, z * 10, 15)
) |> mutate(
  x = rescale(x, to = c(0, 20)),
  w = rescale(w, to = c(0, 20)),
  y = rescale(y, to = c(0, 100)),
  z = factor(z, labels = c("Faible", "Moyenne", "Forte"))
)

model_lm_multiple <- lm(y ~ x + w + z, data_lm_multiple)
summary(model_lm_multiple)

data_lm_multiple_plus <- augment(model_lm_multiple)

equation_lm_multiple <- equatiomatic::extract_eq(model_lm_multiple, intercept = "beta")
equation_lm_multiple_coeff <- equatiomatic::extract_eq(model_lm_multiple, use_coefs = TRUE, intercept = "beta")


# Create a scatter plot with a linear regression line using ggplot2
graph_lm_multiple <- ggplot(data_lm_multiple_plus, aes(x = x, y = y, color = z)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, linetype = "solid") +
  geom_segment(aes(xend = x, yend = .fitted, color = z, group = z), alpha = 0.1, linewidth = 1) +
  scale_colour_discrete() +
  labs(x = "X",
       y = "Y",
       color = "Z")
