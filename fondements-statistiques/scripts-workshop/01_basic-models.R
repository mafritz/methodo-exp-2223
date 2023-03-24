set.seed(8923)
library(tidyverse)
library(see)
theme_set(theme_modern())
# Modélisation de base ----------------------------------------------------

# La modélisation de base de données concerne des statistiques comme la moyenne, la médiane, la variance et l'écart type


# Données -----------------------------------------------------------------

uniform_data <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
extreme_data <- c(0, 0, 0, 0, 0, 10, 10, 10, 10, 90)
centered_data <- c(3, 4, 4, 5, 5, 5, 5, 6, 6, 7)
simulated_data <- sample(1:10, 1000, replace = TRUE)
your_data <- c(1, 2, 3)


# Visualisation rapide ----------------------------------------------------

qplot(uniform_data)
qplot(extreme_data)
qplot(centered_data)
qplot(simulated_data)
qplot(your_data)


# Moyenne -----------------------------------------------------------------

mean(uniform_data)
mean(extreme_data)
mean(centered_data)
mean(simulated_data)
mean(your_data)


# Médianne ----------------------------------------------------------------

median(uniform_data)
median(extreme_data)
median(centered_data)
median(simulated_data)
median(your_data)

# Variance ----------------------------------------------------------------

var(uniform_data)
var(extreme_data)
var(centered_data)
var(simulated_data)
var(your_data)


# Écart type (Standard Deviation) -----------------------------------------

sd(uniform_data)
sd(extreme_data)
sd(centered_data)
sd(simulated_data)
sd(your_data)
