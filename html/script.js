 // Récupération des formulaires
 const formInscription = document.getElementById("submit_inscription");
 const formPublication = document.getElementById("submit_publication");

 // Écouteurs d'événements pour la soumission des formulaires
 formInscription.addEventListener('DOMContentLoaded', function(event) {
     event.preventDefault(); // Empêche le rechargement de la page
     const numeroEtudiant = document.getElementById("numero_etudiant").value;
     const nom = document.getElementById('nom').value;
     console.log(nom);
     const prenom = document.getElementById('prenom').value;
     const email = document.getElementById('email').value;
     const telephone = document.getElementById('telephone').value;
     const conducteur = document.getElementById('conducteur').checked ? 'Oui' : 'Non';

     const tableauInscrits = document.querySelector('#tbodyInscrits');
     const nouvelleLigne = tableauInscrits.insertRow(-1);
     const celluleNumero = nouvelleLigne.insertCell(0);
     const celluleNom = nouvelleLigne.insertCell(1);
     const cellulePrenom = nouvelleLigne.insertCell(2);
     const celluleEmail = nouvelleLigne.insertCell(3);
     const celluleTelephone = nouvelleLigne.insertCell(4);
     const celluleConducteur = nouvelleLigne.insertCell(5);

     celluleNumero.textContent = numeroEtudiant;
     celluleNom.textContent = nom;
     cellulePrenom.textContent = prenom;
     celluleEmail.textContent = email;
     celluleTelephone.textContent = telephone;
     celluleConducteur.textContent = conducteur;

     // Efface les champs après l'ajout
     formInscription.reset();
 });

 formPublication.addEventListener('DOMContentLoaded', function(event) {
     event.preventDefault(); // Empêche le rechargement de la page
     const lieuDepart = document.querySelector('#lieu_depart').value;
     const trajetRegulier = document.querySelector('#trajet_regulier').checked ? 'Oui' : 'Non';
     const dateDepart = document.querySelector('#date_depart').value;
     const lieuArrivee = document.querySelector('#lieu_arrivee').value;

     const tableauPublications = document.querySelector('#tbodyPublications');
     const nouvelleLigne = tableauPublications.insertRow(-1);
     const celluleLieuDepart = nouvelleLigne.insertCell(0);
     const celluleTrajetRegulier = nouvelleLigne.insertCell(1);
     const celluleDateDepart = nouvelleLigne.insertCell(2);
     const celluleLieuArrivee = nouvelleLigne.insertCell(3);

     celluleLieuDepart.textContent = lieuDepart;
     celluleTrajetRegulier.textContent = trajetRegulier;
     celluleDateDepart.textContent = dateDepart;
     celluleLieuArrivee.textContent = lieuArrivee;

     // Efface les champs après l'ajout
     formPublication.reset();
 });