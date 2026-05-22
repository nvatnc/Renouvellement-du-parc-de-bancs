-- Active: 1773397426455@@127.0.0.1@5438@renbancs
-- Active: 1774608706951@@127.0.0.1@5438@renbancs

CREATE EXTENSION IF NOT EXISTS unaccent;

-- ============================================================
-- TABLES DE RÉFÉRENCE — inventaire_mobilier
-- ============================================================

INSERT INTO public.type_inventaire (libelle)
SELECT DISTINCT
    CASE
        WHEN LOWER(TRIM("type")) LIKE '%banc%'       THEN 'banc'
        WHEN LOWER(TRIM("type")) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(TRIM("type")) LIKE '%poubelle%'   THEN 'poubelle'
        WHEN LOWER(TRIM("type")) LIKE '%corbeille%'  THEN 'poubelle'
        ELSE NULL
    END AS libelle
FROM staging.inventaire_mobilier
WHERE
    CASE
        WHEN LOWER(TRIM("type")) LIKE '%banc%'       THEN 'banc'
        WHEN LOWER(TRIM("type")) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(TRIM("type")) LIKE '%poubelle%'   THEN 'poubelle'
        WHEN LOWER(TRIM("type")) LIKE '%corbeille%'  THEN 'poubelle'
        ELSE NULL
    END IS NOT NULL;

INSERT INTO public.materiaux (libelle)
SELECT DISTINCT
    CASE
        WHEN LOWER(TRIM(materiau)) IN ('metal', 'métal') THEN 'métal'
        WHEN LOWER(TRIM(materiau)) = 'bois'              THEN 'bois'
        WHEN LOWER(TRIM(materiau)) = 'sodium'            THEN 'sodium'
        WHEN LOWER(TRIM(materiau)) = 'led'               THEN 'led'
        ELSE NULL
    END AS libelle
FROM staging.inventaire_mobilier
WHERE
    CASE
        WHEN LOWER(TRIM(materiau)) IN ('metal', 'métal') THEN 'métal'
        WHEN LOWER(TRIM(materiau)) = 'bois'              THEN 'bois'
        WHEN LOWER(TRIM(materiau)) = 'sodium'            THEN 'sodium'
        WHEN LOWER(TRIM(materiau)) = 'led'               THEN 'led'
        ELSE NULL
    END IS NOT NULL;

INSERT INTO public.etat (libelle)
SELECT DISTINCT
    CASE
        WHEN LOWER(TRIM(etat)) = 'à remplacer' THEN 'à remplacer'
        WHEN LOWER(TRIM(etat)) = 'bon'         THEN 'bon'
        WHEN LOWER(TRIM(etat)) = 'usé'         THEN 'usé'
        ELSE NULL
    END AS libelle
FROM staging.inventaire_mobilier
WHERE
    CASE
        WHEN LOWER(TRIM(etat)) = 'à remplacer' THEN 'à remplacer'
        WHEN LOWER(TRIM(etat)) = 'bon'         THEN 'bon'
        WHEN LOWER(TRIM(etat)) = 'usé'         THEN 'usé'
        ELSE NULL
    END IS NOT NULL;

-- ============================================================
-- TABLES DE RÉFÉRENCE — interventions
-- ============================================================

INSERT INTO public.type_interventions (libelle)
SELECT DISTINCT
    CASE
        WHEN LOWER(TRIM(type_intervention)) LIKE '%nettoyage%'       THEN 'Nettoyage'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%remplacement%'    THEN 'Remplacement'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%réparation%'      THEN 'Réparation'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%redressage%'      THEN 'Redressage'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%peinture%'        THEN 'Peinture'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%hivernage%'       THEN 'Hivernage'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%remise en service%' THEN 'Remise en service'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%détartrage%'      THEN 'Détartrage'
        ELSE NULL
    END AS libelle
FROM staging.interventions
WHERE
    CASE
        WHEN LOWER(TRIM(type_intervention)) LIKE '%nettoyage%'       THEN 'Nettoyage'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%remplacement%'    THEN 'Remplacement'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%réparation%'      THEN 'Réparation'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%redressage%'      THEN 'Redressage'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%peinture%'        THEN 'Peinture'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%hivernage%'       THEN 'Hivernage'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%remise en service%' THEN 'Remise en service'
        WHEN LOWER(TRIM(type_intervention)) LIKE '%détartrage%'      THEN 'Détartrage'
        ELSE NULL
    END IS NOT NULL;

