/* script créé le : Thu Nov 18 02:23:43 CET 2010 ;
*  Author : Djebien Tarik;
*/

/* scriptSQL de creation du MLD de HOPITAL */


/* TABLE PATIENTS */

DROP TABLE IF EXISTS PATIENTS ;

CREATE TABLE PATIENTS (
numpat NUMBER  NOT NULL,
nom VARCHAR2(30),
prenom VARCHAR2(30),
ville VARCHAR2(50),
sexe CHAR(1),
constraint "PATIENTS_PK" PRIMARY KEY (numpat)
);


/*Donnée pour la table PATIENTS */

INSERT INTO patients VALUES (1, 'MOUGIN', 'PIERRE', 'DOUAI','M');
INSERT INTO patients VALUES (2, 'PIERRARD', 'ROGER', 'DOUAI','M');
INSERT INTO patients VALUES (3, 'TRENTA', 'ADELINE', 'TOURCOING','F');
INSERT INTO patients VALUES (4, 'MOSKOWITCH', 'MICHEL', 'MARCQ EN BAROEUL','M');
INSERT INTO patients VALUES (5, 'DELAPORTE', 'STEPHANE', 'LA MADELEINE','M');
INSERT INTO patients VALUES (6, 'AMBERT', 'SOPHIE', 'ARRAS','F');
INSERT INTO patients VALUES (7, 'ZATOPEK', 'ANDRE', 'LAMBERSART','M');
INSERT INTO patients VALUES (8, 'AYMARD', 'RENE', 'LILLE','M');
INSERT INTO patients VALUES (9, 'BENABAR', 'JEAN-PIERRE', 'ARRAS','M');
INSERT INTO patients VALUES (10, 'PERROCHON', 'MARC', 'ROUBAIX','M');
INSERT INTO patients VALUES (11, 'BONIFACE', 'JEAN', 'DOUAI','M');
INSERT INTO patients VALUES (12, 'MOUNIER', 'ANNE-MARIE', 'ARRAS','F');
INSERT INTO patients VALUES (13, 'PERCEVAL', 'GAEL', 'ROUBAIX','M');
INSERT INTO patients VALUES (14, 'SAUNIERE', 'CHARLES', 'DOUAI','M');
INSERT INTO patients VALUES (15, 'CAPITANO', 'ANGELO', 'TOURCOING','M');
INSERT INTO patients VALUES (16, 'BUGARACH', 'JEAN-MARC', 'LILLE','M');
INSERT INTO patients VALUES (17, 'VALMIGERE', 'PIERRE', 'MARCQ EN BAROEUL','M');
INSERT INTO patients VALUES (18, 'SOUBEYRAN', 'ANNE-SOPHIE', 'ARRAS','F');
INSERT INTO patients VALUES (19, 'DUPUIS', 'PIERRE-ANDRE', 'MARCQ EN BAROEUL','M');
INSERT INTO patients VALUES (20, 'MARTIN', 'ANNE-SOPHIE', 'ROUBAIX','F');
INSERT INTO patients VALUES (21, 'BUFFIERE', 'PIERRE', 'LAMBERSART','M');
INSERT INTO patients VALUES (22, 'LECHAT', 'EMMANUEL', 'LA MADELEINE','M');
INSERT INTO patients VALUES (23, 'LACROIX', 'DANIEL', 'LILLE','M');
INSERT INTO patients VALUES (24, 'POIMULLE', 'JEAN-CLAUDE', 'HEM','M');
INSERT INTO patients VALUES (25, 'GOMBERT', 'MARCEL', 'ROUBAIX','M');
INSERT INTO patients VALUES (26, 'LABRICOLE', 'ADRIEN', 'LILLE','M');
INSERT INTO patients VALUES (27, 'DESSERPRIX', 'JEAN-PIERRE', 'LILLE','M');
INSERT INTO patients VALUES (28, 'JURANSSON', 'CATHERINE', 'MARCQ EN BAROEUL','F');
INSERT INTO patients VALUES (29, 'KERMORAL', 'ANNE', 'LAMBERSART','F');
INSERT INTO patients VALUES (30, 'STUPP', 'KARL', 'LA MADELEINE','M');
INSERT INTO patients VALUES (31, 'GOEDEL', 'THEOPHILE', 'LILLE','M');
INSERT INTO patients VALUES (32, 'BRICOUT', 'JULES', 'ROUBAIX','M');


