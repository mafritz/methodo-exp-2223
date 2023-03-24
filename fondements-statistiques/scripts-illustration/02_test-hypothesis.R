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
library(TOSTER)
theme_set(theme_modern(base_size = 30, axis.title.size = 20, plot.title.size = 30))

n_per_groupe = 200


# M2 > M1 -----------------------------------------------------------------


# Model with effect -------------------------------------------------------

groupe_A_with_effect <- tibble(
  groupe = "X0",
  mesure = rnorm(n_per_groupe, 100, 15)
)

groupe_B_with_effect <- tibble(
  groupe = "X1",
  mesure = rnorm(n_per_groupe, 115, 15)
)

data_with_effect <- bind_rows(groupe_A_with_effect, groupe_B_with_effect) |>
  mutate(
    random_id(n(), bytes = 4)
  )

ggplot(data = data_with_effect, aes(x = groupe, y = mesure, color = groupe)) +
  geom_jitter(alpha = 0.1, size = 4) +
  stat_summary(
    fun.data = mean_cl_normal,
    geom = "errorbar",
    width = 0.3,
    position = position_dodge(width = 0.1)
  ) +
  stat_summary(
    fun = mean, geom = "point",
    size = 3,
    shape = 15,
    position = position_dodge(width = 0.6)
  ) +
  labs(
    x = "VI",
    y = "VD"
  ) +
  scale_color_flat() +
  theme(legend.position = "none")

model_with_effect <- t.test(
  formula = mesure ~ groupe,
  data = data_with_effect
)

TOSTtwo(
  n1 = nrow(groupe_A_with_effect),
  m1 = mean(groupe_A_with_effect$mesure),
  sd1 = sd(groupe_A_with_effect$mesure),
  n2 = nrow(groupe_B_with_effect),
  m2 = mean(groupe_B_with_effect$mesure),
  sd2 = sd(groupe_B_with_effect$mesure),
  low_eqbound_d = -0.5,
  high_eqbound_d = 0.5
)

# Model without effect -------------------------------------------------------

groupe_A_without_effect <- tibble(
  groupe = "X0",
  mesure = rnorm(n_per_groupe, 100, 15)
)

groupe_B_without_effect <- tibble(
  groupe = "X1",
  mesure = rnorm(n_per_groupe, 103, 15)
)

data_without_effect <- bind_rows(groupe_A_without_effect, groupe_B_without_effect) |>
  mutate(
    random_id(n(), bytes = 4)
  )

ggplot(data = data_without_effect, aes(x = groupe, y = mesure, color = groupe)) +
  geom_jitter(alpha = 0.1, size = 4) +
  stat_summary(
    fun.data = mean_cl_normal,
    geom = "errorbar",
    width = 0.3,
    position = position_dodge(width = 0.1)
  ) +
  stat_summary(
    fun = mean, geom = "point",
    size = 3,
    shape = 15,
    position = position_dodge(width = 0.6)
  ) +
  labs(
    x = "VI",
    y = "VD"
  ) +
  scale_color_flat() +
  theme(legend.position = "none")

model_without_effect <- t.test(
  formula = mesure ~ groupe,
  data = data_without_effect
)

TOSTtwo(
  n1 = nrow(groupe_A_without_effect),
  m1 = mean(groupe_A_without_effect$mesure),
  sd1 = sd(groupe_A_without_effect$mesure),
  n2 = nrow(groupe_B_without_effect),
  m2 = mean(groupe_B_without_effect$mesure),
  sd2 = sd(groupe_B_without_effect$mesure),
  low_eqbound_d = -0.5,
  high_eqbound_d = 0.5
)

