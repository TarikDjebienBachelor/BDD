DROP TABLE pays ;
DROP TABLE villes ;
DROP TABLE personnes ;
DROP TABLE musees ;
DROP TABLE hotels ;
DROP TABLE catchambres ;
DROP TABLE monuments ;
DROP TABLE tours ;
DROP TABLE transports ;
DROP TABLE utiliser ;
DROP TABLE acheter ;




CREATE TABLE pays (
numpays  NUMBER,
nom      VARCHAR(20),
capitale VARCHAR(20),
CONSTRAINT PK_numpays PRIMARY KEY (numpays) 
);

CREATE TABLE villes (
numville NUMBER,
nom      VARCHAR(20),
numpays  NUMBER,
CONSTRAINT PK_numville PRIMARY KEY (numville),
CONSTRAINT FK_villes_numpays  FOREIGN KEY (numpays) REFERENCES pays(numpays)
);

CREATE TABLE personnes (
numper   NUMBER,
nom      VARCHAR(30),
prenom   VARCHAR(20),
adresse  VARCHAR(30),
ville    VARCHAR(30),
numpays  NUMBER,
CONSTRAINT PK_numper PRIMARY KEY (numper),
CONSTRAINT FK_personnes_numpays  FOREIGN KEY (numpays) REFERENCES pays(numpays)
);

CREATE TABLE musees(
nummus      NUMBER,
nom         VARCHAR(30),
numville    NUMBER,
adresse     VARCHAR(30),
description VARCHAR(50),
directeur   NUMBER,
CONSTRAINT PK_nummus PRIMARY KEY (nummus),
CONSTRAINT FK_musees_numville  FOREIGN KEY (numville)  REFERENCES villes(numville),
CONSTRAINT FK_musees_directeur FOREIGN KEY (directeur) REFERENCES personnes(numper)
);

CREATE TABLE hotels (
numhotel    NUMBER,
nom         VARCHAR(30),
nbetoiles   NUMBER,
adresse     VARCHAR(50),
description VARCHAR(300),
num_ville   NUMBER,
directeur   NUMBER,
CONSTRAINT PK_numhotel PRIMARY KEY (numhotel),
CONSTRAINT FK_hotels_num_ville  FOREIGN KEY (num_ville) REFERENCES villes(numville),
CONSTRAINT FK_hotels_directeur  FOREIGN KEY (directeur) REFERENCES personnes(numper)
);

CREATE TABLE catchambres (
numcat           NUMBER,
nombredechambres NUMBER,
prixppers        NUMBER,
caracteristiques VARCHAR(300),
numhotel         NUMBER,
CONSTRAINT PK_numcat PRIMARY KEY (numcat),
CONSTRAINT FK_catchambres_numhotel  FOREIGN KEY (numhotel) REFERENCES hotels(numhotel)
);

CREATE TABLE monuments (
nummon      NUMBER,
nom         VARCHAR(30),
adresse     VARCHAR(30),
numville    NUMBER,
description VARCHAR(300),
directeur   NUMBER,
CONSTRAINT PK_nummon PRIMARY KEY (nummon),
CONSTRAINT FK_monuments_numville  FOREIGN KEY (numville)  REFERENCES villes(numville),
CONSTRAINT FK_monuments_directeur FOREIGN KEY (directeur) REFERENCES personnes(numper)
);

CREATE TABLE tours (
numtour     NUMBER,
description VARCHAR(100),
duree       NUMBER,
numpays     NUMBER,
prix        NUMBER(8,2),
CONSTRAINT PK_numtour  PRIMARY KEY (numtour),
CONSTRAINT FK_tours_numpays  FOREIGN KEY (numpays) REFERENCES pays(numpays)
);

CREATE TABLE transports (
numtrsp     NUMBER,
compagnie   VARCHAR(30),
medium      VARCHAR(20),
depart      NUMBER,
arrivee     NUMBER,
hdepart     CHAR(5),
harrivee    CHAR(5),
cout        NUMBER(8,2),
CONSTRAINT PK_numtrsp  PRIMARY KEY (numtrsp),
CONSTRAINT FK_transports_depart   FOREIGN KEY (depart)  REFERENCES villes(numville),
CONSTRAINT FK_transports_arrivee  FOREIGN KEY (arrivee) REFERENCES villes(numville)
);

CREATE TABLE utiliser (
numutour NUMBER,
numtrsp  NUMBER,
CONSTRAINT FK_utiliser_numutour FOREIGN KEY (numutour)  REFERENCES tours(numtour),
CONSTRAINT FK_utiliser_numtrsp  FOREIGN KEY (numtrsp)   REFERENCES transports(numtrsp)
);

CREATE TABLE acheter (
numachat     NUMBER,
numper       NUMBER,
numtour      NUMBER,
date_achat   CHAR(10),
CONSTRAINT PK_numachat PRIMARY KEY (numachat),
CONSTRAINT FK_acheter_numper   FOREIGN KEY (numper)  REFERENCES personnes(numper),
CONSTRAINT FK_acheter_numtour  FOREIGN KEY (numtour) REFERENCES tours(numtour)
);