INSERT INTO public.techniciens (nom)
SELECT DISTINCT
    CASE
        WHEN LOWER(TRIM(technicien)) IN ('jm', 'jean-marc', 'jean-marc bonvin') THEN 'Jean-Marc Bonvin'
        WHEN LOWER(TRIM(technicien)) IN ('pedro', 'alves pedro', 'p. alves')    THEN 'Pedro Alves'
        WHEN LOWER(TRIM(technicien)) = 'koffi marc'                             THEN 'Koffi Marc'
        WHEN LOWER(TRIM(technicien)) = 'stagiaire'                              THEN 'Stagiaire'
        ELSE NULL
    END AS nom
FROM staging.interventions
WHERE
    CASE
        WHEN LOWER(TRIM(technicien)) IN ('jm', 'jean-marc', 'jean-marc bonvin') THEN 'Jean-Marc Bonvin'
        WHEN LOWER(TRIM(technicien)) IN ('pedro', 'alves pedro', 'p. alves')    THEN 'Pedro Alves'
        WHEN LOWER(TRIM(technicien)) = 'koffi marc'                             THEN 'Koffi Marc'
        WHEN LOWER(TRIM(technicien)) = 'stagiaire'                              THEN 'Stagiaire'
        ELSE NULL
    END IS NOT NULL;

-- ============================================================
-- TABLES DE RÉFÉRENCE — signalements
-- ============================================================

INSERT INTO public.statut (libelle)
SELECT DISTINCT
    CASE
        WHEN LOWER(TRIM(statut)) LIKE '%fait%'       THEN 'Fait'
        WHEN LOWER(TRIM(statut)) LIKE '%en attente%' THEN 'En attente'
        WHEN LOWER(TRIM(statut)) LIKE '%en cours%'   THEN 'En cours'
        ELSE NULL
    END AS libelle
FROM staging.signalements
WHERE
    CASE
        WHEN LOWER(TRIM(statut)) LIKE '%fait%'       THEN 'Fait'
        WHEN LOWER(TRIM(statut)) LIKE '%en attente%' THEN 'En attente'
        WHEN LOWER(TRIM(statut)) LIKE '%en cours%'   THEN 'En cours'
        ELSE NULL
    END IS NOT NULL;

INSERT INTO public.urgence (libelle)
SELECT DISTINCT
    CASE
        WHEN LOWER(TRIM(urgence)) = 'urgent' THEN 'urgent'
        WHEN LOWER(TRIM(urgence)) = 'normal' THEN 'normal'
        ELSE NULL
    END AS libelle
FROM staging.signalements
WHERE
    CASE
        WHEN LOWER(TRIM(urgence)) = 'urgent' THEN 'urgent'
        WHEN LOWER(TRIM(urgence)) = 'normal' THEN 'normal'
        ELSE NULL
    END IS NOT NULL;

-- ============================================================
-- TABLES DE RÉFÉRENCE — fournisseurs_contacts
-- ============================================================

-- Contacts (nom + téléphone normalisé + email nettoyé)
INSERT INTO public.contact (nom, telephone, email)
SELECT DISTINCT
    TRIM(fc.contact) AS nom,
    CASE
        WHEN fc.telephone LIKE '+41%'
            THEN '0' || REGEXP_REPLACE(SUBSTR(fc.telephone, 4), '^\s+', '')
        WHEN TRIM(fc.telephone) = '' THEN NULL
        ELSE TRIM(fc.telephone)
    END AS telephone,
    CASE
        WHEN fc.email IS NULL
             OR fc.email = '(NULL)'
             OR fc.email ILIKE '%site web%'
             OR TRIM(fc.email) = '' THEN NULL
        ELSE LOWER(TRIM(fc.email))
    END AS email
FROM staging.fournisseurs_contacts fc
WHERE
    fc.contact IS NOT NULL
    AND TRIM(fc.contact) <> ''
    AND fc.contact NOT ILIKE '%site web%';