/* TABLE MEDECINS */


DROP TABLE IF EXISTS MEDECINS ;

CREATE TABLE MEDECINS (
numed NUMBER  NOT NULL,
nom_med VARCHAR2(30),
prenom_med VARCHAR2(30),
specialite VARCHAR2(50),
numservDeTravaille NUMBER NOT NULL,
numservDuChef NUMBER NOT NULL,
constraint "MEDECINS_PK" PRIMARY KEY (numed)
);


/*Donnée pour la table MEDECINS */

/*
Incohérence et contradiction dans les insertions fournies  :
   - on a un attribut service de type VARCHAR dans la creation de table alors que dans les insertions de donnée les services sont des valeurs de types entieres.
   => Solution : on remplace VARCHAR par NUMBER car on a ici une clé etrangere qui reference la clé primaire de la table SERVICE qui est un NUMBER.

   - le MCD de base du sujet produit le MLD fournit dans mon archive.
     Celui ci montre que des nouvelle clé etrangere sont crées dans la table MEDECINS à cause
     des liens hierarchique avec l'association TRAVAILLE et fonctionnel avec l'association CHEF.
     Le respect des contraintes référentielles maintient une base cohérente et utilisable dans la pratique.
     En effet, on a ici par exemple, FK_MEDECINS_numservDeTravaille et FK_MEDECINS_numservDuChef,
     deux clé étrangères issues des associations TRAVAILLE et CHEF qui sont ici completement inexistante dans les insertions de données.

Solution envisageable :
   - Etant donné que le sujet n'a pas respecté les contraintes d'intégrité référentielle apparu lord du passage MCD vers MLD,
     nous sommes dans l'obligation de recréer toutes les insertions susceptible de provoquer des erreurs de compilations dans le SGBD
     de manières à ce que l'ensemble des données insérées dans chaques uplets soit cohérente avec les types des attributs de la table MEDECINS du MLD de la Base Hopital.

Solution adopté pour ce cas précis:
   - Ici on a supprimé service VARCHAR2(50) qui était inutile et inaproprié.
   - On decide d'attribuer à chaque medecins un chef de service dont le service existe dans la table SERVICE pour respecter la clé etrangere.
   - On choisira aleatoirement des valeurs existantes dans la table service, ainsi un cardiologue peut etre dirigé par le chef des urgences par exemple.
*/

INSERT INTO medecins VALUES (1, 'DUPONT', 'ERIC', 'cardiologue',1,4);
INSERT INTO medecins VALUES (3, 'CONTE', 'HONORE', 'cardiologue',1,2);
INSERT INTO medecins VALUES (6, 'PENET', 'LOUISE', 'urgentiste',2,3);
INSERT INTO medecins VALUES (7, 'DELCOURT', 'FLORENCE', 'médecine générale',3,4);
INSERT INTO medecins VALUES (8, 'CASPER', 'ARMAND',' chirurgien',2,5);
INSERT INTO medecins VALUES (9, 'COURTIN', 'GERARD', 'rhumatologue',2,3);
INSERT INTO medecins VALUES (10, 'DECLERC', 'HENRI', 'chirurgien',4,1);
INSERT INTO medecins VALUES (12, 'WILLIAMS', 'GEORGE', 'cardiologue',1,5);
INSERT INTO medecins VALUES (13, 'BEAUCHAMP', 'EMILIE', 'radiologue',2,2);
INSERT INTO medecins VALUES (14, 'VANASTEN', 'ROBERT', 'radiologue',1,2);
INSERT INTO medecins VALUES (15, 'DELFOSSE', 'LUCIEN', 'médecine générale',2,1);
INSERT INTO medecins VALUES (16, 'SCHMIDT', 'ANDRE', 'hématologue',3,4);
INSERT INTO medecins VALUES (17, 'MARTIN', 'ALAIN', 'maladies infectieuses',3,5);
INSERT INTO medecins VALUES (18, 'DUPONT', 'ERIC', 'cancérologue',5,1);
INSERT INTO medecins VALUES (19, 'LUCAS', 'ANNIE', 'cardiologue',1,2);
INSERT INTO medecins VALUES (20, 'THERY', 'GERARD', 'chirurgien',4,4);
INSERT INTO medecins VALUES (21, 'WOLNIEWICZ', 'IRENA', 'cancérologue',1,3);
INSERT INTO medecins VALUES (25, 'DUMONT', 'VERONIQUE', 'radiologue',4,5);
INSERT INTO medecins VALUES (22, 'MISSEGRE', 'HELENE', 'immunologie', 5,1);

