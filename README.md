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

## Modèle Conceptuel de Données (MCD)

Le **MCD** représente la structure conceptuelle de notre base de données pour le suivi du renouvellement des bancs du parc public. Il identifie les **4 entités principales** et leurs **relations**, basées sur l'analyse des fichiers Excel fournis.

### Description des entités

| Entité       | Attributs principaux                  | Rôle dans le projet |
|--------------|---------------------------------------|---------------------|
| **Fournisseurs** | PKd (id), Entreprise, Téléphone, Email, Rémarques | Référence des fournisseurs de bancs/matériel |
| **Inventaire** | PKd (id), Type, Matériau, Latitude, Longitude, État | Suivi des bancs installés dans le parc |
| **Interventions** | PKd (id), Date, Objet intervention, Technicien, Matériel utilisé, Rémarques | Historique des actions de maintenance/renouvellement |
| **Signalements** | PKd (id), Date, Description, Statut | Rapports citoyens sur l'état des bancs |

### Relations entre entités
- **Fournisseurs** → **Inventaire** : Un fournisseur peut livrer plusieurs bancs (relation 1,n).
- **Inventaire** → **Interventions** : Un banc peut faire l'objet de plusieurs interventions (relation 1,n).
- **Interventions** → **Signalements** : Une intervention peut résulter d'un ou plusieurs signalements (relation n,1). *Note : "Si possible détecter un problème → intervention"*.

### Annotations et décisions prises
Nos observations sur les données Excel nous ont conduits à ces ajustements :
- **Fusion des fournisseurs** : Éviter les doublons en normalisant les noms d'entreprises.
- **Géolocalisation précise** : Latitude/longitude obligatoires pour cartographier les bancs.
- **Statut des signalements** : Ajout pour suivre l'évolution (ouvert/clos/en cours).
- **Lien intervention-signalement** : Permet de tracer les actions correctives depuis les rapports citoyens.

Ce MCD a servi de base pour passer au **MLD** (normalisation 3NF) puis au **MPD** (implémentation PostgreSQL via Docker).

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
Nous avons pris le temps de **vérifier une dernière fois le  et le MLD**, afin de s’assurer de leur cohérence.  
Ensuite, nous avons **commencé la rédaction du MPD (Modèle Physique de Données)**.
Voici une section **Markdown complète** pour ton fichier **README.md**, dédiée au **MLD (Modèle Logique de Données)**. Elle documente le diagramme de manière claire et professionnelle, en continuité avec la section MCD précédente. Colle-la juste après !

***

## Modèle Logique de Données (MLD)

Le **MLD** affine le MCD en **normalisant les tables** (forme normale 3NF) et en définissant les **clés primaires (PK)** et **clés étrangères (FK)** pour l'implémentation relationnelle. Il intègre les corrections issues de l'analyse des données Excel (suppression des doublons, normalisation des types).


### Structure des tables

| Table          | Clés primaires (PK) | Clés étrangères (FK)                  | Attributs principaux |
|----------------|---------------------|----------------------------------------|----------------------|
| **contact**   | id_contact         | -                                      | nom, prénom, téléphone, email |
| **fournisseur**| id_fournisseur    | fk_contact, fk_type_materiau          | nom_entreprise, remarques |
| **inventaire**| id_inventaire     | fk_fournisseur, fk_type_materiau, fk_etat | type, latitude, longitude, etat |
| **signalement**| id_signalement   | fk_inventaire                         | date, description, statut |
| **intervention** | id_intervention | fk_signalement, fk_type_materiau      | date, technicien, materiel_utilise, problemes |

### Relations logiques
- **1,n : Fournisseur → Inventaire** : Un fournisseur peut avoir plusieurs bancs en inventaire.
- **1,n : Inventaire → Signalement** : Un banc peut générer plusieurs signalements citoyens.
- **1,n : Signalement → Intervention** : Un signalement peut déclencher plusieurs interventions.
- **n,n : Type_matériau** (table de liaison) : Gère les associations multiples (ex. : un banc utilise plusieurs matériaux).

### Améliorations apportées par rapport au MCD
- **Séparation Contact/Fournisseur** : Évite les doublons en isolant les infos personnelles des entreprises.
- **Types de matériaux normalisés** : Table de référence pour éviter les incohérences (ex. : "bois" vs "Bois").
- **États standardisés** : Pour l'inventaire (bon/à rénover/HS).
- **Géolocalisation** : Coordonnées précises pour mapping futur des bancs.

Ce MLD a été validé lors du **Jour 4** et sert de base pour le **MPD** (scripts SQL de création).

***

## Jour 4 — 13 mars 2026

Nous avons **terminé la rédaction du MPD**, qui correspond à nos choix et à la structure souhaitée pour la base de données.  
Nous avons ensuite entamé le **nettoyage des données** contenues dans les fichiers Excel.  
Certaines tables présentaient des **attributs incohérents, en double ou mal orthographiés**, ce qui entraînait des erreurs lors de la création de la base de données.

Pour faciliter ce nettoyage :
- Nous avons **exporté les fichiers Excel au format CSV**, afin d’obtenir des données plus lisibles et exploitables par VS Code.  
- Nous avons ensuite **créé la phase de “staging”**, qui nous permet d’intégrer progressivement les données dans la base et les tables de manière structurée.

***
