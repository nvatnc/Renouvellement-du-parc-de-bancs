# Projet : Création d’une infrastructure de données  
### Sujet : Renouvellement des bancs dans le parc public  

## Jour 1 — 20 février 2026

Notre groupe a pour mission de **concevoir et gérer l’infrastructure des données** liée au **renouvellement des bancs dans le parc public**.  
La responsable du service technique (notre enseignante) nous a fourni les fiches de données nécessaires au projet, disponibles sous forme de **fichiers Excel**.

Nous avons commencé par **analyser les quatre fichiers Excel** remis :
- **Fournisseurs**
- **Inventaires**
- **Interventions**
- **Signalements**

Chaque table contient plusieurs attributs. Pour identifier ceux qui nous seraient utiles, nous avons sélectionné les éléments les plus pertinents pour notre objectif : le suivi du renouvellement des bancs.

Ensuite, nous avons :
- **Créé un MCD (Modèle Conceptuel de Données)** afin de visualiser la structure des données.
- **Élaboré un MLD (Modèle Logique de Données)** pour normaliser et corriger les tables et leurs relations.
- **Nettoyé et ajusté les données** selon les observations faites durant notre analyse initiale.

Enfin, nous avons :
- Créé notre **dépôt GitHub** et ajouté un **fichier README** pour documenter le projet.  
- Poursuivi avec la **rédaction du MLD**, en intégrant les ajustements issus du MCD.

***

## Jour 2 — 27 février 2026

Lors de cette journée, nous avons **finalisé le MLD** et consolidé notre compréhension de **Git**.  
Nous avons ensuite **initialisé le projet** en y intégrant les **données (fichiers Excel)** fournies au départ.

Les étapes réalisées :
- Création du fichier **`docker-compose.yml`** pour configurer l’environnement du projet.  
- Mise en place du dossier **`initdb`**, dans lequel nous avons commencé la rédaction du **MPD (Modèle Physique de Données)**.  
- Réalisation des **commits** et **synchronisation du dépôt Git** afin de conserver une trace de toutes les modifications.

***

## Jour 3 — 6 mars 2026

Cette journée a été plutôt calme, car nous étions **en avance sur le planning**.  
Nous avons pris le temps de **vérifier une dernière fois le MCD et le MLD**, afin de s’assurer de leur cohérence.  
Ensuite, nous avons **commencé la rédaction du MPD (Modèle Physique de Données)**.

***

## Jour 4 — 13 mars 2026

Nous avons **terminé la rédaction du MPD**, qui correspond à nos choix et à la structure souhaitée pour la base de données.  
Nous avons ensuite entamé le **nettoyage des données** contenues dans les fichiers Excel.  
Certaines tables présentaient des **attributs incohérents, en double ou mal orthographiés**, ce qui entraînait des erreurs lors de la création de la base de données.

Pour faciliter ce nettoyage :
- Nous avons **exporté les fichiers Excel au format CSV**, afin d’obtenir des données plus lisibles et exploitables par VS Code.  
- Nous avons ensuite **créé la phase de “staging”**, qui nous permet d’intégrer progressivement les données dans la base et les tables de manière structurée.

***
