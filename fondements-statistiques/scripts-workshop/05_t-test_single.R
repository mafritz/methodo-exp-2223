set.seed(8923)
library(tidyverse)
library(see)
library(effectsize)
library(report)
theme_set(theme_modern())

# Test inférentiel pour comparer deux groupes indépendants ----------------

# Paramètres des donnés simulées ------------------------------------------

# Paramètres du macro-monde (que nous ne connaissons normalement pas !)
moyenne_groupe_A <- 100
ecart_type_groupe_A <- 15

moyenne_groupe_B <- 115
ecart_type_groupe_B <- 15

# Paramètres du micro-monde
n_participants_per_groupe <- 20

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

# Connaître/explorer les données -------------------------------------

# Échantillon globale
data_combined |>
  summarise(
    N = n(),
    M = mean(mesure),
    SD = sd(mesure)
  )

# Stratification par VI
data_combined |>
  group_by(groupe) |>
  summarise(
    N = n(),
    M = mean(mesure),
    SD = sd(mesure)
  )

# Visualiser les données
ggplot(data = data_combined, aes(x = groupe, y = mesure, color = groupe)) +
  geom_jitter(alpha = 0.2) +
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
    x = "Modalité de la seule VI",
    y = "Mesure", title = "Graphique du test. Barres = CI 95%"
  ) +
  scale_color_flat() +
  theme(legend.position = "none")

# Effectuer un t-test de Welch avec hétérogénité de la variance -----------

model <- t.test(
  formula = mesure ~ groupe,
  data = data_combined,
  alternative = "two.sided",
  paired = FALSE,
  var.equal = FALSE,
  mu = 0
)

# Afficher les résultats "brutes"
print(model)

# Afficher une synthèse textuelle
report(model, verbose = FALSE)


# Afficher la p-valeur en fonction de la distribution t -------------------

curve(
  dt(x, df = model$parameter),
  from = ifelse(model$statistic < -5, model$statistic - 1, -5),
  to = ifelse(model$statistic > 5, model$statistic + 1, 5),
  main = paste0("Distribution t (df = ", round(model$parameter, digits = 2), ")"),
  ylab = "Densité",
  xlab = "Resultat du test-t",
  lwd = 2,
  col = "steelblue"
)

if (model$alternative == "two.sided") {
  abline(v = qt(0.025, df = model$parameter), lwd = 3, lty = 2)
  abline(v = qt(1 - 0.025, df = model$parameter), lwd = 3, lty = 2)
} else if (model$alternative == "less") {
  abline(v = qt(0.05, df = model$parameter), lwd = 3, lty = 2)
} else {
  abline(v = qt(1 - 0.05, df = model$parameter), lwd = 3, lty = 2)
}

abline(v = model$statistic, col = "red", lwd = 3)

legend(
  x = "topleft",
  expression(paste(plain(alpha), " = 0.05  ")),
  col = c("black"),
  lwd = c(3),
  lty = c(2)
)
legend(
  y = 50,
  x = "topright",
  ifelse(model$p.value < 0.001, "p < .001", paste("p", " = ", round(model$p.value, digits = 3))),
  col = c("red"),
  lwd = c(3),
  lty = c(1)
)