/* TABLE SERVICES */


DROP TABLE IF EXISTS SERVICES ;

CREATE TABLE SERVICES (
numserv NUMBER  NOT NULL,
nomserv VARCHAR2(30),
chef NUMBER NOT NULL,
tarif FLOAT,
constraint "SERVICES_PK" PRIMARY KEY (numserv)
);

/*Donnée pour la table SERVICES */

insert into services values(1,'Cardiologie',1,2500.99);
insert into services values(2, 'Urgences',21,499.99);
insert into services values(3,'Maladies infectieuses',16,1459.99);
insert into services values(4,'Chirurgie',7,3456.78);
insert into services values(5,'Immunologie',3,2323.23);

/* TABLE MEDICAMENTS */


DROP TABLE IF EXISTS MEDICAMENTS ;

CREATE TABLE MEDICAMENTS (
refmed NUMBER  NOT NULL,
designation VARCHAR2(30),
laboratoire VARCHAR2(30),
prix FLOAT,
constraint "MEDICAMENTS_PK" PRIMARY KEY (refmed)
);

/*Donnée pour la table MEDICAMENTS */

insert into medicaments values(1, 'aspirine', 'Ouille', 5.0);
insert into medicaments values(2,'sparadrap', 'Ouille', 2.5);
insert into medicaments values(3,'xanax',' Ducalme', 10.0);
insert into medicaments values(4,'maxiton', 'Ducalme', 8.0);
insert into medicaments values(5,'arsenic', 'Radical', 10.0);
insert into medicaments values(6,'cyanure', 'Radical', 8.0);
insert into medicaments values(7,'jus de carotte bio', 'Chouxrave', 20.0);

/* TABLE ANALYSES */


DROP TABLE IF EXISTS ANALYSES ;

CREATE TABLE ANALYSES (
numanl NUMBER  NOT NULL,
designation_anl VARCHAR2(30),
laboratoire_anl NUMBER NOT NULL,
prix_anl FLOAT,
constraint "ANALYSES_PK" PRIMARY KEY (numanl)
);


/*Donnée pour la table ANALYSES */

insert into analyses values(1,'radio',2,60.0);
insert into analyses values(2,'scanner',2,120.0);
insert into analyses values(3,'scintigraphie',3,60.0);
insert into analyses values(4,'ecographie',4,50.0);
insert into analyses values(5,'numeration globulaire',1,15.0);
insert into analyses values(6,'détection virus',1,20.0);
insert into analyses values(7,'hormones',1,30.0);
insert into analyses values(8,'cholesterol',1,16.0);
insert into analyses values(9,'électro-cardiogramme',5,100.0);
insert into analyses values(10,'contrôle',6, 60.5);

/* TABLE RESULTATS */


DROP TABLE IF EXISTS RESULTATS ;

CREATE TABLE RESULTATS (
numres NUMBER  NOT NULL,
libelle VARCHAR2(100),
constraint "RESULTATS_PK" PRIMARY KEY (numres)
);