-- Types de matériel (extraction depuis la liste CSV séparée par virgules)
INSERT INTO public.type_materiel (libelle)
SELECT DISTINCT
    LOWER(TRIM(t.val)) AS libelle
FROM staging.fournisseurs_contacts fc
CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(fc.type_materiel, ',')) AS t(val)
WHERE TRIM(t.val) <> '';

-- ============================================================
-- DONNÉES — fournisseurs
-- ============================================================

INSERT INTO public.fournisseurs (entreprise, remarque, id_contact)
SELECT DISTINCT
    TRIM(fc.entreprise)           AS entreprise,
    NULLIF(TRIM(fc.remarques), '') AS remarque,
    c.id                           AS id_contact
FROM staging.fournisseurs_contacts fc
JOIN public.contact c ON TRIM(c.nom) = TRIM(fc.contact)
WHERE
    TRIM(fc.entreprise) <> ''
    AND fc.contact NOT ILIKE '%site web%';

-- Liaison fournisseurs ↔ types de matériel
INSERT INTO public.type_materiel_fournisseurs (id_type_materiel, id_fournisseurs)
SELECT DISTINCT
    tm.id AS id_type_materiel,
    f.id  AS id_fournisseurs
FROM staging.fournisseurs_contacts fc
JOIN public.fournisseurs f
    ON TRIM(f.entreprise) = TRIM(fc.entreprise)
CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(fc.type_materiel, ',')) AS t(val)
JOIN public.type_materiel tm
    ON LOWER(TRIM(tm.libelle)) = LOWER(TRIM(t.val))
WHERE TRIM(t.val) <> ''
ON CONFLICT DO NOTHING;


-- ============================================================
-- DONNÉES — inventaire
-- ============================================================

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
    TRIM(brut.lieu) AS lieu,
    CASE
        WHEN TRIM(brut.date_installation) ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN TO_DATE(TRIM(brut.date_installation), 'DD.MM.YYYY')
        WHEN TRIM(brut.date_installation) ~ '^\d{4}-\d{2}-\d{2}$'
            THEN TO_DATE(TRIM(brut.date_installation), 'YYYY-MM-DD')
        WHEN TRIM(brut.date_installation) ~ '^\d{4}$'
            THEN TO_DATE(TRIM(brut.date_installation), 'YYYY')
        WHEN LOWER(TRIM(brut.date_installation)) ~ '^(janvier|février|mars|avril|mai|juin|juillet|août|septembre|octobre|novembre|décembre)\s+\d{4}$'
            THEN TO_DATE(
                '01 ' ||
                CASE LOWER(SPLIT_PART(TRIM(brut.date_installation), ' ', 1))
                    WHEN 'janvier'   THEN 'January'
                    WHEN 'février'   THEN 'February'
                    WHEN 'mars'      THEN 'March'
                    WHEN 'avril'     THEN 'April'
                    WHEN 'mai'       THEN 'May'
                    WHEN 'juin'      THEN 'June'
                    WHEN 'juillet'   THEN 'July'
                    WHEN 'août'      THEN 'August'
                    WHEN 'septembre' THEN 'September'
                    WHEN 'octobre'   THEN 'October'
                    WHEN 'novembre'  THEN 'November'
                    WHEN 'décembre'  THEN 'December'
                END || ' ' || SPLIT_PART(TRIM(brut.date_installation), ' ', 2),
                'DD Month YYYY'
            )
        ELSE NULL
    END AS date_installation,
    NULLIF(TRIM(brut.remarques), '') AS remarque,
    f.id AS id_fournisseurs,
    ti.id AS id_type_inventaire,
    m.id  AS id_materiaux,
    e.id  AS id_etat
FROM staging.inventaire_mobilier brut
JOIN staging.fournisseur_inventaire fi ON LOWER(TRIM(fi.id)) = LOWER(TRIM(brut.id))
JOIN public.fournisseurs f ON LOWER(TRIM(f.entreprise)) = LOWER(TRIM(fi.entreprise))
JOIN public.type_inventaire ti ON LOWER(TRIM(ti.libelle)) = LOWER(TRIM(brut."type"))
JOIN public.materiaux        m  ON LOWER(TRIM(m.libelle))  = LOWER(TRIM(brut.materiau))
JOIN public.etat             e  ON LOWER(TRIM(e.libelle))  = LOWER(TRIM(brut.etat));

