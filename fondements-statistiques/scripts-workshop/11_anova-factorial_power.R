set.seed(8923)
library(tidyverse)
library(Superpower)
library(see)
theme_set(theme_modern())

# Puissance statistique ANOVA factorielle --------------------

# Le calcul de puissance statistique est plus compliqué, cela dépend qu'est-ce qu'on veut détecter:
# 1. Les effets "simples"
# 2. Les effets "principaux"
# 3. Les effets d'interactions ?

# On peut procéder avec une simulation des différentes facteurs/modalités

labels <- c("VI1", "Sans", "Avec", "VI2", "Faible", "Forte")


# Simuler des données -----------------------------------------------------

experimental_plan_design <- ANOVA_design(
  # Type de design composé par nombre modalité + type de plan (e.g. b = between, w = within)
  # E.g. 2b = 2 modalité between (inter-sujets)
  # E.g. 3b*2b = 3 modalités between pour VI1 avec interaction avec 2 modalités between pour la VI2
  design = "2b*2b",
  # observations dans chaque groupe
  n = 50,
  # moyennes attendues/possibles
  mu = c(100, 115, 130, 160),
  # écart type attendu/possible
  sd = 15,
  # labels facteurs/modalités
  labelnames = labels
)

# Voir résultats (regarder aussi dans le tab Plots)
print(experimental_plan_design)


# Simulation de résultats -------------------------------------------------

type_1_error = 0.05
nombre_simulations = 100

simulation_result <- ANOVA_power(
  experimental_plan_design,
  alpha_level = type_1_error,
  nsims = nombre_simulations,
  verbose = TRUE
)
