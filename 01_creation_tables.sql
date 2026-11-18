/* Par dépendances, je supprime à chaque fois les différentes tables et les recrée. */
DROP TABLE IF EXISTS details_commandes;
DROP TABLE IF EXISTS  commandes;
DROP TABLE IF EXISTS  produits;
DROP TABLE IF EXISTS  categories;
DROP TABLE IF EXISTS  clients;



/*Création des differentes tables */


CREATE TABLE clients  (
	id_client INTEGER NOT NULL,
	nom_client TEXT NOT NULL,
	email_client TEXT NOT NULL,
	ville_client TEXT NOT NULL,
	date_inscription_client Date NOT NULL,
	CONSTRAINT id_client PRIMARY key (id_client)
	
  );

CREATE TABLE categories (
	id_categorie INTEGER NOT NULL,
	nom_categorie TEXT NOT NULL,
	CONSTRAINT id_categorie PRIMARY key (id_categorie)
	
);

CREATE TABLE produits (
	id_produit INTEGER NOT NULL,
	nom_produit TEXT NOT NULL,
	prix_produit INTEGER NOT NULL,
	stock_produit INTEGER NOT NULL,
	id_categorie INTEGER NOT NULL,
	CONSTRAINT id_produit PRIMARY key (id_produit),
	CONSTRAINT fk_produits FOREIGN KEY (id_categorie ) REFERENCES  categories(id_categorie)
	
);


CREATE TABLE commandes(
	id_commande INTEGER NOT NULL,
	id_client INTEGER NOT NULL,
	date_commande DATE NOT NULL,
	statut TEXT NOT NULL,
	CONSTRAINT id_commande PRIMARY KEY (id_commande),
	CONSTRAINT fk_commandes
        FOREIGN KEY (id_client) REFERENCES clients(id_client)
);


CREATE TABLE details_commandes (
	id_detail INTEGER NOT NULL,
	id_commande  INTEGER NOT NULL,
	id_produit INTEGER NOT NULL,
	quantite INTEGER NOT NULL,
	prix_unitaire NUMERIC NOT NULL,
	CONSTRAINT id_detail PRIMARY key (id_detail),
	CONSTRAINT fk_details_commandes
        FOREIGN KEY (id_commande) REFERENCES commandes(id_commande)
	CONSTRAINT fk_details_commandes
        FOREIGN KEY (id_produit) REFERENCES produits(id_produit)
	
	
);