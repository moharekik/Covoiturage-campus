<?php
// Paramètres de connexion à la base de données PostgreSQL
$host = 'localhost'; // ou l'adresse IP du serveur de base de données si différent
$port = '5432'; // Le port par défaut de PostgreSQL
$dbname = 'covoiturage_db';
$user = 'ljbira';
$password = 'Mpsi1mpsi1@Mpsi1mpsi1';

// Chaîne DSN (Data Source Name)
$dsn = "pgsql:host=$host;port=$port;dbname=$dbname;";

// Options pour la connexion PDO
$options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, // Active le rapport d'erreurs et les exceptions
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Configure le mode de récupération par défaut
    PDO::ATTR_EMULATE_PREPARES => false, // Désactive l'émulation des requêtes préparées
];

try {
    // Création d'une nouvelle instance de PDO
    $pdo = new PDO($dsn, $user, $password, $options);
    // Affichage d'un message si la connexion est établie
    echo "Connexion à la base de données réussie.";
} catch (PDOException $e) {
    // Gestion des erreurs de connexion
    die("Erreur de connexion à la base de données : " . $e->getMessage());
}
?>

