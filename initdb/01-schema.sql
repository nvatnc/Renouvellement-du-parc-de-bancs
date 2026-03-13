CREATE TABLE inventaire (
    id SERIAL PRIMARY KEY,
    lieu VARCHAR(100) NOT NULL,
);

CREATE TABLE fournisseurs (
    id SERIAL PRIMARY KEY,
    entreprise VARCHAR(100) NOT NULL,
);

CREATE TABLE interventions (
    id SERIAL PRIMARY KEY,
    date_interventions DATE,
);

CREATE TABLE signalements (
    id SERIAL PRIMARY KEY,
    date_signalements DATE,
    description_etat VARCHAR(100) NOT NULL,

);