/*Donnée pour la table RESULTATS */

insert into resultats values(1,'pas terrible');
insert into resultats values(2,'bof');
insert into resultats values(3,'on ne voit rien');

/* TABLE LABORATOIRES */


DROP TABLE IF EXISTS LABORATOIRES ;

CREATE TABLE LABORATOIRES (
numlab NUMBER  NOT NULL,
nom_lab VARCHAR2(50),
constraint "LABORATOIRES_PK" PRIMARY KEY (numlab)
);


/*Donnée pour la table LABORATOIRES */

insert into laboratoires values(1,'analyses sanguines');
insert into laboratoires values(2, 'radiologie');
insert into laboratoires values(3,'scintigraphie');
insert into laboratoires values(4,'echographie');
insert into laboratoires values(5, 'électro-cardiologie');
insert into laboratoires values(6, 'médecine générale');


/* TABLE TARIFS */


DROP TABLE IF EXISTS TARIFS ;

CREATE TABLE TARIFS (
prix_journee NUMBER(10,2) NOT NULL,
prix_visite NUMBER(10,2) NOT NULL
);


/*Donnée pour la table TARIFS */

insert into tarifs values(300,35);

/* TABLE SEJOURS */


DROP TABLE IF EXISTS SEJOURS ;

CREATE TABLE SEJOURS (numsejour NUMBER  NOT NULL,
numpat NUMBER NOT NULL,
numserv NUMBER NOT NULL,
entree CHAR(10),
sortie CHAR(10),
constraint "SEJOURS_PK" PRIMARY KEY (numsejour,
numpat,
numserv)
);


/*Donnée pour la table SEJOURS */

insert into sejours values(1,1,1,'15/10/2006','18/10/2006');
insert into sejours values(2,5,3,'07/10/2006','12/11/2006');
insert into sejours values(3,1,2,'22/10/2006','25/10/2006');
insert into sejours values(4, 13, 4, '20/10/2006', '25/10/2006');
insert into sejours values(5, 25, 2, '28/10/2006', '29/10/2006');
insert into sejours values(6,16,4,'29/10/2006','02/11/2006');

/* TABLE VISITES */


DROP TABLE IF EXISTS VISITES ;

CREATE TABLE VISITES (numvisite NUMBER  NOT NULL,
numpat NUMBER NOT NULL,
numserv NUMBER NOT NULL,
numed NUMBER NOT NULL,
jour CHAR(10),
constraint "VISITES_PK" PRIMARY KEY (numvisite,
numpat,
numserv,
numed)
);

/*Donnée pour la table VISITES */

insert into visites values(1,1,1,19,'15/10/2006');
insert into visites values(2,5,3,17,'08/10/2006');
insert into visites values(3,1,1,19,'17/10/2006');
insert into visites values(4,5,3,17,'07/10/2006');
insert into visites values(5,5,3,17,'10/10/2006');
insert into visites values(6,5,3,16,'11/10/2006');
insert into visites values(7,1,2,25,'22/10/2006');
insert into visites values(8,1,2,19,'22/10/2006');
insert into visites values(9,1,2,12,'23/10/2006');
insert into visites values(10,1,2,19,'24/10/2006');
insert into visites values(11,17,2,15,'16/10/2006');
insert into visites values(12,26,4,20,'18/10/2006');
insert into visites values(13,28,3,17,'20/10/2006');
insert into visites values(14,32,2,13,'25/10/206');
insert into visites values(15,13,4,25,'21/10/2006');
insert into visites values(16,13,4,20,'24/10/2006');
insert into visites values(17,25,2,8,'28/10/2006');
insert into visites values(18,25,2,8,'02/11/2006');
insert into visites values(19,16,4,10,'30/10/2006');
insert into visites values(20,16,4,10,'01/11/2006');
insert into visites values(21,18,5,22,'05/11/2006');



/* TABLE SOINS */


DROP TABLE IF EXISTS SOINS ;

