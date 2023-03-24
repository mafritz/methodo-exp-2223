set.seed(6263)
library(tidyverse)
library(broom)
library(see)
library(effectsize)
library(report)
library(scales)
library(equatiomatic)
library(afex)
library(ids)
theme_set(theme_modern(base_size = 30, axis.title.size = 20, plot.title.size = 30))


# Principe de base de la régression linéaire ------------------------------

n_points = 100

data <- tibble(
  x = rnorm(n_points, 100, 40),
  y = x + rnorm(n_points, 0, 15),
  groupe = sample(c("A", "B"), n_points, replace = TRUE)
) |> mutate(
  x = rescale(x, to = c(0, 20)),
  y = rescale(y, to = c(30, 130))
)

data <- data |>
  add_row(
    x = 19,
    y = 210,
    groupe = "B"
  )

model <- lm(y ~ x, data)

data_plus <- augment(model)

ggplot(data_plus, aes(x = x, y = y)) +
  geom_smooth(method = "lm", se = FALSE, formula = y ~ x, color = "blue", size = 2) +
  geom_segment(aes(xend = x, yend = .fitted), color = "#970000", size = 1) +
  geom_point(size = 5, color = "#44546A") +
  labs(x = "X", y = "Y") +
  NULL
