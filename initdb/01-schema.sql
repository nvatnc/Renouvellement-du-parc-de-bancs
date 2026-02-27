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
    date,
);

CREATE TABLE signalements (
    id SERIAL PRIMARY KEY,
    date,
    description VARCHAR(100) NOT NULL,

);