CREATE TABLE SOINS (numsoin NUMBER  NOT NULL,
numpat NUMBER NOT NULL,
numed NUMBER NOT NULL,
refmed NUMBER NOT NULL,
date_soin CHAR(10),
constraint "SOINS_PK" PRIMARY KEY (numsoin,
numpat,
numed,
refmed)
);


/*Donnée pour la table SOINS */

insert into soins values(1,1,19,1,'15/10/2006');
insert into soins values(2,1,19,3,'16/10/2006');
insert into soins values(3,1,19,7,'16/10/2006');
insert into soins values(4,1,19,1,'17/10/2006');
insert into soins values(5,5,17,1,'07/10/2006');
insert into soins values(6,5,17,3,'08/10/2006');
insert into soins values(7,1,25,4,'22/10/2006');
insert into soins values(8,1,19,1,'23/10/2006');
insert into soins values(9,1,12,3,'23/10/2006');
insert into soins values(10,1,19,2,'24/10/2006');
insert into soins values(11,17,15,1,'16/10/2006');
insert into soins values(12,26,20,1,'18/10/2006');
insert into soins values(13,28,17,2,'20/10/2006');
insert into soins values(14,32,13,1,'25/10/2006');
insert into soins values(15,13,25,1,'21/10/2006');
insert into soins values(16,13,25,2,'24/10/2006');
insert into soins values(17,13,20,3,'24/10/2006');
insert into soins values(18,25,8,7,'28/10/2006');
insert into soins values(19,25,8,5,'29/10/2006');
insert into soins values(20,25,8,6,'29/10/2006');
insert into soins values(21,16,10,7,'30/10/2006');
insert into soins values(22,16,10,1,'30/10/2006');
insert into soins values(23,18,22,1,'01/11/2006');
insert into soins values(24,18,22,4,'01/11/2006');
insert into soins values(25,18,22,7,'01/11/2006');


/* TABLE COMPATIBLES */


DROP TABLE IF EXISTS COMPATIBLES ;

CREATE TABLE COMPATIBLES (
refmed NUMBER  NOT NULL,
refmed_COMPATIBLES NUMBER NOT NULL,
constraint "COMPATIBLES_PK" PRIMARY KEY (refmed,
 refmed_COMPATIBLES)
);

/* TABLE REALISER */


DROP TABLE IF EXISTS REALISER ;

CREATE TABLE REALISER (numrealise NUMBER  NOT NULL,
numpat NUMBER NOT NULL,
numres NUMBER NOT NULL,
numanl NUMBER NOT NULL,
numed NUMBER NOT NULL,
date_analyse CHAR(10),
constraint "REALISER_PK" PRIMARY KEY (numrealise,
numpat,
numres,
numanl,
numed)
);

/* Donnée pour la table REALISER

  - valeur null remplacé par 2 pour numrealise = 9

  - numed remplacé par 3 pour numrealise = 2 (clé parent introuvable)
  update realiser set numed = 3 where numrealise=2;
  - numed remplacé par 6 pour numrealise = 3 (clé parent introuvable)
  update realiser set numed = 6 where numrealise=3;
  - numed remplacé par 7 pour numrealise = 5 (clé parent introuvable)
  update realiser set numed = 7 where numrealise=5;
  - numed remplacé par 12 pour numrealise = 11 (clé parent introuvable)
  update realiser set numed = 12 where numrealise=11;
  - numed remplacé par 16 pour numrealise = 4 (clé parent introuvable)
  update realiser set numed = 16 where numrealise=4;

Les insertions sont toute erronées dans la table realiser.
  - numres remplacé par 1,2 ou 3 pour tout les numrealise (clé parent introuvable)

*/

