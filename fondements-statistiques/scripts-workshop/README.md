# Workshop fondements statistiques

Ce document est accompagné par des fichiers/scripts en R qui permettent de découvrir et comprendre le fonctionnement des statistiques fréquentielles. Les fichiers sont numérotés de manière progressive et contient du code à exécuter/adapter en fonction des consignes illustrées dans ce document.

## Préparation et informations utiles

### Logiciels nécessaires

Pour exécuter le code les logiciels suivants sont nécessaires:

- [R](https://www.r-project.org/) version 4.1.0 ou supérieur

- [RStudio desktop](https://www.rstudio.com/products/rstudio/) version RStudio 2021.09.0 ou supérieur. En alternative, un compte [RStudio cloud](https://rstudio.cloud). Pour plus d'informations sur RStudio, voir [la page EduTechWiki homonyme](https://edutechwiki.unige.ch/fr/RStudio).

Il existe également un parcours sur EduTechWiki qui permet de découvrir R/RStudio dans une perspective Open Science: [pensée computationnelle avec R](https://edutechwiki.unige.ch/fr/Pens%C3%A9e_computationnelle_avec_R).

### Setup du workshop

Pour utiliser les fichiers, téléchargez ou clonez l'ensemble de ce dépôt GitHub qui est en soi un projet de RStudio. Ensuite, dans RStudio:

1.  Choisissez la commande du menu principal `File > Open Project...`

2.  Cherchez le dossier qui contient les fichiers du dépôt

3.  Ouvrez le fichier qui s'appelle `methodo-exp-2223.Rproj`

4.  Le projet va s'ouvrir en RStudio

5.  Ouvrez le dossier `fondements-statistiques/scripts-workshop/` dans le gestionnaire des fichiers de l'interface

6.  Ouvrez au fur et à mesure les fichiers correspondants aux activités

Les activités proposes des questions/problèmes. La fin de ce document propose un lien aux réponses, mais il est important d'essayer de manipuler vous-mêmes les scripts et de noter vos propres réponses pour les comparer ensuite.

### Commandes fréquentes

Pour exécuter le code des scripts, la manière la plus rapide est d'utiliser les raccourcis de clavier:

- `Ctrl + Enter` (Win) ou `Cmd + Enter` (Mac) pour exécuter un bout de code (e.g. une ligne) à la fois.

- `Ctrl + Shift + Enter` (Win) ou `Cmd + Shift + Enter` (Mac) pour exécuter l'ensemble du code d'un fichier script

Les résultats des exécutions vont s'afficher:

- Dans la **console** en bas de l'interface RStudio (avec configuration standard de RStudio) pour les résultats des tests statistiques et autres informations textuelles

- Dans l'onglet **Plots** dans le côté inférieur à droite de l'interface (avec configuration standard de RStudio)

### Présence d'un _seed_ dans le code des fichiers

Dans les scripts du workshop il a été inséré ce qu'on appelle un _seed_ avec un code similaire à:

`set.seed(8923)`

Ce code permet d'obtenir toujours les mêmes résultats a des tests statistiques, car les ordinateurs utilisent des tables de chiffres pseudo-aléatoires pour simuler des données stochastiques/randomisées. Si vous voulez obtenir des résultats différents en essayant plusieurs fois le même scripts, vous pouvez commenter la ligne du _seed_ avec un \# au début de la ligne:

`# set.seed(8923)`

## Installation paquets R

Le fichier `00_installation.R` contient une ligne de code qui permet d'installer les paquets externes de R utilisés dans les scripts. Vous pouvez l'exécuter avec les commandes illustrées plus haut, ou la copier/coller dans la console. L'installation des paquets peut prendre quelques temps.

## 01 Modélisation de base

Le fichier `01_basic-models.R` contient des fonctions qui permettent de créer des modélisation de bases comme la moyenne, la médiane, la variance et l'écart type, ainsi que des graphiques pour voir la distribution de données.

1.  Dans la première partie du code, dans la section **Données**, vous avez 5 vecteurs/jeu de données sous la forme `jeu_de_donnes <- c(1, 2, 3, 4, 5, ...)`. Le dernier de ces vecteurs/jeux des données s'appelle `your_data`. Modifiez le contenu du vecteur en ajoutant quelques chiffres de votre choix. Laissez les autres vecteurs/jeux de données intactes.

2.  Parcourrez les différentes sections du script et exécuter le code de manière progressive. À travers l'exécution du code, essayez de répondre aux questions suivantes:

    - Quelle est la différence entre la moyenne et la médiane ?

    - Plus l'écart entre données est grand, plus la variance est \_\_\_\_\_\_\_\_ ?

    - Quel est le rapport entre la variance et l'écart type ?

## 02 Simulations des données et randomisation

Le fichier `02_simulations-donnees-et-randomisation.R` a trois objectifs connectés:

- Introduire le concept de distributions de données

- Simuler des données tirées distributions différentes

- Appliquer la randomisation à des données tirées de distributions différentes

Le code de cette activité prévoit:

1.  Dans la première partie du code, quatre bouts de code qui permettent de générer des données de quatre manières différentes. Les données sont ensuite représentées graphiquement pour donner une idée de la distribution des données. Modifiez les différents paramètres des fonctions et contrôlez ensuite l'effet sur les distributions dans les graphiques. Les paramètres sont assez intuitifs et les commentaires devraient aider à comprendre les différentes fonctions/distributions.

2.  Dans la deuxième partie, des données simulées depuis les fonctions/distributions illustrées plus haut sont créées dans un jeu de données avec les caractéristiques suivantes:

    - Participant: un identifiant unique de chaque participant

    - Groupe: l'attribution aléatoire à une hypothétique VI avec trois modalités A, B et C

    - Age: avec un chiffre représentant les années (avec décimaux) du participant

    - Fatigue: un indicateur auto-reporté de fatigue avant d'entamer une tâche mesuré à travers un hypothétique _slider_ allant de pas du tout fatigué-e à extrêmement fatigué-e

    - QI: une mesure psychométrique de l'intelligence selon un test de type performance

3.  Le jeu de données est stratifié par le groupe/VI et les mesures sont agrégés avec des indicateurs comme le nombre de participant-es, les moyennes et écarts types de chaque mesure. D'abord avec le nombre de participant-es proposé et puis en variant ce nombre, essayez de répondre aux questions suivantes:

    - Si on utilise une attribution totalement aléatoire, les trois groupes/modalités auront toujours le même nombre de participant-es ?

    - Quelles mesures sont plus similaires/différentes dans les trois groupes ? Est-ce qu'il y a un rapport entre la distribution depuis laquelle les données sont tirées et la similarité des moyennes/écarts types ?

    - Plus grand le nombre de participant-es, plus \_\_\_\_\_\_\_\_\_ les différences entre moyennes et écarts types.

    - Qu'est-ce que vous en concluez sur la possibilité d'avoir des potentiels facteurs indépendants de la VI qui pourraient influencer la VD (pas présente dans ce jeu de données) ?

    - Imaginez deux phénomènes en relation avec les technologies éducatives dans le MALTT (e.g. compétences techniques, intérêt pour les technologies, ...). Comment pensez-vous que ce phénomène est/serait distribué chez l'ensemble des apprenant-es (passé-es et futures) du MALTT ?

## 03 Échantillonnage

Le fichier `03_echantillonnage.R` introduit le concept d'échantillon, c'est-à-dire un sous-groupe de l'espace/population de référence. L'objectif de l'activité est double:

- Introduire la différence entre la distribution des données tirées d'un seul échantillon et la distribution de plusieurs échantillon par rapport à une caractéristique comme la moyenne ou l'écart type

- Montrez de manière simulé/empirique le théorème de la limite centrale

Le code du script est organisé en trois parties similaires:

1.  Échantillonnage depuis une distribution normale. Au lieu de simuler un seul jeu de données/échantillon, la simulation est répétée 1'000 fois pour générer 1'000 échantillons depuis une distribution normale avec des caractéristiques à paramétrer dans le script. Pour chaque échantillon généré, le script calcule la moyenne et l'écart type de l'échantillon et le stocke dans un jeu de données. Ce jeu de données contient donc 1'000 observations, chacune représentative d'un échantillon. La distribution de ces moyennes et écarts types sont ensuite représentés graphiquement.

2.  Le même mécanisme du point précédent est répliqué dans l'échantillonnage depuis une distribution uniforme.

3.  Le même mécanisme est répliqué encore une fois depuis une distribution exponentielle.

Sur la base de cette explication et en comparant les distributions des moyennes et écarts types obtenues:

- Est-ce que les distributions des moyennes et écarts types sont différentes ou similaires en fonction de la distribution _mère_ depuis laquelle les échantillons sont tirés ?

- Est-ce que les distributions obtenues ont des formes reconnaissables ? Si oui, avec quel type de distribution on peut les identifier ?

- Qu'est-ce que vous pouvez en conclure ?

## 04 Puissance statistique pour un test _t_ de Welch

Le fichier `04_t-test_power.R` permet de s'exercer au concept de puissance statistique dans le contexte de la comparaison entre deux moyennes/groupes. La puissance statistique est une fonction déterminée par 4 éléments:

- Le seuil de l'erreur de type I: le risque de _voir_ dans le micro-monde un effet qui n'existe pas dans le macro-monde
- Le seuil de l'erreur de type II: le risque de _rater_ dans le micro-monde un effet qui existe dans le macro-monde
- Le _Smallest Effect Size Of Interest_ (SESOI): la taille de l'effet minimal qui est considérée intéressante à chercher/déceler
- La taille de l'échantillon: nombre d'entités/observations/participants dans le micro-monde

Lorsqu'on connait 3 de ces 4 éléments, on peut dériver le 4ème mathématiquement. On utilise cette fonction pour justifier/déterminer la taille de l'échantillon dans le test.

De plus, le t test a la particularité qu'on peut tester trois types d'hypothèses:

- Hypothèse non-directionnelle M1 ≠ M2, avec ce qu'on appelle un test bilatéral et qui est représenté dans la fonction `t.test` avec l'attribut `alternative = "two.sided"`

- Hypothèse directionnelle M1 \< M2, avec ce qu'on appelle un test unilatéral et qui est représenté dans la fonction `t.test` avec l'attribut `alternative = "less"`

- Hypothèse directionnelle M1 \> M2, qui est toujours un test unilatéral représenté avec `alternative = "greater"`

En modifiant les différents paramètres dans le script en question, répondez aux questions suivantes:

- Combien de participant-es seraient nécessaire pour détecter un SESOI de Cohen's d = 0.5, dans un test bilatéral (alternative = "two.sided") avec un erreur de type I de 0.05 et de type II de 0.8 ?

- Modifiez seulement l'alternative = "greater" à la ligne 25 et laissez tous les autres éléments inchangés. Qu'est-ce que vous observez au niveau du nombre de participant-es nécessaires ? Est-ce que vous imaginez qu'avec l'alternative "less" le nombre sera différent ? (Hint: si vous voulez tester il faudra mettre le SESOI négatif, à -0.5)

- Remettez l'alternative = "two.sided". Dans la première manipulation avec type I = 0.05, type II = 0.8, et SESOI = 0.5 vous avez obtenu 64 participant-es par groupe. Diminuez maintenant le SESOI = 0.25, la taille de l'échantillon nécessaire et plus grande ou plus petite ? De ce fait, vous pouvez conclure que plus \_\_\_\_\_\_\_\_ est le SESOI, plus \_\_\_\_\_\_\_\_\_\_ sera l'échantillon nécessaire. Essayez d'expliquer ce phénomène.

- Mettez à nouveau le SESOI = 0.5, ensuite:

  - Augmentez d'abord le type I à 0.15, quelle variation observez vous sur la taille de l'échantillon nécessaire ? Puis diminuez le type I à 0.01, quelle variation observez vous maintenant ?

  - Remettez le type I à 0.05 et augmentez le type II à 0.95, quelle variation observez vous sur la taille de l'échantillon nécessaire ? Diminuez maintenant le type II à 0.6, quelle variation observez vous ?

  - Sur la base de ces changements, la variation de quel type d'erreur influence davantage la taille de l'échantillon ?

## 05 Effectuer une comparaison entre deux moyennes/groupes

Le fichier `05_t-test_single.R` permet de simuler des tests pour comparer deux moyennes/groupes à la recherche d'un effet, ici dans une perspective inter-sujets (i.e. à groupes indépendants). L'hypothèse nulle dans un t-test de ce type correspond le plus souvent à dire qu'il n'y a pas de différence entre les deux moyennes, ou en d'autres termes que l'effet résultant de la soustraction des deux moyennes est égale à 0:

- M(groupe A) = M(groupe B)

- M(groupe A) - M(groupe B) = 0

L'hypothèse alternative peut être:

- M(groupe A) ≠ M(groupe B), ce qui équivaut à une hypothèse non-directionnelle ou bilatérale

- M(groupe A) \> M(groupe B), ce qui équivaut à une hypothèse directionnelle ou unilatérale

- M(groupe A) \< M(groupe B), ce qui équivaut à une hypothèse directionnelle ou unilatérale

Le script permet de faire principalement 4 choses:

1.  Essayer différents paramètres pour le macro-monde des deux groupes (moyennes et écarts types). C'est un mécanisme de rétro-ingénierie, car normalement ces paramètres sont ceux qu'on ne connait pas et qu'on veut justement estimer sur la base de l'expérience.

2.  Montrer graphiquement la dispersion/distribution des données autour de la moyenne du groupe et des intervalles de confiance

3.  Effectuer un test t de Welch (qui n'assume pas l'homogénéité de la variance) et afficher le résultats avec les différents indicateurs (degrés de liberté, résultat du test statistique, p-valeur, taille de l'effet brute et standardisée)

4.  Affichez la p-valeur en fonction de la distribution nulle pour une seuil de l'erreur de type I de 0.05

Adaptez les différents partie du script selon les consignes suivantes et répondez aux questions/réflexions proposées:

- Exécutez progressivement les différentes parties du script avec les paramètres initiaux (M1 = 100, SD1 = 15, M2 = 115, SD2 = 15, Ngroupe = 20) et essayez de répondre aux questions suivantes:

  - Quel type d'hypothèse est testée dans ce script ?

  - À quoi correspond donc l'hypothèse nulle ?

  - Identifiez les résultats du test correspondants respectivement aux degrés de liberté, au résultat du t test statistique, à la p-valeur obtenue, la taille de l'effet brute et standardisée avec les intervalles de confiances à 95%.

  - L'hypothèse nulle (H0) est \_\_\_\_\_ ? L'hypothèse alternative (H1) est \_\_\_\_\_\_ ?

  - Quelle interprétation donneriez-vous de ces résultats ?

- Laissez tous les paramètres inchangés et modifiez le type de test de alternative = "two.sided" à alternative = "less" à la ligne 65. Quelle interprétation donnez-vous maintenant par rapport à H0 et H1 ? Regardez ensuite les indicateurs et comparez-le avec le test précédent. La p-valeur est plus \_\_\_\_\_ ? Pourquoi ? La taille de l'effet est \_\_\_\_\_\_ ? Pourquoi ? Qu'est qui apparaît maintenant dans les intervalles de confiance ? Pourquoi ?

- Enfin, modifiez l'alternative = "greater" et répondez aux mêmes questions.

- Mettez à nouveau l'alternative = "two.sided" et utilisez maintenant les paramètres suivants M1 = 100, SD1 = 15 et M2 = 102, SD2 = 15, ce qui signifie qu'il y a dans le macro-monde une petite différence de 2 points entre les deux moyennes. Utilisez `n_participants_per_groupe = 1000`, donc avec beaucoup de participants pour chaque groupe. Menez le test et observez le résultat. Qu'est-ce que vous pouvez conclure depuis cette simulation ?

- Testez plusieurs combinaisons entre paramètres, par exemple en augmentant ou diminuant la différence entre les deux moyennes ou en explicitant des écarts types plus grands/petits ou hétérogènes entre les deux groupes. Modifiez aussi le nombre de participants par groupe. Notez si vous pensez trouver des _pattern_ qui se manifestent (e.g. si j'augmente \_\_\_\_ alors \_\_\_\_\_\_).

## 06 Simuler plusieurs comparaisons entre moyennes/groupes tirés du même macro-monde

Le fichier `06_test_multiple-simulation.R` est une extension de l'activité précédente qui permet de mener une simulation de 1'000 test _t_ de Welch dont les échantillons sont à chaque fois tirés depuis le même macro-monde. En d'autres termes, la différence du résultat entre un t-test et l'autre dans les 1'000 qui sont simulés est dû exclusivement à l'effet de l'échantillonnage qui crée des variations parmi les moyennes/groupes. Le code du script propose les éléments suivants:

1.  Comme pour le script précédent, il est possible de modifier les paramètres comme les moyennes et écarts types et le nombre d'observations/participants dans l'échantillon

2.  Le code ensuite simule 1'000 t-test sur 1'000 échantillons tirés selon les paramètres du point précédent. Pour chaque test, la _p_-valeur est stocké dans un jeu de données qui contiendra donc 1'000 _p_-valeurs.

3.  Enfin, la distribution des 1'000 p-valeurs obtenues est affichées sous forme d'histogrammes, avec une ligne rouge en tirets qui séparent les _p_-valeurs conventionnellement considérée comme inférieur au seuil alpha = 0.05. Le graphique indique également le pourcentage de _p_-valeurs qui sont inférieures à ce seuil en bas de l'image.

En utilisant le code du fichier, effectuez les manipulations et répondez aux questions suivantes:

- Laissez les valeurs indiquées dans le fichier original (M1 = 100, SD1 = 15; M2 = 115, SD2 = 15; N = 20) et faites les 1'000 simulations. Depuis le graphique que vous obtenez, essayez de mettre en perspective les résultats:

  - Comment expliquez-vous que _seulement_ 86.2% des tests donnent une _p_-valeur \< 0.05 ?

  - Le 13.8% des _p_-valeurs \> 0.05 correspondent à quel type de phénomène dans un test d'hypothèse basé sur un modèle _nul_ ?

- Laissez les valeurs du macro-monde courants et augmentez le nombre de participants de 20 à 30. Lancez la simulation. Combien des _p_-valeurs \< 0.05 observez à ce moment ? Quelle conclusion pouvez-vous en tirer ?

- Modifiez à ce point les caractéristiques du macro-monde pour avoir exactement les mêmes valeurs dans les deux groupes: M1 = M2 = 100; SD1 = SD2 = 15. Laissez 30 participants par groupe et lancez la simulation. Sur la base du résultat, vous pouvez conclure que: quand il n'y a pas d'effet dans le macro-monde, la distribution des _p_-valeurs est \_\_\_\_\_\_\_\_\_\_. Quelles sont à votre avis les implications de ce fait, notamment en relation avec la problématique de la replicabilité des résultats en sciences sociales ?

## 07 Équivalence entre deux moyennes/groupes

Le fichier `07_t-test_equivalence.R` diffère des fichiers sur le test _t_ précédents car ici l'enjeu n'est pas de détecter la présence d'un effet entre les deux moyennes/groupes, mais plutôt établir qu'il n'existe pas de différence. En effet, obtenir une _p_-valeur \> alpha (e.g. 0.05) ne signifie par qu'il n'y a pas de différence: _Absence of Evidence Is Not Evidence of Absence_. Or, pour définir l'absence d'un effet il y a deux problématique à considérer:

1.  Techniquement, même si dans le macro-monde il n'y a aucune différence entre les moyennes/groupes, dû au phénomène de l'échantillonnage il est pratiquement impossible que la différence entre deux moyennes soit précisément de 0 (i.e. M1 - M2 == 0). Il est beaucoup plus probable que la différence sera normalement distribuée autour de 0, mais avec des variations plus ou moins prononcées.

2.  Sémantiquement, selon le contexte spécifique de la recherche (i.e. connaissances du domaine), les chercheurs peuvent considérer comme _négligeable_ une différence aussi plus grande de +/- 0. Par exemple, les chercheurs pourraient considérer que si la différence est inférieur à +/- 10 unités sur l'échelle de la VD, alors on peut considérer qu'il y a sémantiquement _absence_ d'un effet qui a des implications théoriques/pratiques, même si mathématiquement l'effet n'est pas 0.

Pour effectuer un test d'équivalence il faut donc établir les limites inférieur et supérieurs d'un effet, ce qui peut se faire en taille brute selon l'échelle de la VD ou en taille standardisée (e.g. Cohen's d).

Le test d'équivalence peut être effectué avec un test _classique_ qui cherche de détecter la présence d'un effet. À ce moment, on peut avoir 4 résultats possibles:

- Le test d'équivalence et le test _classique_ donnent une p-valeur \> alpha. Dans ce cas, on ne peut ni corroborer, ni rejeter la présence ou l'absence d'un effet.

- Le test d'équivalence donne une p-valeur \< alpha, et le test classique une p-valeur \> alpha. Dans ce cas, on peut corroborer l'hypothèse qu'il n'existe pas un effet supérieur ou inférieur au SESOI et que l'effet peut potentiellement être de 0 (car le test classique est \> alpha).

- Le test d'équivalence donne une p-valeur \> alpha, et le test classique une p-valeur \< alpha. Dans ce cas, on peut corroborer l'hypothèse qu'il existe un effet supérieur ou inférieur au SESOI.

- Le test d'équivalence et le test _classique_ donnent une p-valeur \< 0.05. Ce ci semble un paradoxe, s'explique en réalité par le fait que l'effet peut-être dans les limites inférieurs et supérieurs des SESOI, mais en même temps être différent de 0. Dans ce cas on peut donc corroborer l'hypothèse que la différence entre les deux moyennes ne dépasse pas les limites, mais que les deux moyennes ne sont potentiellement pas _strictement_ équivalentes (e.g. avec une différence de 0).

En modifiant les paramètres du script (moyennes et écarts types ainsi que le nombre de participant-es), tester différentes cas de figures et essayez de déterminer à quelle cas de figure correspond le résultat parmi les quatre possibilités.

## 08 Puissance statistique pour une ANOVA simple

Lorsque le plan expérimental prévoit une seule variable indépendante (VI) mais avec plus de deux modalités, on utilise une Analyse de la Variance (ANOVA) dites _simple_ ou _One-way ANOVA_ an anglais. Le fichier `08_anova-one-way_power.R` permet d'effectuer une analyse de puissance statistique pour déterminer l'échantillon nécessaire à détecter un effet dans la comparaison des trois ou plusieurs moyennes/groupes. La présence de 3 ou plusieurs moyennes/groupes nécessite aussi d'un type de mesure de la taille de l'effet différente au Cohen's d lorsqu'on a à faire avec deux moyennes/groupes, comme par exemple le Cohen's f qui généralise à plusieurs moyennes/groupes. Les détails de ce passage sont trop techniques pour le contexte introductif du cours, mais le script peut néanmoins donner une idée des échantillons nécessaires pour mener des ANOVA simple informatives.

En variant les paramètres du fichier, essayez de répondre aux questions suivantes:

- En utilisant les paramètres de base k = 3, alpha = 0.05 et puissance 0.8, combien d'entités/participant-es sont nécessaires par groupes avec un SESOI de Cohen's f = 0.25 ?

- Modifiez le paramètre k = 5 pour augmenter le nombre de modalités de la VI en laissant les autres paramètres pareils. Quelle est la nouvelle valeur de N ? Essayez d'expliquer ce mécanisme.

## 09 Effectuer une comparaison entre trois moyennes/groupes (ou plus)

Le fichier `09_anova-one-way_test.R` permet d'effectuer des ANOVA _simples_ ou _One-Way ANOVA_ à l'occurrence avec trois moyennes/groupes, mais le principe peut être élargie à _k_ moyennes/groupes du moment où une seule VI est impliquée. Dans une ANOVA _simple_ on distingue généralement entre deux types de tests:

- L'_omnibus ANOVA_, c'est-à-dire le test entre toutes les moyennes/groupes impliqués, qui sert généralement à identifier l'effet général de la VI sur la VD et, parfois, est utilisé pour déterminer si faire des comparaisons/contrastes ultérieurs (voir point suivant). L'hypothèse nulle qui est posée dans l'_omnibus_ ANOVA consiste dans l'égalité des toutes les moyennes/groupes impliquées dans le test. En termes formels, M1 = M2 = M3 ... = M*k.* L'hypothèse alternative est favorisée lorsqu'au moins deux moyennes/groupes sont différentes. Dans une ANOVA à 3 groupes, cela signifie donc qu'au moins l'une de ces conditions s'avère:

  - M1 ≠ M2

  - M1 ≠ M3

  - M2 ≠ M3

- Des comparaisons/contrastes entre des moyennes/groupes spécifiques. Ces comparaisons ou contrastes peuvent être spécifiés avant de voir les données, comme partie par exemple d'une hypothèse théorique/opérationnelle, ou une fois les données observées (i.e., _post-hoc_). Comme pour le test t, les hypothèses à ce stade peuvent être directionnelles ou non-directionnelles.

Dans le passé, il y avait la tendance à effectuer des comparaisons/contrastes seulement si le résultat du _omnibus_ test était \< alpha. Aujourd'hui il y a plutôt la tendance, surtout dans une perspective test d'hypothèse, de planifier à l'avance les comparaisons/contrastes ou des les effectuer _post-hoc_ selon l'intérêt pratique/théorique et indépendamment du résultat du test _omnibus_.

Le script est organisé en 6 sections principales:

1.  Les paramètres des données simulées permettent de déterminer les moyennes, écarts types et nombre d'entités/participant-es dans 3 modalités/conditions expérimentales

2.  Les données sont ensuite affichées graphiquement pour comprendre la distribution des observations autours des moyennes des conditions/groupes

3.  L'_omnibus_ test est effectué à travers le paquet `afex` utilisé souvent dans des analyses de type ANOVA. Le résultat est affiché en forme de tableau ANOVA avec le _generalised effect size_ (ges) comme taille de l'effet. Par exemple:

    | Effect | df    | MSE    | F     | ges  | p.value |
    | :----- | :---- | :----- | :---- | :--- | :------ |
    | groupe | 2, 57 | 216.14 | 21.91 | .435 | \<.001  |

4.  L'affichage de la p-valeur observée en fonction du modèle _nul_. Le modèle nul correspond à l'hypothèse que **toutes** les moyennes sont les mêmes (e.g. M1 = M2 = M3 ... = M*k*).

5.  Le respect des postulats de l'ANOVA. Pour que le test puisse être considéré fiable, il est nécessaire que certaines conditions soient respectées.

6.  Les comparaisons entre les trois moyennes en utilisant le paquet `emmeans`. La comparaison permet de dire parmi les moyennes lesquelles diffèrent suffisamment pour établir qu'il y a un effet de la VI sur la VD au niveau de ces groupes. Chaque comparaison a sa propre p-valeur qui est corrigée pour éviter de _gonfler_ l'erreur de type I (plus de tests on fait, plus on a la probabilité d'avoir des résultats \< alpha seulement à cause de l'effet d'échantillonnage). Par exemple:

    | contraste |  estimate |       SE |  df |   t.ratio | p.value |
    | :-------- | --------: | -------: | --: | --------: | ------: |
    | A - B     | -13.46438 | 4.649127 |  57 | -2.896109 |  0.0146 |
    | A - C     | -30.69853 | 4.649127 |  57 | -6.603073 | \<0.001 |
    | B - C     | -17.23415 | 4.649127 |  57 | -3.706964 |   0.001 |

En utilisant le script, essayez de répondre aux questions suivantes:

- En laissant les données disponibles de base dans le fichier, observez les différentes représentations textuelles et graphiques et essayez de repérer toutes les informations importantes. Quel est le résultat du _omnibus_ test ? Quels sont les résultats des comparaisons ? Concentrez-vous ensuite sur les postulats: sont-ils respectés à votre avis ?

- Modifiez les paramètres pour le groupe C afin qu'il ait la même moyenne (M = 115) et écart type (SD = 15) du groupe B. Vous avez donc le groupe A qui est tiré d'un macro-monde avec une moyenne inférieure aux groupes B et C, qui au contraire sont tirés du _même_ macro-monde. Quel est l'effet sur le _generalised effect size_ ? Que se passe-t-il au niveau des comparaisons ?

## 10 Effectuer une ANOVA avec une autre variable (ANCOVA)

Dans la littérature expérimentale en sciences sociales on a souvent des tests appelés ANCOVA, acronyme de Analyse de Co-Variance, mais en réalité il s'agit toujours de l'application du modèle linéaire. Le principe d'un point de vue scientifique est d'ajouter à la VI de l'ANOVA un co-varié, c'est-à-dire une variable continue mesurée de la même manière pour toutes les entités/participant-es soumis-es à la VI. Il existe dans l'utilisation de l'ANCOVA souvent des mauvaises interprétations sur l'utilité de cette action. On parle notamment de _contrôler_ pour cette variable. D'un point de vue causale, ce mécanisme se justifie lorsqu'on sait du modèle scientifique que ce co-varié peut influencer la VD. En utilisant la régression linéaire, on peut a ce moment _diviser_ l'effet de la VI de l'effet du co-varié, pour tester quel est l'effet de la VI en moyennant sur les différents valeurs du co-varié. L'explication technique de ce passage dépasse le cadre introductif du cours et l'ANCOVA est présentée ici car elle est souvent citée dans les articles scientifiques.

Le fichier `10_anova_oneway_with-other-variable.R` permet de simuler une ANCOVA avec une seule VI comme dans l'ANOVA _simple_, plus un co-varié qui est simulé avec un rapport avec la VD. Ce rapport mathématique est influencé par du _bruit_ qu'on peut paramétrer. En utilisant le script:

- Effectuez d'abord le test avec les données disponibles dans le script et essayé d'interpréter les résultats, notamment en fonction au tableau de l'ANOVA _simple_ du point précédent

- Modifiez le _bruit_ de la variable `z` à travers le script. Plus de bruit signifie que la variable z et la VD sont moins en relation l'une avec l'autre. Que se passe-t-il au niveau des résultats lorsque vous augmentez le bruit ? Comment expliqueriez-vous ce résultat ?

## 11 Puissance statistique d'une ANOVA factorielle

Un autre type de test qui est souvent utilisé dans la littérature expérimentale en sciences sociales est l'ANOVA factorielle qui résulte de l'implémentation de deux VI ou plus. L'ANOVA factorielle peut se décliner également sous forme d'ANCOVA, car il s'agit encore une fois du même modèle linéaire.

Lorsqu'on ajoute une deuxième (ou plus) VI, la complexité du modèle augmente de manière exponentielle. On peut prendre à exemple le cas d'une ANOVA factorielle dite 2x2, très commune en sciences sociales, c'est-à-dire un ANOVA avec deux VI, chacune avec deux modalités. Par exemple on peut imaginer un plan expérimentale inter-sujets avec:

- Une VI qui détermine la présence (Avec) ou l'absence (Sans) d'un dispositif numérique de soutien à une tâche d’apprentissage

- Une VI qui détermine le niveau de difficulté de la tâche (Faible ou Forte)

Il en résulte un plan avec 4 conditions possibles en croisant les deux VI:

1.  Avec dispositif / Difficulté faible

2.  Avec dispositif / Difficulté forte

3.  Sans dispositif / Difficulté faible

4.  Sans dispositif / Difficulté forte

Or, dans ce cas de figure, le test statistique peut s'intéresser:

- À les 6 comparaisons possibles entre les 4 conditions. C'est ce qu'on appelle des **effets simples**

- Au deux effets des VI singulièrement, c'est-à-dire indépendamment/en moyennant l'autre VI. C'est ce qu'on appelle des **effets principaux**:

  - est-ce que la présence/absence du dispositif a un effet indépendamment de la difficulté de la tâche ?

  - est-ce que la difficulté de la tâche a un effet indépendamment de la présence/absence du dispositif ?

- À ce qu'on appelle l'**effet d'interaction/modération** entre les deux VI, par exemple: est-ce que l'effet du dispositif est plus grand/petit si la difficulté de la tâche est faible plutôt que forte ?

Pour déterminer la taille de l'échantillon nécessaire à une ANOVA factorielle il faut donc établir à l'avance à quel phénomène/type de test on s'intéresse en particulier: les effets simples, les effets principaux ou l'effet d'interaction ? En général, les effets d'interactions nécessitent de beaucoup plus d'observations/participant-es. De plus, les effets d'interactions sont souvent mal compris par les chercheurs. En tout cas, pour déterminer la taille de l'échantillon, on utilise des simulations sur la base des moyennes et écarts types attendus pour les 4 conditions expérimentales. Le fichier `11_anova-factorial_power.R` permet d'effectuer ces simulations à l'aide du paquet Superpower de R. Utilisez le script pour répondre aux questions suivantes:

- Laissez les paramètres de base du script et effectuer la simulation de la puissance statistique. Quelle est la puissance statistique pour les différents effets (simples, principaux et interaction) ?

- Modifiez comme vous voulez les 4 moyennes des conditions expérimentales et menez à nouveau les simulations. Quels patterns pouvez-vous identifier ?

## 12 Effectuer une ANOVA factorielle

Le fichier `12_anova-factorial_test.R` permet de mener des ANOVA 2x2 avec des données simulées. La complexité d'ajouter une deuxième VI et l'effet d'interaction dans un test se traduit également dans des résultats plus compliqués à interpréter, notamment au niveau des comparaisons entre conditions expérimentales. On peut synthétiser l'interprétation des résultats avec une sorte d'algorithme décisionnel qui dépend du résultat de l'effet d'interaction:

- Si l'effet d'interaction est détecté avec p-valeur \< alpha, alors on s'intéresse aux effets simples, car les effets principaux sont influencés par l'interaction/modération d'une VI sur l'autre

- Si l'effet d'interaction n'est pas détecté avec p-valeur \> alpha, alors on s'intéresse aux effets principaux des VI

On peut déterminer s'il existe des effets principaux et/ou d'interaction de manière intuitive grâce aux moyennes des conditions expérimentales à travers ce qu'on appelle les **moyennes marginales** (MM), car elles figurent sur les marges d'un tableau. Par exemple:

|                | VI2 - Faible | VI2 - Forte | _VI1 - MM_ |
| :------------: | :----------: | :---------: | :--------: |
| **VI1 - Sans** |      10      |     20      |    _15_    |
| **VI1 - Avec** |      15      |     35      |    _25_    |
| **_VI2 - MM_** |    _12.5_    |   _27.5_    |            |

Les moyennes marginales sont simplement les moyennes des lignes et colonnes d'un tableau avec les moyennes des conditions expérimentales. À travers ces moyennes on peut déterminer en tant que _rule of thumb_:

- La présence d'un effet principal de la VI1 si la différence (absolue) entre les moyennes marginales de cette VI1 (donc la toute dernière colonne sur la droite) n'est pas 0. Dans l'exemple nous avons 15 - 25 = \|10\|

- La présence d'un effet principal de la VI2 si la différence (absolue) entre les moyennes marginales de cette VI2 (donc la toute dernière ligne en bas) n'est pas 0. Dans l'exemple nous avons 12.5 - 27.5 = \|15\|

- La présence d'un effet d'interaction si la différence entre les moyennes marginales de la VI1 (donc 15 - 25) n'est pas égale à la différence entre les moyennes marginales de la VI2 (donc 12.5 - 27.5). Dans ce cas nous avons \|10\| et \|15\|, ce qui suggère la présence d'un effet d'interaction.

Il en résulte qu'on peut obtenir potentiellement 8 combinaisons possibles depuis une ANOVA factorielle 2x2:

|     | Effet principal VI1 | Effet principal VI2 | Effet d'interaction |
| --- | :------------------ | :------------------ | :------------------ |
| 1   | Non                 | Non                 | Non                 |
| 2   | Non                 | Non                 | Oui                 |
| 3   | Non                 | Oui                 | Non                 |
| 4   | Non                 | Oui                 | Oui                 |
| 5   | Oui                 | Non                 | Non                 |
| 6   | Oui                 | Non                 | Oui                 |
| 7   | Oui                 | Oui                 | Non                 |
| 8   | Oui                 | Oui                 | Oui                 |

En utilisant le script, essayez de répondre aux questions suivantes:

- Avec les données de base du script, effectué le test de l'ANOVA et regardez le tableau avec les effets principaux et d'interaction.

  - Est-ce que l'effet d'interaction et détecté ou non ? Regardez également le graphique pour vous aider dans la décision.

  - Selon la réponse, menez les comparaisons successives en accord avec le résultat du test de l'interaction.

  - Essayez de comprendre les différents indicateurs et de donner du sens aux résultats. Que signifie-t-il un effet d'interaction dans ce cas ? Qu'est-ce que les comparaisons successives nous disent ?

- Modifiez les 4 moyennes des conditions expérimentales selon vos choix et essayez de reproduire le même mécanisme du point précédent: tester pour l'interaction et effectuez ensuite les comparaisons correspondantes.

- À votre avis, qu'est-ce qu'il faudrait faire dans le cas où il n'y a aucun effet (ni effets principaux, ni interaction) ?

## 13 Modèle multi-niveaux

Le fichier `13_modele-multiniveaux.R` propose une modélisation plus avancée qui tient compte par exemple d'éléments hiérarchiques (e.g. classes, binômes, ...) ou à mesure répétée. Pour plus d'informations voir par exemple [l'article de Brown (2021)](https://journals.sagepub.com/doi/full/10.1177/2515245920960351) disponible aussi dans les ressources supplémentaires.

## 14 Méta-analyse

Le fichier `14_meta-analysis.R` propose un exemple de méta-analyse sur des expériences prévoyant deux groupes (e.g. groupe contrôle vs. traitement). Il est donné à titre d'exemple, vous pouvez modifier les différentes valeurs des expériences ou insérer des données depuis des articles de méta-analyses publiés.

## Réponses

[Les réponses aux questions sont disponibles dans un fichier séparé.](https://github.com/mafritz/methodo-exp-2223/blob/main/fondements-statistiques/scripts-workshop/solutions-workshop.md)
