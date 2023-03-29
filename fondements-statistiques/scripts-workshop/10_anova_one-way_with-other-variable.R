set.seed(8923)
library(tidyverse)
library(see)
library(effectsize)
library(report)
library(afex)
library(emmeans)
library(scales)
theme_set(theme_modern())

# Test inférentiel avec une autre variable (e.g. contrôle) ---------------

# Paramètres des donnés simulées ------------------------------------------

# Paramètres du macro-monde (que nous ne connaissons normalement pas !)
moyenne_groupe_A <- 100
ecart_type_groupe_A <- 15

moyenne_groupe_B <- 115
ecart_type_groupe_B <- 15

moyenne_groupe_C <- 130
ecart_type_groupe_C <- 15

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

# Génération données groupe C
data_groupe_C <- tibble(
  groupe = "C",
  mesure = rnorm(n_participants_per_groupe, mean = moyenne_groupe_C, sd = ecart_type_groupe_C)
)

# Mettre les trois groupes dans le même jeu de données et ajouter identifiant participant
data_combined <- bind_rows(data_groupe_A, data_groupe_B, data_groupe_C)
data_combined <- data_combined |>
  mutate(
    participant = paste0("P", 1:nrow(data_combined))
  )


# Ajouter une troisième variable en relation avec la mesure ---------------

data_combined <- data_combined |>
  mutate(
    z = mesure + rnorm(nrow(data_combined), 100, 10), # Adapter le bruit pour voir ce qui change
    z = scale(z)[,1] # Centrer la variable M = 0, SD = 1
  )


# Connaître/explorer les données -------------------------------------

# Échantillon globale
data_combined |>
  summarise(
    N = n(),
    M_measure = mean(mesure),
    SD_measure = sd(mesure),
    M_z = mean(z),
    SD_z = sd(z)
  )

# Stratification par VI
data_combined |>
  group_by(groupe) |>
  summarise(
    N = n(),
    M_measure = mean(mesure),
    SD_measure = sd(mesure),
    M_z = mean(z),
    SD_z = sd(z)
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


# Effectuer l'ANOVA one-way (omnibus) avec la troisième variable ----------

model <- aov_4(
  formula = mesure ~ groupe + z + (1|participant),
  data = data_combined,
  factorize = FALSE
)

# Voir le tableau de l'ANOVA
nice(model)


# Effectuer les comparaison entre les trois moyennes ----------------------

comparaisons <- emmeans(
  object = model,
  spec = pairwise ~ groupe,
  adjust = "tukey" # Contrôler test multiples. Autre possibilité: "bonferroni"
)

# Voir moyennes marginales et contrastes inférentiels
print(comparaisons)
