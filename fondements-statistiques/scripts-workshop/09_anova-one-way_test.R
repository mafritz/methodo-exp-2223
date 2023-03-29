set.seed(8923)
library(tidyverse)
library(see)
library(effectsize)
library(report)
library(afex)
library(emmeans)
library(performance)
theme_set(theme_modern())

# Test inférentiel pour comparer trois groupes indépendants ---------------


# Paramètres des donnés simulées ------------------------------------------

# Paramètres du macro-monde (que nous ne connaissons normalement pas !)
moyenne_groupe_A <- 100
ecart_type_groupe_A <- 15

moyenne_groupe_B <- 115
ecart_type_groupe_B <- 15

moyenne_groupe_C <- 130
ecart_type_groupe_C <- 15

# Paramètres du micro-monde
n_participants_per_groupe <- 50

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


# Effectuer l'ANOVA one-way (omnibus) -------------------------------------

model <- aov_4(
  formula = mesure ~ groupe + (1|participant),
  data = data_combined
)

# Voir le tableau de l'ANOVA
nice(model)

# Intervalles de confiance sur la taille de l'effet
effectsize(model)

# Afficher la p-valeur en fonction de la distribution f -------------------

curve(
  df(x, df1 = model$Anova$Df[2], df2 = model$Anova$Df[3]),
  from = 0,
  to = model$Anova$`F value`[2] + 5,
  main = paste0("Distribution f (df1 = ", model$Anova$Df[2], " df2 = ", model$Anova$Df[3] ,")"),
  ylab = "Densité",
  xlab = "Resultat de l'ANOVA",
  lwd = 2,
  col = "steelblue"
)

abline(v = qf(0.05, df1 = model$Anova$Df[2], df2 = model$Anova$Df[3], lower.tail = FALSE), lwd = 3, lty = 2)
abline(v = model$Anova$`F value`[2], col = "red", lwd = 3)

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
  ifelse(model$Anova$`Pr(>F)`[2] < 0.001, "p < .001", paste("p", " = ", round(model$Anova$`Pr(>F)`[2], digits = 3))),
  col = c("red"),
  lwd = c(3),
  lty = c(1)
)

# Contrôler les postulats de l'ANOVA --------------------------------------

# Homogénéité de la variance (les groupes ont une variance similaire) -> À utiliser avec précaution
check_homogeneity(model)

# Normalité des résidus
plot(check_normality(model))
plot(check_normality(model), type = "qq")
plot(check_normality(model), type = "qq", detrend = TRUE)

# Effectuer les comparaison entre les trois moyennes ----------------------

comparaisons <- emmeans(
  object = model,
  spec = pairwise ~ groupe,
  adjust = "tukey" # Contrôler test multiples. Autre possibilité: "bonferroni"
)

# Voir moyennes marginales et contrastes inférentiels
print(comparaisons)

# Récupérer un tableau avec les intervalles de confiance
comparaisons |> summary(infer = TRUE, digits = 2)
