-- Informations sur les conducteurs
SELECT DISTINCT E.ID_ETUDIANT, E.NOM, E.PRENOM, E.TELE, E.EMAIL, V.type, V.couleur
FROM Etudiant E
INNER JOIN Voiture V ON E.ID_ETUDIANT = V.ID_Etudiant;

-- Informations sur les passagers

SELECT DISTINCT E.ID_ETUDIANT, E.NOM, E.PRENOM, E.TELE, E.EMAIL
FROM Etudiant E
INNER JOIN Inscription I ON E.ID_ETUDIANT = I.ID_ETUDIANT;

--liste des véhicules disponibles pour un jour donné pour une ville donnée--

CREATE OR REPLACE FUNCTION GetAvailableCars(dateDepart_param DATE, villeDepart_param VARCHAR(255))
RETURNS TABLE (Couleur VARCHAR, type VARCHAR, nombrePlacesPassagers INT, etat VARCHAR, description VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT V.Couleur, V.type, V.nombrePlacePassagers, V.etat, V.description
    FROM Voiture V
    LEFT JOIN Inscription I ON V.ID_Etudiant = I.ID_Etudiant
    WHERE I.id_trajet NOT IN (
        SELECT T.ID_TRAJET
        FROM trajet T
        WHERE T.dateDepart = dateDepart_param
          AND T.villeDepart = villeDepart_param
      );
END;
$$ LANGUAGE plpgsql;


-- Trajets proposés dans un intervalle de jours

CREATE OR REPLACE FUNCTION GetTripsWithinDateRange(dateDebut DATE, dateFin DATE)
RETURNS TABLE (id_trajet INT, villeDepart VARCHAR, villeArrivee VARCHAR, dateDepart DATE, heureDepart TIME, dureeEstimee INT, distance INT, contribution DECIMAL, id_etudiant INT) AS $$
BEGIN
    RETURN QUERY
    SELECT T.*
    FROM trajet T
    WHERE T.dateDepart BETWEEN dateDebut AND dateFin;
END;
$$ LANGUAGE plpgsql;


-- Liste des villes entre le campus et une ville donnée

CREATE OR REPLACE FUNCTION GetCities(ville_param VARCHAR(255))
RETURNS TABLE (ville VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT PA.ville
    FROM PointArret PA
    INNER JOIN inclusion I ON PA.ID_PointArret = I.id_point_arret
    INNER JOIN trajet T ON I.ID_TRAJET = T.ID_TRAJET
    WHERE (T.villeArrivee = ville_param AND T.villeDepart = 'Campus')
       OR (T.villeArrivee = 'Campus' AND T.villeDepart = ville_param);
END;
$$ LANGUAGE plpgsql;




--------Les trajets pouvant desservir une ville donnée dans un intervalle de temps-------
CREATE OR REPLACE FUNCTION GetTripsForCityWithinTimeframe(
    villeDepartParam VARCHAR(255), 
    villeArriveeParam VARCHAR(255),
    dateDebut DATE, 
    dateFin DATE)
RETURNS TABLE (id_trajet INT, villeDepart VARCHAR, villeArrivee VARCHAR, dateDepart DATE, heureDepart TIME, dureeEstimee INT, distance INT, contribution DECIMAL, id_etudiant INT) AS $$
BEGIN
    RETURN QUERY
    SELECT T.*
    FROM trajet T
    WHERE T.villeDepart = villeDepartParam
      AND T.villeArrivee = villeArriveeParam
      AND T.dateDepart BETWEEN dateDebut AND dateFin;
END;
$$ LANGUAGE plpgsql;

-------moyenne des passagers sur l’ensemble des trajets effectués------

SELECT AVG(nombrePlacePassagers) AS MoyennePassagers
FROM Voiture V
INNER JOIN trajet T ON T.ID_Etudiant = V.ID_Etudiant;

---------moyenne des distances parcourues en covoiturage par jour---------

SELECT EXTRACT(YEAR FROM dateDepart) AS Annee,
       EXTRACT(MONTH FROM dateDepart) AS Mois,
       EXTRACT(DAY FROM dateDepart) AS Jour,
       AVG(Distance) AS MoyenneDistance
FROM trajet
GROUP BY EXTRACT(YEAR FROM dateDepart), 
         EXTRACT(MONTH FROM dateDepart), 
         EXTRACT(DAY FROM dateDepart);

---------classement des meilleurs conducteurs d’aprés les avis------

SELECT E.ID_ETUDIANT, E.NOM, E.PRENOM, AVG(A.Note) AS MoyenneNote
FROM Etudiant E
INNER JOIN Avis A ON E.ID_ETUDIANT = A.ID_Etudiant
GROUP BY E.ID_ETUDIANT, E.NOM, E.PRENOM
ORDER BY MoyenneNote DESC;

----------classement des villes selon le nombre de trajets qui les dessert-----------

SELECT villedepart, COUNT(*) AS NombreTrajets
FROM trajet
GROUP BY villedepart
ORDER BY NombreTrajets DESC;