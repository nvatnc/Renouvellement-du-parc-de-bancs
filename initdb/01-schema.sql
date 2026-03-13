CREATE TABLE type_materiel (
  id SERIAL PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
);

CREATE TABLE type_inventaire (
  id SERIAL PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
);

CREATE TABLE type_interventions (
  id SERIAL PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
);

CREATE TABLE materiaux (
  id SERIAL PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
);

CREATE TABLE etat (
  id SERIAL PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
);

CREATE TABLE statut (
  id SERIAL PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
);

CREATE TABLE urgence (
  id SERIAL PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
);
CREATE TABLE contact (
  id SERIAL PRIMARY KEY,
  telephone VARCHAR(30) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE personne (
  id SERIAL PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  numero VARCHAR(30) UNIQUE,
  mail VARCHAR(255) UNIQUE
);

CREATE TABLE techniciens (
  id SERIAL PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  numero_telephone VARCHAR(30) UNIQUE
);

CREATE TABLE fournisseurs (
  id SERIAL PRIMARY KEY,
  entreprise VARCHAR(255) NOT NULL,
  remarque TEXT,
  id_contact INTEGER NOT NULL REFERENCES contact(id),
  id_type_materiel INTEGER NOT NULL REFERENCES type_materiel(id)
);

CREATE TABLE inventaire (
  id SERIAL PRIMARY KEY,
  lieu VARCHAR(255) NOT NULL,
  latitude NUMERIC(9,6),
  longitude NUMERIC(9,6),
  date_installation DATE NOT NULL,
  remarque TEXT,
  id_fournisseurs INTEGER REFERENCES fournisseurs(id),
  id_type_inventaire INTEGER NOT NULL REFERENCES type_inventaire(id),
  id_materiaux INTEGER NOT NULL REFERENCES materiaux(id),
  id_etat INTEGER NOT NULL REFERENCES etat(id)
);

CREATE TABLE signalements (
  id SERIAL PRIMARY KEY,
  date_signalements DATE NOT NULL,
  description TEXT NOT NULL,
  id_urgence INTEGER NOT NULL REFERENCES urgence(id),
  id_personne INTEGER NOT NULL REFERENCES personne(id),
  id_statut INTEGER NOT NULL REFERENCES statut(id)
);

CREATE TABLE interventions (
  id SERIAL PRIMARY KEY,
  date_interventions DATE NOT NULL,
  duree INTERVAL,
  cout_materiel NUMERIC(10,2),
  remarque TEXT,
  id_inventaire INTEGER NOT NULL REFERENCES inventaire(id),
  id_techniciens INTEGER NOT NULL REFERENCES techniciens(id),
  id_signalements INTEGER NOT NULL REFERENCES signalements(id),
  id_type_interventions INTEGER NOT NULL REFERENCES type_interventions(id)
);

CREATE TABLE interventions_inventaire (
  id_interventions INTEGER NOT NULL REFERENCES interventions(id),
  id_inventaire INTEGER NOT NULL REFERENCES inventaire(id),
  PRIMARY KEY(id_interventions, id_inventaire)
);

CREATE TABLE signalements_inventaire (
  id_signalements INTEGER NOT NULL REFERENCES signalements(id),
  id_inventaire INTEGER NOT NULL REFERENCES inventaire(id),
  PRIMARY KEY(id_signalements, id_inventaire)
);
