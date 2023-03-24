set.seed(8923)
library(tidyverse)
library(see)
library(effectsize)
library(report)
library(afex)
library(emmeans)
library(scales)
library(performance)
theme_set(theme_modern())


# Test inférentiel pour deux facteurs expérimentaux (2 X 2 ANOVA) -------

# Paramètres des donnés simulées ------------------------------------------

# Paramètres du macro-monde (que nous ne connaissons normalement pas !)
moyenne_groupe_0_0 <- 100
ecart_type_groupe_0_0 <- 15

moyenne_groupe_0_1 <- 115
ecart_type_groupe_0_1 <- 15

moyenne_groupe_1_0 <- 130
ecart_type_groupe_1_0 <- 15

moyenne_groupe_1_1 <- 160
ecart_type_groupe_1_1 <- 15

# Paramètres du micro-monde
n_participants_per_groupe <- 20

# Génération données groupe 00 (Sans Faible)
data_groupe_0_0 <- tibble(
  vi1 = 0,
  vi2 = 0,
  mesure = rnorm(n_participants_per_groupe, mean = moyenne_groupe_0_0, sd = ecart_type_groupe_0_0)
)

# Génération données groupe 01 (Sans Forte)
data_groupe_0_1 <- tibble(
  vi1 = 0,
  vi2 = 1,
  mesure = rnorm(n_participants_per_groupe, mean = moyenne_groupe_0_1, sd = ecart_type_groupe_0_1)
)

# Génération données groupe 10 (Avec Faible)
data_groupe_1_0 <- tibble(
  vi1 = 1,
  vi2 = 0,
  mesure = rnorm(n_participants_per_groupe, mean = moyenne_groupe_1_0, sd = ecart_type_groupe_1_0)
)

# Génération données groupe 11 (Avec Forte)
data_groupe_1_1 <- tibble(
  vi1 = 1,
  vi2 = 1,
  mesure = rnorm(n_participants_per_groupe, mean = moyenne_groupe_1_1, sd = ecart_type_groupe_1_1)
)

# Mettre les 4 groupes dans le même jeu de données et ajouter identifiant participant + ordre facteurs
data_combined <- bind_rows(data_groupe_0_0, data_groupe_0_1, data_groupe_1_0, data_groupe_1_1)
data_combined <- data_combined |>
  mutate(
    participant = paste0("P", 1:nrow(data_combined)),
    vi1 = factor(vi1, labels = c("Sans", "Avec")), # Modifier les labels des modalités vi1
    vi2 = factor(vi2, labels = c("Faible", "Forte")) # Modifier les labels de modalités vi2
  )

# Connaître/explorer les données -------------------------------------

# Échantillon globale
data_combined |>
  summarise(
    N = n(),
    M = mean(mesure),
    SD = sd(mesure),
  )

# Stratification par VIs
data_combined |>
  group_by(vi1, vi2) |>
  summarise(
    N = n(),
    M = mean(mesure),
    SD = sd(mesure),
  )

# Visualiser les données
ggplot(data = data_combined, aes(x = 1, y = mesure)) +
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
  facet_grid(vi2 ~ vi1) +
  labs(
    x = NULL,
    y = "Mesure", title = "Graphique du test. Barres = CI 95%"
  ) +
  scale_color_flat() +
  theme(legend.position = "none")


# Test avec interaction entre facteurs ------------------------------------

model <- aov_4(
  formula = mesure ~ vi1 * vi2 + (1|participant),
  data = data_combined
)

# Voir les résultats du test
nice(model)

# Voir les données avec l'effet d'interaction possible
afex_plot(model, x = "vi1", trace = "vi2")


# Comparaisons/contrasts avec effet de l'interaction ----------------------

comparison_with_interaction <- emmeans(
  model,
  specs = ~ vi1 * vi2
) |> pairs()

comparison_with_interaction |> summary(infer = TRUE, digits = 2)


# Comparaisons/contrasts sans effet de l'interaction ----------------------

main_effect_vi1 <- emmeans(
  model,
  specs = ~ vi1
) |> pairs()

main_effect_vi1 |> summary(infer = TRUE, digits = 2)

main_effect_vi2 <- emmeans(
  model,
  specs = ~ vi2
) |> pairs()

main_effect_vi2 |> summary(infer = TRUE, digits = 2)

# Contrôler les postulats de l'ANOVA --------------------------------------

# Homogénéité de la variance (les groupes ont une variance similaire) -> À utiliser avec précaution
check_homogeneity(model)

# Normalité des résidus
plot(check_normality(model))
plot(check_normality(model), type = "qq")
plot(check_normality(model), type = "qq", detrend = TRUE)
