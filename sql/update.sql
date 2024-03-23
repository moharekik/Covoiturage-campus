--Des Exemples de mise à jour

--ajout d'une voiture :
INSERT INTO voiture (type, couleur, nombrePlacePassagers, etat, description, id_etudiant) VALUES ('Hatchback', 'Blanc', 5, 'Occasion', 'Économique et compacte', 4);

--supprimer un etudiant de la base :
DROP FROM etudiant WHERE id_etudiant=2;
DROP FROM trajet WHERE id_etudiant=2;
DROP FROM voiture WHERE id_etudiant=2;
DROP FROM avis WHERE id_etudiant=2;
DROP FROM inscription WHERE id_etudiant=2;

--changer numero de telephone d'un etudiant :
UPDATE etudiant SET tele='012121212' WHERE id_etudiant=1;


-- Ajouter une contrainte CHECK pour la note dans la table avis
ALTER TABLE avis
ADD CONSTRAINT check_note CHECK (note BETWEEN 1 AND 5);

-- Assurer qu'un étudiant ne possède qu'une seule voiture
ALTER TABLE voiture
ADD CONSTRAINT unique_etudiant UNIQUE (id_etudiant);

-- Assurer que la date de départ d'un trajet est dans le futur
ALTER TABLE trajet
ADD CONSTRAINT check_dateDepart CHECK (dateDepart > CURRENT_DATE);