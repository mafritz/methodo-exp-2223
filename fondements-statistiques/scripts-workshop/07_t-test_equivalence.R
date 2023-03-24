set.seed(8923)
library(tidyverse)
library(see)
library(effectsize)
library(report)
library(TOSTER)
theme_set(theme_modern())

# Test inférentiel pour tester l'équivalence de deux moyennes -------------

# Paramètres des donnés simulées ------------------------------------------

# Paramètres du macro-monde (que nous ne connaissons normalement pas !)
moyenne_groupe_A <- 100
ecart_type_groupe_A <- 15

moyenne_groupe_B <- 100
ecart_type_groupe_B <- 15

# Paramètres du micro-monde
n_participants_per_groupe <- 20

sesoi_lower_d = -0.5 # Limite inférieur de la taille standardisée de l'effet considéré équivalent
sesoi_upper_d = 0.5 # Limite supérieur de la taille standardisée de l'effet considéré équivalent

# Génération données groupe A
data_groupe_A <- tibble(
  groupe = "A",
  mesure = rnorm(n_participants_per_groupe, mean = moyenne_groupe_A, sd = ecart_type_groupe_A)
)

# Génération données groupe B
data_groupe_B <- tibble(
  groupe = "B",
  mesure = rnorm(n_participants_per_groupe, mean = moyenne_groupe_B, sd = ecart_type_groupe_B)
)

# Mettre les deux groupes dans le même jeu de données
data_combined <- bind_rows(data_groupe_A, data_groupe_B) |>
  mutate(
    groupe = factor(groupe)
  )

# Effectuer un test d'équivalence -----------------------------------------

model <- t_TOST(
  formula = mesure ~ groupe,
  data = data_combined,
  paired = FALSE,
  var_equal = FALSE,
  hypothesis = "EQU",
  low_eqbound = sesoi_lower_d,
  high_eqbound = sesoi_upper_d,
  eqbound_type = "SMD",
  alpha = 0.05,
  mu = 0,
  bias_correction = TRUE
)

print(model)
plot(model, type = "cd", ci_shades = c(.9,.95))
