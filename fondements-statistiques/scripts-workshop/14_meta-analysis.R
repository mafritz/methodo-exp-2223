set.seed(8923)
library(tidyverse)
library(see)
library(meta)
theme_set(theme_modern())


# Effectuer une méta-analysis sur expérience avec deux groupes ------------

data_meta_analysis <- tibble::tribble(
                               ~author, ~n.e, ~mean.e, ~sd.e, ~n.c, ~mean.c, ~sd.c,
                        "Expérience 1",  47L,    10.7,   3.4,  51L,     8.9,   2.9,
                        "Expérience 2",  23L,    45.8,  11.2,  23L,    46.1,   9.8,
                        "Expérience 3", 100L,    25.8,   5.1, 100L,    22.1,   4.7,
                        "Expérience 4",  20L,    19.7,   8.7,  20L,    15.8,   9.8,
                        "Expérience 5",  50L,    45.6,   7.4,  50L,    46.7,   6.5,
                        "Expérience 6",  40L,    30.9,   5.6,  40L,    27.7,   4.8,
                        "Expérience 7",  30L,    27.7,   5.8,  30L,    24.8,   6.3
                        )


m.cont <- metacont(n.e = n.e,
                   mean.e = mean.e,
                   sd.e = sd.e,
                   n.c = n.c,
                   mean.c = mean.c,
                   sd.c = sd.c,
                   studlab = author,
                   data = data_meta_analysis,
                   sm = "SMD",
                   method.smd = "Cohen",
                   fixed = FALSE,
                   random = TRUE,
                   method.tau = "REML",
                   hakn = TRUE,
                   title = "Exemple de méta-analysis")

forest.meta(m.cont)
