<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
// Inclure le fichier de configuration de la base de données
include 'config.php';
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Application de Covoiturage</title>
    <!-- Lien vers le fichier CSS pour styliser la page -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>Bienvenue sur l'Application de Covoiturage</h1>
    </header>
    
    <main>
        <p>Ceci est la page d'accueil de votre application de covoiturage. Utilisez le menu ci-dessus pour naviguer.</p>
        <!-- Ici, vous pourriez ajouter du PHP pour afficher des données de la base de données, par exemple -->
        <?php
        // Exemple de récupération de données et d'affichage
        try {
            echo "1";
            
            $stmt = $pdo->query('SELECT * FROM etudiant');
            echo "$stmt";
            echo "<ul>";
            while ($row = $stmt->fetch()) {
                echo "<li>" . htmlspecialchars($row['nom']) . " " . htmlspecialchars($row['prenom']) . "</li>";
            }
            echo "</ul>";
        } catch (Exception $e) {
            echo "Erreur : " . $e->getMessage();
        }
        ?>
    
    <h2>Informations sur les passagers</h2>
    <?php
        
        include "connect_pg.php"; /* Le fichier connect_pg.php contient les identifiants de connexion */
        $requete = "SELECT DISTINCT E.ID_ETUDIANT, E.NOM, E.PRENOM, E.TELE, E.EMAIL
        FROM Etudiant E
        INNER JOIN Inscription I ON E.ID_ETUDIANT = I.ID_ETUDIANT;";
             /* Si l'execution est reussie... */
      $res = pg_query($connection, $requete);
          if($res) {
     ?>
     <table>
       <tr>
           <?php
              $n = pg_num_fields($res);
              echo $n;
              for($i = 0; $i<$n; $i++) {
                  echo "<th>";
                  echo pg_field_name($res, $i);
                  echo "</th>\n";
              }
           ?>
       </tr>
    <?php
                /* ... on récupère un tableau stockant le résultat */
            while ($tab =  pg_fetch_array($res)) {
              echo '<tr>';
              for($i = 0; $i<$n; $i++) {
                echo '<td>';
                echo $tab[$i];
                echo '</td>';
              }
              echo '</tr>'."\n";
            }
            /*liberation de l'objet requete:*/
          }
     pg_free_result($res);
    /*fermeture de la connexion avec la base*/
         pg_close($connection);
?>
    <h2>Informations sur les conduceurs</h2>
    <?php
        include "connect_pg.php"; /* Le fichier connect_pg.php contient les identifiants de connexion */
        $requete = "SELECT DISTINCT E.ID_ETUDIANT, E.NOM, E.PRENOM, E.TELE, E.EMAIL, V.type, V.couleur
        FROM Etudiant E
        INNER JOIN Voiture V ON E.ID_ETUDIANT = V.ID_Etudiant;";
             /* Si l'execution est reussie... */
      $res = pg_query($connection, $requete);
          if($res) {
     ?>
     <table>
       <tr>
           <?php
              $n = pg_num_fields($res);
              echo $n;
              for($i = 0; $i<$n; $i++) {
                  echo "<th>";
                  echo pg_field_name($res, $i);
                  echo "</th>\n";
              }
           ?>
       </tr>
    <?php
                /* ... on récupère un tableau stockant le résultat */
            while ($tab =  pg_fetch_array($res)) {
              echo '<tr>';
              for($i = 0; $i<$n; $i++) {
                echo '<td>';
                echo $tab[$i];
                echo '</td>';
              }
              echo '</tr>'."\n";
            }
            /*liberation de l'objet requete:*/
          }
     pg_free_result($res);
    /*fermeture de la connexion avec la base*/
         pg_close($connection);
?>

<h2>Moyenne des passagers sur l’ensemble des trajets effectués</h2>
<?php
        include "connect_pg.php"; /* Le fichier connect_pg.php contient les identifiants de connexion */
        $requete = "SELECT AVG(nombrePlacePassagers) AS MoyennePassagers
        FROM Voiture V
        INNER JOIN trajet T ON T.ID_Etudiant = V.ID_Etudiant;";
             /* Si l'execution est reussie... */
      $res = pg_query($connection, $requete);
      if ($res) {
        $row = pg_fetch_assoc($res); // Récupère la ligne de résultat
        $moyenne = $row['moyennepassagers']; // Récupère la moyenne des places passagers
?>
        <table>
            <tr>
                <th>Moyenne Passagers</th>
            </tr>
            <tr>
                <td><?php echo $moyenne; ?></td> <!-- Affichage de la moyenne des places passagers -->
            </tr>
        </table>
<?php
        pg_free_result($res); // Libération des résultats de la requête
    }
    pg_close($connection); // Fermeture de la connexion avec la base de données
