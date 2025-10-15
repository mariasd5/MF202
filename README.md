# Projet MF202 – Étude thermique d’une tuyère de moteur-fusée
## Auteurs : Maria Saad, Thomas Lefert, Eva Jaillon et Vincent Lartaud

## Contexte du projet
Ce projet a été réalisé dans le cadre du module MF202 – Transferts thermiques et massiques dans les fluides. 
L’objectif est de modéliser le comportement thermique d’une tuyère de moteur-fusée soumise à des températures extrêmes lors de la combustion, 
et d’évaluer l’efficacité des systèmes de refroidissement (régénératif et radiatif).

La tuyère, partie essentielle du moteur-fusée, est soumise à un flux thermique intense pouvant atteindre plusieurs milliers de kelvins. 
La gestion de ce flux est donc cruciale pour éviter la dégradation des matériaux et assurer la performance du moteur.

## Objectifs
- Modéliser la diffusion thermique dans la paroi d’une tuyère.
- Intégrer les effets de convection et rayonnement.
- Étudier différents types de conditions aux limites (adiabatiques, convectives, radiatives).
- Simuler et visualiser les champs de température sous MATLAB.
- Comparer les résultats à des configurations réelles de refroidissement de moteurs-fusées.

## Méthodologie

### 1. Modélisation physique
L’étude repose sur l’équation de la chaleur en régime transitoire :
ρ c_p ∂T/∂t = k ∇²T

Les conditions aux limites sont :
- Adiabatique : aucun flux de chaleur sortant.  
- Convection + Rayonnement :
  -k ∂T/∂n = h(T - T_air) + εσ(T⁴ - T_ext⁴)

Ces équations sont discrétisées selon un schéma explicite ou semi-implicite pour une résolution numérique pas à pas.

### 2. Implémentation MATLAB
Les fonctions principales du projet :
- `code_simu_base.m` : script principal lançant la simulation.
- `calcul_temperature.m` : calcul de la température à chaque itération.
- `est_coin.m` : identification des points frontières du domaine.
- `modifie_coin.m` : gestion des conditions limites (coins et bords).
- `color_gradient_v2.mat` : palette de couleurs pour la visualisation.

## Exécution
1. Ouvrir MATLAB.
2. Placer le dossier `Projet MF202 groupe fusée` dans le répertoire de travail.
3. Exécuter `code_simu_base.m`
4. Le programme :
   - Définit les constantes physiques (ρ, cp, k, ε, σ, h, etc.)
   - Assemble les matrices du modèle.
   - Résout l’équation de diffusion thermique à chaque pas de temps.
   - Affiche la carte de température et son évolution dans le temps.

## Résultats

### Simulation numérique
La simulation montre le gradient thermique à travers la paroi de la tuyère.  
Les zones les plus chaudes se trouvent à proximité du gaz brûlant, tandis que le refroidissement régénératif ou radiatif réduit progressivement la température vers l’extérieur.


## Analyse et conclusion
Les résultats montrent que :
- Le refroidissement régénératif permet une chute de température significative dans la paroi interne.
- Le refroidissement radiatif est efficace sur les zones externes.
- Le modèle prédit des gradients thermiques cohérents avec la littérature et les observations de moteurs réels.


## Outils utilisés
- MATLAB
- Méthode des différences finies / éléments finis
- Concepts : transfert thermique, convection, rayonnement, schémas explicites



## Structure du dépôt
```
Projet MF202 groupe fusée/
│
├── code_simu_base.m
├── calcul_temperature.m
├── est_coin.m
├── modifie_coin.m
├── color_gradient_v2.mat
└── README.md
```
