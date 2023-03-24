set.seed(8923)
library(tidyverse)
library(see)
theme_set(theme_modern())


# Simulation de données ---------------------------------------------------

# La simulation des données est une bonne manière pour comprendre les statistiques


# Chiffres entières au hasard ---------------------------------------------

random_integer <- sample(x = 1:10, size = 1000, replace = TRUE)
qplot(random_integer)


# Chiffres décimales depuis une distribution uniforme ---------------------

random_uniform <- runif(n = 1000, min = 1, max = 10)
qplot(random_uniform)


# Chiffres décimales depuis une distribution normale (cloche) -------------

random_normal <- rnorm(n = 1000, mean = 100, sd = 10)
qplot(random_normal)


# Chiffres décimales depuis une distribution exponentielle ----------------

random_exponential <- rexp(n = 1000, rate = 1)
qplot(random_exponential)


# Simuler  la randomisation dans un jeu de données ------------------------

n_participants <- 30

random_data <- tibble(
  participant = paste0("P", 1:n_participants),
  groupe = sample(c("A", "B", "C"), n_participants, replace = TRUE),
  age = runif(n = n_participants, min = 18, max = 65),
  fatigue = rexp(n = n_participants, rate = 1),
  qi = rnorm(n_participants, 100, 15)
)

# Créer les indicateurs avec les fonctions

random_data |>
  group_by(groupe) |>
  summarise(
    N = n(),
    M_age = mean(age),
    SD_age = sd(age),
    M_fatigue = mean(fatigue),
    SD_fatigue = sd(fatigue),
    M_qi = mean(qi),
    SD_qi = sd(qi)
  )
