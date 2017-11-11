/*
*  Author : Djebien Tarik;
*/

/* scriptSQL de creation des tables patients, services et sejours de HOPITAL */


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

/* TABLE SERVICES */


DROP TABLE IF EXISTS SERVICES ;

CREATE TABLE SERVICES (
numserv NUMBER  NOT NULL,
nomserv VARCHAR2(30),
chef NUMBER NOT NULL,
tarif FLOAT,
constraint "SERVICES_PK" PRIMARY KEY (numserv)
);


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

/* VUE Vsoins */

CREATE VIEW Vsoins AS 
Select numsoin, numpat, numed , refmed, to_date(date_soin,'DD/MM/YYYY') as date 
from soins;


