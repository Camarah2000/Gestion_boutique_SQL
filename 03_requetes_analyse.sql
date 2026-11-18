
/* Requête 1*/
select *
from clients;
/* Requête  2*/
select *
from produits
where prix_produit > 50;
/*Requête  3*/
select *
from  produits
where stock_produit <10;
/*Requête  4*/
select *
from produits
ORDER BY prix_produit ASC;
/* Requête  5*/
select count(*)
from clients;
/* Requête  6*/
select id_commande,nom_client
from commandes JOIN clients using(id_client);
 
/* Requête  9*/
select nom_client,(quantite*prix_unitaire) as montant_depense
from clients join commandes using(id_client) join details_commandes USING (id_commande)
GROUP BY id_client,nom_client;
/* Requête  10*/
SELECT nom_categorie,id_produit
FROM categories JOIN produits USING(id_categorie)
GROUP by nom_categorie,id_produit
HAVING (id_produit) > 5;
/* Requête  11*/
SELECT nom_client,SUM(quantite * prix_unitaire) AS montant_depense
FROM clients JOIN commandes USING(id_client) JOIN details_commandes USING(id_commande)
GROUP BY id_client, nom_client
ORDER BY montant_depense DESC
LIMIT 1;
/* Requête  12*/
SELECT nom_produit
FROM produits
WHERE NOT EXISTS (
    SELECT 1
    FROM details_commandes
	WHERE id_produit = id_produit
);
/* Requête 13 : Chiffre d'affaires par mois */

SELECT strftime('%Y-%m', date_commande) AS mois,SUM(quantite * prix_unitaire) AS chiffre_affaires
FROM commandes
JOIN details_commandes USING (id_commande)
GROUP BY strftime('%Y-%m', date_commande)
ORDER BY mois ASC;
/* Requête  14 chaque client se qu'il àdepenser dabors */
SELECT
    nom_client,
    SUM(quantite * prix_unitaire) AS depense
FROM clients
JOIN commandes USING(id_client)
JOIN details_commandes USING(id_commande)
GROUP BY id_client, nom_client
HAVING SUM(quantite * prix_unitaire) > (
    SELECT AVG(total_depense)
    FROM (
        SELECT
            SUM(quantite * prix_unitaire) AS total_depense
        FROM commandes
        JOIN details_commandes USING(id_commande)
        GROUP BY id_client
    )
);
