INSERT INTO etudiant (nom, prenom, tele, email) VALUES 
('Dupont', 'Jean', '0123456789', 'jean.dupont@email.com'),
('Durand', 'Marie', '9876543210', 'marie.durand@email.com'),
('Leroy', 'Alice', '1234567890', 'alice.leroy@email.com'),
('Martin', 'Paul', '0456789123', 'paul.martin@email.com'),
('Petit', 'Emma', '0567891234', 'emma.petit@email.com'),
('Bernard', 'Lucas', '0678912345', 'lucas.bernard@email.com');

INSERT INTO pointArret (ville, date, heure, duree) VALUES 
('Paris', '2023-11-20', '08:00', 30),
('Lyon', '2023-11-21', '10:00', 15),
('Marseille', '2023-11-22', '15:00', 20),
('Nice', '2023-11-23', '09:00', 25),
('Valence', '2023-11-24', '10:30', 20),
('Toulouse', '2023-11-25', '16:00', 15);


INSERT INTO trajet (villeDepart, villeArrivee, dateDepart, heureDepart, dureeEstimee, distance, contribution, id_etudiant) VALUES 
('Campus', 'Lyon', '2023-11-20', '07:00', 240, 500, 20.00, 1),
('Campus', 'Marseille', '2023-11-21', '09:00', 180, 300, 15.00, 2),
('Marseille', 'Campus', '2023-11-23', '08:00', 120, 200, 10.00, 3),
('Paris', 'Campus', '2023-11-24', '11:00', 180, 550, 25.00, 4),
('Toulouse', 'Campus', '2023-11-25', '15:00', 210, 360, 18.00, 5);

INSERT INTO avis (note, commentaire, id_trajet, id_etudiant) VALUES 
(4, 'Très bon voyage', 1, 2),
(5, 'Excellent conducteur', 2, 1),
(3, 'Confortable, mais un peu en retard', 1, 3),
(5, 'Voyage impeccable', 3, 4),
(4, 'Conduite agréable', 4, 5),
(3, 'Espace suffisant', 5, 6);

INSERT INTO voiture (type, couleur, nombrePlacePassagers, etat, description, id_etudiant) VALUES 
('Berline', 'Noir', 4, 'Neuf', 'Confortable et spacieuse', 1),
('Compact', 'Bleu', 3, 'Bon', 'Idéale pour la ville', 2),
('SUV', 'Gris', 1, 'Parfait', 'Parfait pour les longs trajets', 3),
('Monospace', 'Occasion', 3, 'Occasion', 'Idéal pour les groupes', 4),
('Coupé', 'Occasion', 2, 'Neuf', 'Voiture sportive et rapide', 5);

INSERT INTO inscription (id_etudiant, id_trajet, id_point_arret, validation) VALUES 
(2, 1, 1, TRUE),
(3, 2, 2, FALSE),
(4, 3, 3, TRUE),
(5, 4, 4, TRUE),
(6, 5, 5, FALSE);

INSERT INTO inclusion (id_trajet, id_point_arret, validation) VALUES 
(2,3,TRUE),
(4,1,TRUE),
(5,6,TRUE),
(1,2,TRUE),
(1, 1, TRUE),
(2, 2, FALSE),
(3, 3, TRUE),
(4, 4, TRUE),
(5, 5, FALSE);

