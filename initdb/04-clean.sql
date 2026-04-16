-- Active: 1774608706951@@127.0.0.1@5438@renbancs
-- Active: 1774608706951@@127.0.0.1@5438@renbancs
CREATE EXTENSION IF NOT EXISTS unaccent;

-- Inventaire mobilier

INSERT INTO public.type_inventaire (libelle)
SELECT * FROM (
SELECT DISTINCT
CASE
    WHEN lower(trim("type")) LIKE '%banc%'  then 'banc'
    WHEN lower(trim("type")) LIKE '%lampadaire%' then 'lampadaire'
    WHEN lower(trim("type")) LIKE '%poubelle%' then 'poubelle'
    WHEN lower(trim("type")) LIKE '%corbeille%' then 'poubelle'
    ELSE NULL
END AS type_inventaire
FROM staging.inventaire_mobilier)
WHERE type_inventaire IS NOT NULL;

INSERT INTO public.materiaux (libelle)
SELECT * FROM (
SELECT DISTINCT
CASE
    WHEN LOWER(TRIM(materiau)) IN ('metal','métal') THEN 'métal'
    WHEN LOWER(TRIM(materiau)) = 'bois' THEN 'bois'
    WHEN LOWER(TRIM(materiau)) = 'sodium' THEN 'sodium'
    WHEN LOWER(TRIM(materiau)) = 'led' THEN 'led'
    ELSE NULL
END AS materiaux
FROM staging.inventaire_mobilier)
WHERE materiaux IS NOT NULL;

INSERT INTO public.etat (libelle)
SELECT * FROM (
SELECT DISTINCT
CASE 
    WHEN LOWER(TRIM(etat)) = 'à remplacer' THEN 'à remplacer'
    WHEN LOWER(TRIM(etat)) = 'bon' THEN 'bon'
    WHEN LOWER(TRIM(etat)) = 'usé' THEN 'usé'
    ELSE NULL
END AS etat
FROM staging.inventaire_mobilier)
WHERE etat IS NOT NULL;

-- Inventaire mobilier

INSERT INTO public.type_inventaire (libelle)
SELECT * FROM (
SELECT DISTINCT
CASE
    WHEN lower(trim("type")) LIKE '%banc%'  then 'banc'
    WHEN lower(trim("type")) LIKE '%lampadaire%' then 'lampadaire'
    WHEN lower(trim("type")) LIKE '%poubelle%' then 'poubelle'
    WHEN lower(trim("type")) LIKE '%corbeille%' then 'poubelle'
    ELSE NULL
END AS type_inventaire
FROM staging.inventaire_mobilier)
WHERE type_inventaire IS NOT NULL;