-- ============================================================
-- DONNÉES — fournisseurs
-- ============================================================

INSERT INTO public.fournisseurs (entreprise, remarque, id_contact)
SELECT DISTINCT
    TRIM(fc.entreprise)           AS entreprise,
    NULLIF(TRIM(fc.remarques), '') AS remarque,
    c.id                           AS id_contact
FROM staging.fournisseurs_contacts fc
JOIN public.contact c ON TRIM(c.nom) = TRIM(fc.contact)
WHERE
    TRIM(fc.entreprise) <> ''
    AND fc.contact NOT ILIKE '%site web%';

-- Liaison fournisseurs ↔ types de matériel
INSERT INTO public.type_materiel_fournisseurs (id_type_materiel, id_fournisseurs)
SELECT DISTINCT
    tm.id AS id_type_materiel,
    f.id  AS id_fournisseurs
FROM staging.fournisseurs_contacts fc
JOIN public.fournisseurs f
    ON TRIM(f.entreprise) = TRIM(fc.entreprise)
CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(fc.type_materiel, ',')) AS t(val)
JOIN public.type_materiel tm
    ON LOWER(TRIM(tm.libelle)) = LOWER(TRIM(t.val))
WHERE TRIM(t.val) <> ''
ON CONFLICT DO NOTHING;

-- ============================================================
-- DONNÉES — signalements
-- ============================================================

-- Signalement générique pour les interventions sans signalement associé
INSERT INTO public.signalements (date_signalements, description, id_urgence, id_statut)
SELECT
    CURRENT_DATE,
    'Intervention planifiée (sans signalement associé)',
    (SELECT id FROM public.urgence WHERE libelle = 'normal' LIMIT 1),
    (SELECT id FROM public.statut  WHERE LOWER(libelle) = 'fait'   LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.signalements
    WHERE description = 'Intervention planifiée (sans signalement associé)'
);

-- Signalements réels
INSERT INTO public.signalements (date_signalements, description, id_urgence, id_statut)
SELECT
    CASE
        WHEN TRIM(s.date) ~ '^\d{4}-\d{2}-\d{2}$'    THEN TO_DATE(TRIM(s.date), 'YYYY-MM-DD')
        WHEN TRIM(s.date) ~ '^\d{2}\.\d{2}\.\d{4}$'   THEN TO_DATE(TRIM(s.date), 'DD.MM.YYYY')
        ELSE NULL
    END AS date_signalements,
    TRIM(s.description) AS description,
    COALESCE(
        (SELECT u.id FROM public.urgence u
         WHERE LOWER(u.libelle) = LOWER(TRIM(s.urgence))
         LIMIT 1),
        (SELECT id FROM public.urgence WHERE libelle = 'normal' LIMIT 1)
    ) AS id_urgence,
    COALESCE(
        (SELECT st.id FROM public.statut st
         WHERE LOWER(st.libelle) = CASE
             WHEN LOWER(TRIM(s.statut)) LIKE '%fait%'       THEN 'fait'
             WHEN LOWER(TRIM(s.statut)) LIKE '%en attente%' THEN 'en attente'
             WHEN LOWER(TRIM(s.statut)) LIKE '%en cours%'   THEN 'en cours'
             ELSE NULL
         END
         LIMIT 1),
        (SELECT id FROM public.statut WHERE LOWER(libelle) = 'en attente' LIMIT 1)
    ) AS id_statut
FROM staging.signalements s
WHERE
    (TRIM(s.date) ~ '^\d{4}-\d{2}-\d{2}$' OR TRIM(s.date) ~ '^\d{2}\.\d{2}\.\d{4}$')
    AND TRIM(s.description) <> '';

-- ============================================================
-- DONNÉES — interventions
-- ============================================================

