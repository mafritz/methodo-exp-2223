set.seed(8923)
library(tidyverse)
library(afex)
library(performance)
library(effectsize)
library(emmeans)
library(see)
theme_set(theme_modern())


# Modèle multiniveaux appliqué à des binômes ------------------------------


# Simulation des données --------------------------------------------------

n_participants = 200

data <- tibble(
  participant = paste0("P", 1:n_participants),
  dyad = rep(paste0("B", 1:(n_participants/2)), 2),
  groupe = rep(c("Control", "Treatment"), (n_participants/2)),
  mesure = rnorm(n_participants, 100, 15),
) |>
  mutate(
    mesure = if_else(groupe == "Treatment", mesure + rnorm(1, 10, 5), mesure)
  )


# Test multiniveaux qui tient compte des binômes --------------------------

model <- mixed(mesure ~ groupe + (1 | dyad), data)
nice(model)

emmeans(model, pairwise ~ groupe)
effectsize(model)


