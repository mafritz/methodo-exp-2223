set.seed(8923)
library(tidyverse)
library(see)
library(effectsize)
library(report)
theme_set(theme_modern())


# Simulation de plusieurs comparaisons entre deux moyennes ----------------

# Paramètres des donnés simulées ------------------------------------------

# Paramètres du macro-monde (que nous ne connaissons normalement pas !)
moyenne_groupe_A <- 100
ecart_type_groupe_A <- 15

moyenne_groupe_B <- 115
ecart_type_groupe_B <- 15

# Paramètres du micro-monde
n_participants_per_groupe <- 20

# Effectuer 1000 t-tests de Welch avec hétérogénité de la variance --------

replications <- replicate(1000, {
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
  data_combined <- bind_rows(data_groupe_A, data_groupe_B)

  # Effectuer le test
  model <- t.test(
    formula = mesure ~ groupe,
    data = data_combined,
    alternative = "two.sided",
    paired = FALSE,
    var.equal = FALSE,
    mu = 0
  )

  # Récupérer seulement la p-valeur
  model$p.value
})

# Afficher la distribution des p-valeurs obtenues à travers les tests -----

hist(
  replications,
  breaks = seq(from = 0, to = 1, by = 0.05),
  col = "lightblue",
  xlab = paste0("p-valeur < 0.05 ", round(sum(replications < 0.05) / 1000 * 100, 2), "% des fois"),
  ylab = "Fréquence/Puissance statistique",
  main = "Distribution des p-valeur obtenues dans 1'000 replications",
  xlim = c(0, 1),
  ylim = c(0, 1000),
)

abline(
  v = 0.05,
  col = "red",
  lwd = 3,
  lty = 2
)

legend(
  x = "topright",
  expression(paste(plain(alpha), " = 0.05  ")),
  col = c("red"),
  lwd = c(3),
  lty = c(2)
)

