-- Suppression des tables si elles existent
DROP TABLE IF EXISTS inscription CASCADE;
DROP TABLE IF EXISTS inclusion CASCADE;
DROP TABLE IF EXISTS avis CASCADE;
DROP TABLE IF EXISTS trajet CASCADE;
DROP TABLE IF EXISTS voiture CASCADE;
DROP TABLE IF EXISTS etudiant CASCADE;
DROP TABLE IF EXISTS pointArret CASCADE;

-- Création de nouvelles tables
CREATE TABLE etudiant (
    id_etudiant SERIAL NOT NULL,
    nom VARCHAR(25) NOT NULL,
    prenom VARCHAR(25),
    tele VARCHAR(20),
    email VARCHAR(75),
    CONSTRAINT pk_etudiant PRIMARY KEY (id_etudiant)
);

CREATE TABLE pointArret (
    id_pointArret SERIAL NOT NULL,
    ville VARCHAR(20) NOT NULL,
    date DATE,
    heure TIME,
    duree INT,
    CONSTRAINT pk_pointArret PRIMARY KEY (id_pointArret)
);

CREATE TABLE trajet (
    id_trajet SERIAL NOT NULL,
    villeDepart VARCHAR(30) NOT NULL,
    villeArrivee VARCHAR(30) NOT NULL,
    dateDepart DATE NOT NULL,
    heureDepart TIME NOT NULL,
    dureeEstimee INT,
    distance INT,
    contribution DECIMAL(10, 2),
    id_etudiant INT NOT NULL,
    CONSTRAINT pk_trajet PRIMARY KEY (id_trajet),
    FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant)
);

CREATE TABLE avis (
    id_avis SERIAL NOT NULL,
    note INT NOT NULL,
    commentaire VARCHAR(255),
    id_trajet INT NOT NULL,
    id_etudiant INT NOT NULL,
    CONSTRAINT pk_avis PRIMARY KEY (id_avis),
    FOREIGN KEY (id_trajet) REFERENCES trajet(id_trajet),
    FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant)
);

CREATE TABLE voiture (
    id_voiture SERIAL NOT NULL,
    type VARCHAR(30) NOT NULL,
    couleur VARCHAR(30) NOT NULL,
    nombrePlacePassagers INT,
    etat VARCHAR(30) NOT NULL,
    description VARCHAR(255),
    id_etudiant INT,
    CONSTRAINT pk_voiture PRIMARY KEY (id_voiture),
    FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant)
);

CREATE TABLE inclusion (
    id_trajet INT NOT NULL,
    id_point_arret INT NOT NULL,
    validation BOOLEAN NOT NULL,
    CONSTRAINT pk_inclusion PRIMARY KEY (id_trajet, id_point_arret),
    FOREIGN KEY (id_trajet) REFERENCES trajet(id_trajet),
    FOREIGN KEY (id_point_arret) REFERENCES pointArret(id_pointArret)
);

CREATE TABLE inscription (
    id_etudiant INT NOT NULL,
    id_trajet INT NOT NULL,
    id_point_arret INT NOT NULL,
    validation BOOLEAN NOT NULL,
    CONSTRAINT pk_inscription PRIMARY KEY (id_etudiant, id_trajet, id_point_arret),
    FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant),
    FOREIGN KEY (id_trajet) REFERENCES trajet(id_trajet),
    FOREIGN KEY (id_point_arret) REFERENCES pointArret(id_pointArret)
);
    