INSERT INTO public.interventions (
    date_interventions,
    duree,
    cout_materiel,
    remarque,
    id_inventaire,
    id_techniciens,
    id_signalements,
    id_type_interventions
)
WITH interventions_clean AS (
    SELECT
        i.*,
        CASE
            WHEN TRIM(i.date) ~ '^\d{4}-\d{2}-\d{2}$'  THEN TO_DATE(TRIM(i.date), 'YYYY-MM-DD')
            WHEN TRIM(i.date) ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(TRIM(i.date), 'DD.MM.YYYY')
            ELSE NULL
        END AS date_propre,
        CASE
            WHEN LOWER(TRIM(i.duree)) = '30 min'       THEN INTERVAL '30 minutes'
            WHEN LOWER(TRIM(i.duree)) = '1h'           THEN INTERVAL '1 hour'
            WHEN LOWER(TRIM(i.duree)) = '1h30'         THEN INTERVAL '1 hour 30 minutes'
            WHEN LOWER(TRIM(i.duree)) = '2h'           THEN INTERVAL '2 hours'
            WHEN LOWER(TRIM(i.duree)) = '3h'           THEN INTERVAL '3 hours'
            WHEN LOWER(TRIM(i.duree)) = 'une matinée'  THEN INTERVAL '3 hours'
            WHEN LOWER(TRIM(i.duree)) = 'une journée'  THEN INTERVAL '8 hours'
            ELSE NULL
        END AS duree_propre,
        CASE
            WHEN LOWER(TRIM(i.cout_materiel)) IN ('garantie', 'gratuit', '') THEN 0
            WHEN TRIM(i.cout_materiel) IS NULL OR TRIM(i.cout_materiel) = '' THEN NULL
            ELSE NULLIF(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(TRIM(i.cout_materiel), 'CHF\s*', '', 'gi'),
                    '\.-$', '', 'g'
                ),
                ''
            )::NUMERIC(10,2)
        END AS cout_propre,
        CASE
            WHEN LOWER(TRIM(i.technicien)) IN ('jm', 'jean-marc', 'jean-marc bonvin') THEN 'Jean-Marc Bonvin'
            WHEN LOWER(TRIM(i.technicien)) IN ('pedro', 'alves pedro', 'p. alves')    THEN 'Pedro Alves'
            WHEN LOWER(TRIM(i.technicien)) = 'koffi marc'                             THEN 'Koffi Marc'
            WHEN LOWER(TRIM(i.technicien)) = 'stagiaire'                              THEN 'Stagiaire'
            ELSE NULL
        END AS technicien_propre,
        CASE
            WHEN LOWER(TRIM(i.type_intervention)) LIKE '%nettoyage%'        THEN 'Nettoyage'
            WHEN LOWER(TRIM(i.type_intervention)) LIKE '%remplacement%'     THEN 'Remplacement'
            WHEN LOWER(TRIM(i.type_intervention)) LIKE '%réparation%'       THEN 'Réparation'
            WHEN LOWER(TRIM(i.type_intervention)) LIKE '%redressage%'       THEN 'Redressage'
            WHEN LOWER(TRIM(i.type_intervention)) LIKE '%peinture%'         THEN 'Peinture'
            WHEN LOWER(TRIM(i.type_intervention)) LIKE '%hivernage%'        THEN 'Hivernage'
            WHEN LOWER(TRIM(i.type_intervention)) LIKE '%remise en service%' THEN 'Remise en service'
            WHEN LOWER(TRIM(i.type_intervention)) LIKE '%détartrage%'       THEN 'Détartrage'
            ELSE NULL
        END AS type_intervention_propre
    FROM staging.interventions i
    WHERE
        TRIM(i.date) ~ '^\d{4}-\d{2}-\d{2}$'
        OR TRIM(i.date) ~ '^\d{2}\.\d{2}\.\d{4}$'
),
interventions_avec_inventaire AS (
    SELECT
        ic.*,
        inv.id AS inventaire_id,
        ROW_NUMBER() OVER (
            PARTITION BY ic.date, ic.objet
            ORDER BY inv.id
        ) AS rn
    FROM interventions_clean ic
    JOIN public.inventaire inv
        ON unaccent(LOWER(inv.lieu)) = ANY(
            ARRAY(
                SELECT unaccent(LOWER(lieu))
                FROM public.inventaire
                WHERE unaccent(LOWER(ic.objet)) LIKE '%' || unaccent(LOWER(lieu)) || '%'
            )
        )
    WHERE
        ic.date_propre             IS NOT NULL
        AND ic.technicien_propre   IS NOT NULL
        AND ic.type_intervention_propre IS NOT NULL
)
SELECT
    ia.date_propre                 AS date_interventions,
    ia.duree_propre                AS duree,
    ia.cout_propre                 AS cout_materiel,
    NULLIF(TRIM(ia.remarques), '') AS remarque,
    ia.inventaire_id               AS id_inventaire,
    (SELECT t.id FROM public.techniciens t
     WHERE t.nom = ia.technicien_propre LIMIT 1)  AS id_techniciens,
    (SELECT id FROM public.signalements
     WHERE description = 'Intervention planifiée (sans signalement associé)'
     LIMIT 1)                                       AS id_signalements,
    (SELECT ti.id FROM public.type_interventions ti
     WHERE ti.libelle = ia.type_intervention_propre LIMIT 1) AS id_type_interventions
