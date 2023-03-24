set.seed(8923)
library(tidyverse)
library(see)
theme_set(theme_modern())


# Échantillonage ----------------------------------------------------------

# L'échantillonage consiste à sélectionner un sous-groupe depuis un espace/domaine (e.g. une population) plus large



# Échantillonage depuis une distribution normale --------------------------

n_echantillon <- 100
moyenne_espace <- 100
ecart_type_espace <- 50

sampling_normal <- data.frame(
  moyenne = vector(length = 1000),
  ecart_type = vector(length = 1000)
)

for (i in 1:1000) {
  sample = rnorm(
    n = n_echantillon,
    mean = moyenne_espace,
    sd = ecart_type_espace
  )

  sampling_normal[i, 1] = mean(sample)
  sampling_normal[i, 2] = sd(sample)
}

# Graphique de la distribution des moyennes
qplot(sampling_normal$moyenne, xlab = "Moyenne de chaque échantillon", main = "Distribution des moyennes tirés d'une distribution normale", geom = "density")

# Graphique de la distribution des écarts types
qplot(sampling_normal$ecart_type,  xlab = "Écart type de chaque échantillon", main = "Distribution des écarts types tirés d'une distribution normale", geom = "density")


# Échantillonage depuis une distribution uniforme -------------------------

n_echantillon <- 100
min_espace <- 1
max_espace <- 100

sampling_uniform <- data.frame(
  moyenne = vector(length = 1000),
  ecart_type = vector(length = 1000)
)

for (i in 1:1000) {
  sample = runif(
    n = n_echantillon,
    min = min_espace,
    max = max_espace
  )

  sampling_uniform[i, 1] = mean(sample)
  sampling_uniform[i, 2] = sd(sample)
}

# Graphique de la distribution des moyennes
qplot(sampling_uniform$moyenne, xlab = "Moyenne de chaque échantillon", main = "Distribution des moyennes tirés d'une distribution uniforme", geom = "density")

# Graphique de la distribution des écart type
qplot(sampling_uniform$ecart_type, xlab = "Écart type de chaque échantillon", main = "Distribution des écarts types tirés d'une distribution uniforme", geom = "density")

# Échantillonage depuis une distribution exponentielle -------------------------

n_echantillon <- 100

sampling_exponential <- data.frame(
  moyenne = vector(length = 1000),
  ecart_type = vector(length = 1000)
)

for (i in 1:1000) {
  sample = rexp(n_echantillon, rate = 1)

  sampling_exponential[i, 1] = mean(sample)
  sampling_exponential[i, 2] = sd(sample)
}

# Graphique de la distribution des moyennes
qplot(sampling_exponential$moyenne, xlab = "Moyenne de chaque échantillon", main = "Distribution des moyennes tirés d'une distribution exponentielle", geom = "density")

# Graphique de la distribution des écart type
qplot(sampling_exponential$ecart_type, xlab = "Écart type de chaque échantillon", main = "Distribution des écarts types tirés d'une distribution exponentielle", geom = "density")
