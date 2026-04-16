-- Active: 1773397426455@@127.0.0.1@5438@renbancs
-- Active: 1774608706951@@127.0.0.1@5438@renbancs
CREATE EXTENSION IF NOT EXISTS unaccent;

-- Inventaire mobilier

INSERT INTO
    public.type_inventaire (libelle)
SELECT *
FROM (
        SELECT DISTINCT
            CASE
                WHEN lower(trim("type")) LIKE '%banc%' then 'banc'
                WHEN lower(trim("type")) LIKE '%lampadaire%' then 'lampadaire'
                WHEN lower(trim("type")) LIKE '%poubelle%' then 'poubelle'
                WHEN lower(trim("type")) LIKE '%corbeille%' then 'poubelle'
                ELSE NULL
            END AS type_inventaire
        FROM staging.inventaire_mobilier
    )
WHERE
    type_inventaire IS NOT NULL;

INSERT INTO
    public.materiaux (libelle)
SELECT *
FROM (
        SELECT DISTINCT
            CASE
                WHEN LOWER(TRIM(materiau)) IN ('metal', 'métal') THEN 'métal'
                WHEN LOWER(TRIM(materiau)) = 'bois' THEN 'bois'
                WHEN LOWER(TRIM(materiau)) = 'sodium' THEN 'sodium'
                WHEN LOWER(TRIM(materiau)) = 'led' THEN 'led'
                ELSE NULL
            END AS materiaux
        FROM staging.inventaire_mobilier
    )
WHERE
    materiaux IS NOT NULL;

INSERT INTO
    public.etat (libelle)
SELECT *
FROM (
        SELECT DISTINCT
            CASE
                WHEN LOWER(TRIM(etat)) = 'à remplacer' THEN 'à remplacer'
                WHEN LOWER(TRIM(etat)) = 'bon' THEN 'bon'
                WHEN LOWER(TRIM(etat)) = 'usé' THEN 'usé'
                ELSE NULL
            END AS etat
        FROM staging.inventaire_mobilier
    )
WHERE
    etat IS NOT NULL;

-- Interventions

INSERT INTO
    public.type_interventions (libelle)
SELECT *
FROM (
        SELECT DISTINCT
            CASE
                WHEN lower(trim(type_intervention)) LIKE '%nettoyage%' then 'Nettoyage'
                WHEN lower(trim(type_intervention)) LIKE '%remplacement%' then 'Remplacemement'
                WHEN lower(trim(type_intervention)) LIKE '%réparation%' then 'Réparation'
                WHEN lower(trim(type_intervention)) LIKE '%redressage%' then 'Redressage'
                WHEN lower(trim(type_intervention)) LIKE '%peinture%' then 'Peinture'
                WHEN lower(trim(type_intervention)) LIKE '%hivernage%' then 'Hivernage'
                WHEN lower(trim(type_intervention)) LIKE '%remise en service%' then 'Remise en service'
                WHEN lower(trim(type_intervention)) LIKE '%détartrage%' then 'Détartrage'
                ELSE NULL
            END AS type_interventions
        FROM staging.interventions
    )
WHERE
    type_interventions IS NOT NULL;

INSERT INTO
    public.techniciens (nom)
SELECT *
FROM (
        SELECT DISTINCT
            CASE
                WHEN LOWER(TRIM(technicien)) IN (
                    'jm', 'JM', 'jean-marc', 'jean-marc bonvin'
                ) THEN 'Jean-Marc Bonvin'
                WHEN LOWER(TRIM(technicien)) IN (
                    'pedro', 'alves pedro', 'p. alves'
                ) THEN 'Pedro Alves'
                WHEN LOWER(TRIM(technicien)) = 'koffi marc' THEN 'Koffi Marc'
                WHEN LOWER(TRIM(technicien)) = 'stagiaire' THEN 'Stagiaire'
                ELSE NULL
            END AS techniciens
        FROM staging.interventions
    )
WHERE
    techniciens IS NOT NULL;

-- Signalements

INSERT INTO
    public.statut (libelle)
SELECT *
FROM (
        SELECT DISTINCT
            CASE
                WHEN lower(trim(statut)) LIKE '%fait%' then 'Fait'
                WHEN lower(trim(statut)) LIKE '%en attente%' then 'En attente'
                WHEN lower(trim(statut)) LIKE '%en cours%' then 'En cours'
                ELSE NULL
            END AS statut
        FROM staging.signalements
    )
WHERE
    statut IS NOT NULL;

INSERT INTO
    public.urgence (libelle)
SELECT *
FROM (
        SELECT DISTINCT
            CASE
                WHEN LOWER(TRIM(urgence)) = 'urgent' THEN 'urgent'
                WHEN LOWER(TRIM(urgence)) = 'normal' THEN 'normal'
                ELSE NULL
            END AS urgence
        FROM staging.signalements
    )
WHERE
    urgence IS NOT NULL;

-- Fournisseurs Contacts

INSERT INTO
    public.contact (nom)
SELECT *
FROM (
        SELECT DISTINCT
            CASE
                WHEN LOWER(TRIM(contact)) IN (
                    'jm', 'JM', 'jean-marc', 'jean-marc bonvin'
                ) THEN 'Jean-Marc Bonvin'
                WHEN LOWER(TRIM(contact)) IN (
                    'pedro', 'alves pedro', 'p. alves'
                ) THEN 'Pedro Alves'
                WHEN LOWER(TRIM(contact)) = 'koffi marc' THEN 'Koffi Marc'
                WHEN LOWER(TRIM(contact)) = 'stagiaire' THEN 'Stagiaire'
                ELSE NULL
            END AS techniciens
        FROM staging.interventions
    )
WHERE
    techniciens IS NOT NULL;

INSERT INTO
    public.type_materiel (libelle)
SELECT DISTINCT
    TRIM(x.materiel) AS libelle
FROM staging.fournisseurs_contacts s
    CROSS JOIN LATERAL UNNEST(
        string_to_array(s.type_materiel, ',')
    ) AS x (materiel)
WHERE
    TRIM(x.materiel) <> '';


    

--DELETE FROM public.techniciens a USING public.techniciens b
--WHERE
--    a.id > b.id
--    AND a.nom = b.nom;