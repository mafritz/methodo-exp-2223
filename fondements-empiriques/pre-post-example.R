set.seed(8923)
library(tidyverse)
library(see)
library(effectsize)
library(report)
library(afex)
library(emmeans)
library(scales)
library(performance)
library(papaja)
theme_set(theme_modern())


# Test inférentiel pour deux facteurs expérimentaux (2 X 2 ANOVA) -------

# Paramètres des donnés simulées ------------------------------------------

# Paramètres du macro-monde (que nous ne connaissons normalement pas !)
moyenne_groupe_0_0 <- 100
ecart_type_groupe_0_0 <- 15

moyenne_groupe_0_1 <- 105
ecart_type_groupe_0_1 <- 15

moyenne_groupe_1_0 <- 115
ecart_type_groupe_1_0 <- 15

moyenne_groupe_1_1 <- 130
ecart_type_groupe_1_1 <- 15

# Paramètres du micro-monde
n_participants_per_groupe <- 30

# Génération données groupe 00 (Post X0)
data_groupe_0_0 <- tibble(
  pre_post = 0,
  VI = 0,
  VD = rnorm(n_participants_per_groupe, mean = moyenne_groupe_0_0, sd = ecart_type_groupe_0_0)
)

# Génération données groupe 01 (Post X1)
data_groupe_0_1 <- tibble(
  pre_post = 0,
  VI = 1,
  VD = rnorm(n_participants_per_groupe, mean = moyenne_groupe_0_1, sd = ecart_type_groupe_0_1)
)

# Génération données groupe 10 (Pre X0)
data_groupe_1_0 <- tibble(
  pre_post = 1,
  VI = 0,
  VD = rnorm(n_participants_per_groupe, mean = moyenne_groupe_1_0, sd = ecart_type_groupe_1_0)
)

# Génération données groupe 11 (Pre X1)
data_groupe_1_1 <- tibble(
  pre_post = 1,
  VI = 1,
  VD = rnorm(n_participants_per_groupe, mean = moyenne_groupe_1_1, sd = ecart_type_groupe_1_1)
)

# Mettre les 4 groupes dans le même jeu de données et ajouter identifiant participant + ordre facteurs
data_combined <- bind_rows(data_groupe_0_0, data_groupe_0_1, data_groupe_1_0, data_groupe_1_1)
data_combined <- data_combined |>
  mutate(
    participant = paste0("P", 1:nrow(data_combined)),
    pre_post = factor(pre_post, labels = c("Pre", "Post")), # Modifier les labels des modalités pre_post
    VI = factor(VI, labels = c("X0", "X1")) # Modifier les labels de modalités VI
  )

# Connaître/explorer les données -------------------------------------

# Échantillon globale
data_combined |>
  summarise(
    N = n(),
    M = mean(VD),
    SD = sd(VD),
  )

# Stratification par VIs
data_combined |>
  group_by(pre_post, VI) |>
  summarise(
    N = n(),
    M = mean(VD),
    SD = sd(VD),
  )

# Visualiser les données
ggplot(data = data_combined, aes(x = 1, y = VD)) +
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
  facet_grid(VI ~ pre_post) +
  labs(
    x = NULL,
    y = "VD", title = "Graphique du test. Barres = CI 95%"
  ) +
  scale_color_flat() +
  theme(legend.position = "none")


# Test Pre interaction entre facteurs ------------------------------------

model <- aov_4(
  formula = VD ~ pre_post * VI + (1|participant),
  data = data_combined
)

# Voir les résultats du test
nice(model)

# Voir les données Pre l'effet d'interaction possible
pre_post_plot <- afex_plot(model, x = "pre_post", trace = "VI") +
  theme(
    axis.title.x = element_blank()
  ) +
  theme_apa(box = TRUE)


# Comparaisons/contrasts Pre effet de l'interaction ----------------------

comparison_with_interaction <- emmeans(
  model,
  specs = ~ pre_post * VI
) |> pairs()

comparison_with_interaction |> summary(infer = TRUE, digits = 2)


# Comparaisons/contrasts Post effet de l'interaction ----------------------

main_effect_pre_post <- emmeans(
  model,
  specs = ~ pre_post
) |> pairs()

main_effect_pre_post |> summary(infer = TRUE, digits = 2)

main_effect_VI <- emmeans(
  model,
  specs = ~ VI
) |> pairs()

main_effect_VI |> summary(infer = TRUE, digits = 2)

# Contrôler les postulats de l'ANOVA --------------------------------------

# Homogénéité de la variance (les groupes ont une variance similaire) -> À utiliser Pre précaution
check_homogeneity(model)

# Normalité des résidus
plot(check_normality(model))
plot(check_normality(model), type = "qq")
plot(check_normality(model), type = "qq", detrend = TRUE)
