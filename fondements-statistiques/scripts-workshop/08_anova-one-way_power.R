set.seed(8923)
library(pwr)

# Puissance statistique comparaison entre plusieurs moyennes --------------------

# La puissance statistique permet de déterminer la taille minimale d'un échantillon en fonction de trois autres paramètres

# 1. Contrôle de l'erreur de type I (dire qu'il y a effet quand il y en a pas): 0 > valeur < 1
type_1_error = 0.05

# 2. Contrôle de l'erreur de type II (dire qu'il n'y a pas d'effet quand il y en a un): 0 > valeur < 1
type_2_error = 0.8

# 3. La plus petite taille de l'effet d'intérêt en Cohen's f.
# Références générales d'après Cohen (1988) pour la taille de l'effet sont:
# Petit = 0.1 (correspond à eta-squared = 0.0099)
# Moyen = 0.25 (correspond à eta-squared = 0.0588)
# Grand = 0.4  (correspond à eta-squared = 0.1379)
# À utiliser avec précaution: tout dépend du type d'intervention/effet envisagés !

sesoi_f = 0.25

pwr.anova.test(
  k = 3, # Nombre de groupes indépendants
  sig.level = type_1_error,
  power = type_2_error,
  f = sesoi_f
)

# Pour des analyses de puissance statistique plus poussés voir https://aaroncaldwell.us/SuperpowerBook/