insert into realiser values(1,1,2,9,1,'16/10/2006');
insert into realiser values(2,1,3,10,3,'17/10/2006');
insert into realiser values(3,5,1,5,3,'10/10/2006');
insert into realiser values(4,5,1,10,6,'11/10/2006');
insert into realiser values(5,1,2,9,7,'22/10/2006');
insert into realiser values(6,1,1,2,6,'22/10/2006');
insert into realiser values(7,1,1,4,7,'23/10/2006');
insert into realiser values(8,1,1,10,8,'24/10/2006');
insert into realiser values(9,17,1,2,9,'16/10/2006');
insert into realiser values(10,26,2,1,10,'18/10/2006');
insert into realiser values(11,28,1,5,12,'20/10/2006');
insert into realiser values(12,32,1,1,12,'25/10/2006');
insert into realiser values(13,13,2,2,13,'22/10/2006');
insert into realiser values(14,13,2,5,14,'23/10/2006');
insert into realiser values(15,25,3,6,15,'28/10/2006');
insert into realiser values(16,25,3,8,16,'29/10/2006');
insert into realiser values(17,16,1,10,17,'30/10/2006');
insert into realiser values(18,16,1,10,18,'01/11/2006');
insert into realiser values(19,18,2,6,19,'05/11/2006');


/* ENSEMBLE DES CONTRAINTES REFERENTIELLES */

ALTER TABLE MEDECINS ADD CONSTRAINT FK_MEDECINS_numservDeTravaille FOREIGN KEY (numservDeTravaille) REFERENCES SERVICES (numserv);

ALTER TABLE MEDECINS ADD CONSTRAINT FK_MEDECINS_numservDuChef FOREIGN KEY (numservDuChef) REFERENCES SERVICES (numserv);

ALTER TABLE SERVICES ADD CONSTRAINT FK_SERVICES_numed FOREIGN KEY (chef) REFERENCES MEDECINS (numed);

ALTER TABLE ANALYSES ADD CONSTRAINT FK_ANALYSES_numlab FOREIGN KEY (laboratoire_anl) REFERENCES LABORATOIRES (numlab);

ALTER TABLE SEJOURS ADD CONSTRAINT FK_SEJOURS_numpat FOREIGN KEY (numpat) REFERENCES PATIENTS (numpat);

ALTER TABLE SEJOURS ADD CONSTRAINT FK_SEJOURS_numserv FOREIGN KEY (numserv) REFERENCES SERVICES (numserv);

ALTER TABLE VISITES ADD CONSTRAINT FK_VISITES_numpat FOREIGN KEY (numpat) REFERENCES PATIENTS (numpat);

ALTER TABLE VISITES ADD CONSTRAINT FK_VISITES_numserv FOREIGN KEY (numserv) REFERENCES SERVICES (numserv);

ALTER TABLE VISITES ADD CONSTRAINT FK_VISITES_numed FOREIGN KEY (numed) REFERENCES MEDECINS (numed);

ALTER TABLE SOINS ADD CONSTRAINT FK_SOINS_numpat FOREIGN KEY (numpat) REFERENCES PATIENTS (numpat);

ALTER TABLE SOINS ADD CONSTRAINT FK_SOINS_numed FOREIGN KEY (numed) REFERENCES MEDECINS (numed);

ALTER TABLE SOINS ADD CONSTRAINT FK_SOINS_refmed FOREIGN KEY (refmed) REFERENCES MEDICAMENTS (refmed);

ALTER TABLE COMPATIBLES ADD CONSTRAINT FK_COMPATIBLES_refmed FOREIGN KEY (refmed) REFERENCES MEDICAMENTS (refmed);

ALTER TABLE REALISER ADD CONSTRAINT FK_REALISER_numpat FOREIGN KEY (numpat) REFERENCES PATIENTS (numpat);

ALTER TABLE REALISER ADD CONSTRAINT FK_REALISER_numres FOREIGN KEY (numres) REFERENCES RESULTATS (numres);

ALTER TABLE REALISER ADD CONSTRAINT FK_REALISER_numanl FOREIGN KEY (numanl) REFERENCES ANALYSES (numanl);

ALTER TABLE REALISER ADD CONSTRAINT FK_REALISER_numed FOREIGN KEY (numed) REFERENCES MEDECINS (numed);