?>

<h2>Moyenne des distances parcourues en covoiturage par jour</h2>

<?php
        include "connect_pg.php"; /* Le fichier connect_pg.php contient les identifiants de connexion */
        $requete = "SELECT EXTRACT(YEAR FROM dateDepart) AS Annee,
        EXTRACT(MONTH FROM dateDepart) AS Mois,
        EXTRACT(DAY FROM dateDepart) AS Jour,
        AVG(Distance) AS MoyenneDistance
 FROM trajet
 GROUP BY EXTRACT(YEAR FROM dateDepart), 
          EXTRACT(MONTH FROM dateDepart), 
          EXTRACT(DAY FROM dateDepart);";
             /* Si l'execution est reussie... */
      $res = pg_query($connection, $requete);
          if($res) {
     ?>
     <table>
       <tr>
           <?php
              $n = pg_num_fields($res);
              echo $n;
              for($i = 0; $i<$n; $i++) {
                  echo "<th>";
                  echo pg_field_name($res, $i);
                  echo "</th>\n";
              }
           ?>
       </tr>
    <?php
                /* ... on récupère un tableau stockant le résultat */
            while ($tab =  pg_fetch_array($res)) {
              echo '<tr>';
              for($i = 0; $i<$n; $i++) {
                echo '<td>';
                echo $tab[$i];
                echo '</td>';
              }
              echo '</tr>'."\n";
            }
            /*liberation de l'objet requete:*/
          }
     pg_free_result($res);
    /*fermeture de la connexion avec la base*/
         pg_close($connection);
?>


<h2>Classement des meilleurs conducteurs d’aprés les avis</h2>

<?php
        include "connect_pg.php"; /* Le fichier connect_pg.php contient les identifiants de connexion */
        $requete = "SELECT E.ID_ETUDIANT, E.NOM, E.PRENOM, AVG(A.Note) AS MoyenneNote
        FROM Etudiant E
        INNER JOIN Avis A ON E.ID_ETUDIANT = A.ID_Etudiant
        GROUP BY E.ID_ETUDIANT, E.NOM, E.PRENOM
        ORDER BY MoyenneNote DESC;";
             /* Si l'execution est reussie... */
      $res = pg_query($connection, $requete);
          if($res) {
     ?>
     <table>
       <tr>
           <?php
              $n = pg_num_fields($res);
              echo $n;
              for($i = 0; $i<$n; $i++) {
                  echo "<th>";
                  echo pg_field_name($res, $i);
                  echo "</th>\n";
              }
           ?>
       </tr>
    <?php
                /* ... on récupère un tableau stockant le résultat */
            while ($tab =  pg_fetch_array($res)) {
              echo '<tr>';
              for($i = 0; $i<$n; $i++) {
                echo '<td>';
                echo $tab[$i];
                echo '</td>';
              }
              echo '</tr>'."\n";
            }
            /*liberation de l'objet requete:*/
          }
     pg_free_result($res);
    /*fermeture de la connexion avec la base*/
         pg_close($connection);
?>


<h2>Classement des villes selon le nombre de trajets qui les dessert</h2>


<?php
        include "connect_pg.php"; /* Le fichier connect_pg.php contient les identifiants de connexion */
        $requete = "SELECT villedepart, COUNT(*) AS NombreTrajets
        FROM trajet
        GROUP BY villedepart
        ORDER BY NombreTrajets DESC;";
             /* Si l'execution est reussie... */
      $res = pg_query($connection, $requete);
          if($res) {
     ?>
     <table>
       <tr>
           <?php
              $n = pg_num_fields($res);
              echo $n;
              for($i = 0; $i<$n; $i++) {
                  echo "<th>";
                  echo pg_field_name($res, $i);
                  echo "</th>\n";
              }
           ?>
       </tr>
    <?php
                /* ... on récupère un tableau stockant le résultat */
            while ($tab =  pg_fetch_array($res)) {
              echo '<tr>';
              for($i = 0; $i<$n; $i++) {
                echo '<td>';
                echo $tab[$i];
                echo '</td>';
              }
              echo '</tr>'."\n";
            }
            /*liberation de l'objet requete:*/
          }
     pg_free_result($res);
    /*fermeture de la connexion avec la base*/
         pg_close($connection);
?>

    </main>
    
    <footer>
        <p>&copy; <?php echo date('Y'); ?> Application de Covoiturage</p>
    </footer>
</body>
</html>
