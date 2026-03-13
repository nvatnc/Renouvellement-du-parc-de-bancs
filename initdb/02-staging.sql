-- initdb/02-staging.sql

CREATE SCHEMA IF NOT EXISTS staging;

-- Exemple pour inventaire_mobilier — reproduire pour les 3 autres tables
CREATE TABLE staging.inventaire_mobilier (
    id TEXT, type TEXT, materiau TEXT, lieu TEXT,
    latitude TEXT, longitude TEXT,
    date_installation TEXT, etat TEXT, remarques TEXT
);

CREATE TABLE staging.fournisseurs_contacts (
    id TEXT, type TEXT, entreprise TEXT, contact TEXT,
    telephone TEXT, email TEXT,
    type_materiel TEXT, remarques TEXT
);

CREATE TABLE staging.interventions (
    id TEXT, type TEXT, a TEXT, objet TEXT, 
    type_intervention TEXT, technicien TEXT,
    duree TEXT, cout_materiel TEXT, remarques TEXT 
);
#a cest la date comment faire
CREATE TABLE staging.signalements (
    id TEXT, type TEXT, date TEXT, signale_par TEXT,
    objet TEXT, description TEXT,
    urgence TEXT, statut TEXT, remarques TEXT
);
#date ? cest la date comment faire
-- ... (signalements, interventions, fournisseurs)

-- Import CSV — data/ est monté sous /data/ dans le conteneur
COPY staging.inventaire_mobilier
FROM '/data/inventaire_mobilier.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ... (répéter pour les 3 autres fichiers)