FROM interventions_avec_inventaire ia
WHERE ia.rn = 1;  -- Un seul inventaire par intervention en cas d'ambiguïté

-- ============================================================
-- TABLES DE LIAISON — interventions_inventaire
-- ============================================================
-- Associe chaque intervention à tous les éléments d'inventaire
-- dont le lieu apparaît dans l'objet de l'intervention staging.

INSERT INTO public.interventions_inventaire (id_interventions, id_inventaire)
SELECT DISTINCT
    intv.id  AS id_interventions,
    inv.id   AS id_inventaire
FROM public.interventions intv
-- On retrouve la ligne staging par correspondance date + inventaire déjà lié
JOIN staging.interventions si
    ON (
        TRIM(si.date) ~ '^\d{4}-\d{2}-\d{2}$'
            AND TO_DATE(TRIM(si.date), 'YYYY-MM-DD') = intv.date_interventions
        OR
        TRIM(si.date) ~ '^\d{2}\.\d{2}\.\d{4}$'
            AND TO_DATE(TRIM(si.date), 'DD.MM.YYYY') = intv.date_interventions
    )
JOIN public.inventaire inv
    ON unaccent(LOWER(si.objet)) LIKE '%' || unaccent(LOWER(inv.lieu)) || '%'
-- Exclure les paires déjà couvertes par la FK principale dans interventions
WHERE NOT EXISTS (
    SELECT 1 FROM public.interventions_inventaire ii
    WHERE ii.id_interventions = intv.id
      AND ii.id_inventaire    = inv.id
);

-- ============================================================
-- TABLES DE LIAISON — signalements_inventaire
-- ============================================================
-- Associe chaque signalement aux éléments d'inventaire
-- dont le lieu apparaît dans l'objet du signalement staging.

INSERT INTO public.signalements_inventaire (id_signalements, id_inventaire)
SELECT DISTINCT
    sig.id  AS id_signalements,
    inv.id  AS id_inventaire
FROM public.signalements sig
JOIN staging.signalements ss
    ON (
        TRIM(ss.date) ~ '^\d{4}-\d{2}-\d{2}$'
            AND TO_DATE(TRIM(ss.date), 'YYYY-MM-DD') = sig.date_signalements
        OR
        TRIM(ss.date) ~ '^\d{2}\.\d{2}\.\d{4}$'
            AND TO_DATE(TRIM(ss.date), 'DD.MM.YYYY') = sig.date_signalements
    )
    AND TRIM(ss.description) = sig.description
JOIN public.inventaire inv
    ON unaccent(LOWER(ss.objet)) LIKE '%' || unaccent(LOWER(inv.lieu)) || '%'
-- Exclure le signalement générique (pas d'objet physique associé)
WHERE sig.description <> 'Intervention planifiée (sans signalement associé)'
  AND NOT EXISTS (
    SELECT 1 FROM public.signalements_inventaire si
    WHERE si.id_signalements = sig.id
      AND si.id_inventaire   = inv.id
  );