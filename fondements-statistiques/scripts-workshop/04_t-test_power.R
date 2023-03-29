set.seed(8923)
library(pwr)

# Puissance statistique comparaison entre deux moyennes --------------------

# La puissance statistique permet de déterminer la taille minimale d'un échantillon en fonction de trois autres paramètres

# 1. Contrôle de l'erreur de type I (dire qu'il y a effet quand il y en a pas): 0 > valeur < 1
type_1_error = 0.05

# 2. Contrôle de l'erreur de type II (dire qu'il n'y a pas d'effet quand il y en a un): 0 > valeur < 1
type_2_error = 0.8

# 3. La plus petite taille de l'effet d'intérêt calculée selon Cohen's d (M1 - M2) / SD
# Références générales d'après Cohen (1988) pour la taille de l'effet sont:
# Petit = 0.2
# Moyen = 0.5
# Grand = 0.8
# À utiliser avec précaution: tout dépend du type d'intervention/effet envisagés !

sesoi_d = 0.5

pwr.t.test(
  type = "two.sample",
  alternative = "two.sided",
  sig.level = type_1_error,
  power = type_2_error,
  d = sesoi_d
)
