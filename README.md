# Projet : Création d'une infrastructure de données

## Sujet : Renouvellement des bancs dans le parc public

## Présentation du projet

Ce projet a pour objectif de concevoir et mettre en place une infrastructure de données permettant le suivi du renouvellement des bancs d'un parc public.

Les données nécessaires au projet ont été fournies sous la forme de plusieurs fichiers Excel contenant des informations relatives aux fournisseurs, aux bancs installés, aux interventions réalisées et aux signalements effectués par les usagers.

L'ensemble du travail a consisté à analyser ces données, les modéliser, les nettoyer, puis les intégrer dans une base de données PostgreSQL déployée dans un environnement Docker.

---

# Analyse des données

Nous avons commencé par étudier les différents fichiers Excel mis à disposition :

* Fournisseurs
* Inventaires
* Interventions
* Signalements

Cette phase d'analyse nous a permis :

* d'identifier les données pertinentes pour le projet ;
* de comprendre les relations entre les différentes informations ;
* de repérer les incohérences et les données à corriger ;
* de préparer la modélisation de la future base de données.

---

# Modèle Conceptuel de Données (MCD)

Le MCD représente la structure générale de la base de données et les relations entre les principales entités du projet.

## Entités principales

| Entité        | Attributs principaux                                     | Description                                        |
| ------------- | -------------------------------------------------------- | -------------------------------------------------- |
| Fournisseurs  | id, entreprise, téléphone, email, remarques              | Référence les fournisseurs de bancs et de matériel |
| Inventaire    | id, type, matériau, latitude, longitude, état            | Recense les bancs présents dans le parc            |
| Interventions | id, date, objet, technicien, matériel utilisé, remarques | Historique des opérations réalisées                |
| Signalements  | id, date, description, statut                            | Signalements effectués par les usagers             |

## Relations

* Un fournisseur peut fournir plusieurs bancs.
* Un banc peut faire l'objet de plusieurs interventions.
* Un banc peut recevoir plusieurs signalements.
* Un signalement peut conduire à une ou plusieurs interventions.

---

# Modèle Logique de Données (MLD)

Le MLD traduit le modèle conceptuel en structure relationnelle normalisée.

Le fichier contenant le MLD sous format png se trouve dans le dossier schema.

## Relations logiques

* Fournisseur → Inventaire (1,N)
* Inventaire → Signalement (1,N)
* Signalement → Intervention (1,N)

## Normalisation

Les principales améliorations apportées sont :

* séparation des informations de contact et des fournisseurs ;
* normalisation des matériaux ;
* standardisation des états des bancs ;
* suppression des redondances de données.

---

# Modèle Physique de Données (MPD)

Le MPD correspond à l'implémentation de la base de données PostgreSQL.

Fournisseurs 0...* – 1 Inventaire
Inventaire 0...* – 1...* Interventions
Inventaire 0...* – 1...* Signalements
Interventions 0...1 – 0...* Signalements

## Exemple de script SQL

```sql
CREATE TABLE type_materiau (
    id_type SERIAL PRIMARY KEY,
    nom_materiau VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE inventaire (
    id_inventaire SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    latitude NUMERIC(9,6) NOT NULL,
    longitude NUMERIC(9,6) NOT NULL,
    etat VARCHAR(20) DEFAULT 'bon',
    fk_fournisseur INTEGER REFERENCES fournisseur(id_fournisseur),
    fk_type_materiau INTEGER REFERENCES type_materiau(id_type)
);
```

## Optimisations

* utilisation de types adaptés aux données ;
* mise en place des clés étrangères ;
* préparation à l'utilisation de PostGIS ;
* chargement des données via fichiers CSV.

---

# Nettoyage des données

Avant l'intégration dans la base de données, un important travail de préparation des données a été réalisé.

Les actions effectuées comprennent :

* conversion des fichiers Excel au format CSV ;
* suppression des doublons ;
* correction des fautes de saisie ;
* harmonisation des formats ;
* vérification des valeurs manquantes ;
* contrôle de la cohérence entre les tables ;
* nettoyage des différentes tables afin de garantir l'intégrité des données avant leur import ;
* l'ajout des rôles.

Cette étape a permis de disposer d'un jeu de données fiable et exploitable pour la suite du projet.

---

# Environnement technique

Le projet s'appuie sur les technologies suivantes :

* Docker
* Git
* GitHub
* Visual Studio Code

---

# Organisation du dépôt

```text
.
├── data/
│   ├── fournisseur_inventaire.csv
│   ├── fournisseurs_contacts.csv
│   ├── inventaire_mobilier.csv
│   ├── interventions.csv
│   └── signalements.csv
│
├── excel/
│   ├── fournisseur_inventaire.xlsx
│   ├── fournisseurs_contacts.xlsx
│   ├── inventaire_mobilier.xlsx
│   ├── interventions.xlsx
│   └── signalements.xlsx
│
├── initdb/
│   ├── 01-schema.sql
│   ├── 02-staging.sql
│   ├── 03-explore.sql
│   ├── 04-clean.sql
│   └── 05-roles.sql
│
├── schema/
│   ├── MLD.png
│
├── docker-compose.yml
└── README.md
```

---

# Résultat

Le projet aboutit à une infrastructure de données complète permettant :

* le suivi des bancs du parc ;
* la gestion des fournisseurs ;
* le traitement des signalements ;
* le suivi des interventions.
