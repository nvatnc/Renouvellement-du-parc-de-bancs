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
        FROM staging.fournisseurs_contacts
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




SELECT
  telephone,
  CASE
    WHEN telephone LIKE '+41%' THEN '0' || regexp_replace(substr(telephone, 4), '^\s+', '')
    ELSE telephone
  END AS  telephone
 FROM staging.fournisseurs_contacts;

 SELECT
  date,
  to_char(
    CASE
      WHEN date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN to_date("date", 'DD.MM.YeYYY')
      WHEN date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN to_date("date",'MM.DD.YYYY')
      WHEN date ~ '^\d{4}-\d{2}-\d{2}$'   THEN to_date("date", 'YYYY-MM-DD')
      ELSE NULL
    END,
    'DD.MM.YYYY'
  ) AS date
FROM staging.signalements;

INSERT INTO public.type_materiel (libelle)
SELECT DISTINCT
    LOWER(TRIM(t.val)) AS libelle
FROM staging.fournisseurs_contacts fc
CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(fc.type_materiel, ',')) AS t(val)
WHERE TRIM(t.val) <> '';

INSERT INTO public.contact (nom, telephone, email)
SELECT DISTINCT
  TRIM(fournisseurs_contacts.contact) AS nom,
  CASE
    WHEN fournisseurs_contacts.telephone LIKE '+41%' THEN 
      '0' || regexp_replace(substr(fournisseurs_contacts.telephone, 4), '^\s+', '')
    WHEN TRIM(fournisseurs_contacts.telephone) = '' THEN NULL
    ELSE TRIM(fournisseurs_contacts.telephone)
  END AS telephone,
  CASE
    WHEN fournisseurs_contacts.email IS NULL 
         OR fournisseurs_contacts.email = '(NULL)' 
         OR fournisseurs_contacts.email ILIKE '%site web%' 
         OR TRIM(fournisseurs_contacts.email) = '' THEN NULL
    ELSE LOWER(TRIM(fournisseurs_contacts.email))
  END AS email
FROM staging.fournisseurs_contacts
WHERE
  fournisseurs_contacts.contact IS NOT NULL
  AND TRIM(fournisseurs_contacts.contact) <> ''
  AND fournisseurs_contacts.contact NOT ILIKE '%site web%';














INSERT INTO public.signalements (
date_signalements,
description,
id_urgence,
id_statut
)
SELECT
CASE
WHEN TRIM(s.date) ~ '^\d{4}-\d{2}-\d{2}$'
THEN to_date(TRIM(s.date), 'YYYY-MM-DD')
WHEN TRIM(s.date) ~ '^\d{2}\.\d{2}\.\d{4}$'
THEN to_date(TRIM(s.date), 'DD.MM.YYYY')
ELSE NULL
END AS date_signalements,
TRIM(s.description) AS description,
COALESCE(
    (SELECT u.id FROM public.urgence u
     WHERE LOWER(u.libelle) = LOWER(TRIM(s.urgence))
     LIMIT 1),
    (SELECT id FROM public.urgence WHERE libelle = 'normal')
) AS id_urgence,
COALESCE(
    (SELECT st.id FROM public.statut st
     WHERE LOWER(st.libelle) = CASE
         WHEN LOWER(TRIM(s.statut)) LIKE '%fait%'        THEN 'fait'
         WHEN LOWER(TRIM(s.statut)) LIKE '%en attente%'  THEN 'en attente'
         WHEN LOWER(TRIM(s.statut)) LIKE '%en cours%'    THEN 'en cours'
         ELSE NULL
     END
     LIMIT 1),
    (SELECT id FROM public.statut WHERE LOWER(libelle) = 'en attente')
) AS id_statut

FROM staging.signalements s
WHERE
-- Exclure lignes sans date valide
(TRIM(s.date) ~ '^\d{4}-\d{2}-\d{2}$' OR TRIM(s.date) ~ '^\d{2}\.\d{2}\.\d{4}$')
AND TRIM(s.description) <> '';



INSERT INTO public.inventaire (
    lieu,
    date_installation,
    remarque,
    id_fournisseurs,
    id_type_inventaire,
    id_materiaux,
    id_etat
)
SELECT
    brut.lieu,
    CASE
        WHEN trim(brut.date_installation) ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN to_date(trim(brut.date_installation), 'DD.MM.YYYY')
        WHEN trim(brut.date_installation) ~ '^\d{4}-\d{2}-\d{2}$'
            THEN to_date(trim(brut.date_installation), 'YYYY-MM-DD')
        WHEN trim(brut.date_installation) ~ '^\d{4}$'
            THEN to_date(trim(brut.date_installation), 'YYYY')
        WHEN lower(trim(brut.date_installation)) ~ '^(janvier|février|mars|avril|mai|juin|juillet|août|septembre|octobre|novembre|décembre)\s+\d{4}$'
            THEN to_date(
                '01 ' ||
                CASE lower(split_part(trim(brut.date_installation), ' ', 1))
                    WHEN 'janvier' THEN 'January'
                    WHEN 'février' THEN 'February'
                    WHEN 'mars' THEN 'March'
                    WHEN 'avril' THEN 'April'
                    WHEN 'mai' THEN 'May'
                    WHEN 'juin' THEN 'June'
                    WHEN 'juillet' THEN 'July'
                    WHEN 'août' THEN 'August'
                    WHEN 'septembre' THEN 'September'
                    WHEN 'octobre' THEN 'October'
                    WHEN 'novembre' THEN 'November'
                    WHEN 'décembre' THEN 'December'
                END || ' ' || split_part(trim(brut.date_installation), ' ', 2),
                'DD Month YYYY'
            )
        ELSE NULL
    END,
    brut.remarques,
    NULL,
    ti.id,
    m.id,
    e.id
FROM staging.inventaire_mobilier brut
JOIN public.type_inventaire ti ON lower(trim(ti.libelle)) = lower(trim(brut.type))
JOIN public.materiaux m ON lower(trim(m.libelle)) = lower(trim(brut.materiau))
JOIN public.etat e ON lower(trim(e.libelle)) = lower(trim(brut.etat));







INSERT INTO public.fournisseurs (entreprise, remarque, id_contact)
SELECT DISTINCT
TRIM(fc.entreprise) AS entreprise,
NULLIF(TRIM(fc.remarques), '') AS remarque,
c.id AS id_contact
FROM staging.fournisseurs_contacts fc
JOIN public.contact c
ON TRIM(c.nom) = TRIM(fc.contact)
WHERE
TRIM(fc.entreprise) <> ''
AND fc.contact NOT ILIKE '%site web%';


INSERT INTO public.type_materiel_fournisseurs (id_type_materiel, id_fournisseurs)
SELECT DISTINCT
tm.id,
f.id
FROM staging.fournisseurs_contacts fc
JOIN public.fournisseurs f
ON TRIM(f.entreprise) = TRIM(fc.entreprise)
CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(fc.type_materiel, ',')) AS t(val)
JOIN public.type_materiel tm
ON LOWER(TRIM(tm.libelle)) = LOWER(TRIM(t.val))
WHERE TRIM(t.val) <> '';































DELETE FROM public.type_materiel;




--DELETE FROM public.techniciens a USING public.techniciens b
--WHERE
--    a.id > b.id
--    AND a.nom = b.nom;