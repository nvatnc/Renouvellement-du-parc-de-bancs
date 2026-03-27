-- Active: 1774608706951@@127.0.0.1@5438@renbancs
-- Active: 1774608706951@@127.0.0.1@5438@renbancs
CREATE EXTENSION IF NOT EXISTS unaccent;
 
INSERT INTO public.type_inventaire (libelle)

-- WHERE type_normalise IS NOT NULL;


SELECT DISTINCT unaccent(LOWER(TRIM(type)))
FROM inventaire_mobilier
WHERE type IS NOT NULL;
 

 select distinct 
 CASE 
    WHEN lower(trim(type)) LIKE '%banc%'  then 'banc'
    WHEN lower(trim(type)) LIKE '%lampadaire%' then 'lampadaire'
    WHEN lower(trim(type)) LIKE '%poubelle%' then 'poubelle'
    WHEN lower(trim(type)) LIKE '%corbeille%' then 'poubelle'
     else NULL
     end
 from inventaire_mobilier;

 select distinct 
 CASE 
    WHEN lower(trim(type)) LIKE '%banc%'  then 'banc'
    WHEN lower(trim(type)) LIKE '%lampadaire%' then 'lampadaire'
    WHEN lower(trim(type)) LIKE '%poubelle%' then 'poubelle'
    WHEN lower(trim(type)) LIKE '%corbeille%' then 'poubelle'
     else NULL
     end
 from inventaire_mobilier;