/*
*  Author : Djebien Tarik;
*/

/* Exercice 3 PL SQL */

/* paquetage pour DBMS_OUTPUT */
set serveroutput on;

/* procedure qui_a_soigne(patient number) */

CREATE OR replace procedure qui_a_soigne(patient NUMBER) is
CURSOR CurSejour IS SELECT * FROM SEJOURS WHERE SEJOURS.numpat= patient;
CURSOR CurSoin   IS SELECT * FROM SOINS WHERE SOINS.numpat= patient;
sejour SEJOURS%ROWTYPE;
soin   SOINS%ROWTYPE;
nom     PATIENTS.nom%TYPE;
nomDoc  MEDECINS.nom_med%TYPE;
debut   SEJOURS.entree%TYPE;
fin     SEJOURS.sortie%TYPE;
docNum  MEDECINS.numed%TYPE;
soinDat SOINS.date_soin%TYPE;
BEGIN
select PATIENTS.nom into nom from PATIENTS where PATIENTS.numpat=patient;
BMS_OUTPUT.PUT_LINE( nom || ' a été soigné par : ' );

FOR sejour IN CurSejour LOOP
  debut:= sejour.entree;
  fin  := sejour.sortie;
  DBMS_OUTPUT.PUT_LINE(' Sejour du ' || debut || ' au '|| fin);
  FOR soin IN CurSoin LOOP
    if(to_date(soin.date_soin,'DD/MM/YYYY') BETWEEN to_date(debut,'DD/MM/YYYY') AND to_date(fin,'DD/MM/YYYY')) then
      docNum:= soin.numed;
      soinDat:= soin.date_soin;
      select MEDECINS.nom_med into nomDoc from MEDECINS where MEDECINS.numed=docNum;
      DBMS_OUTPUT.PUT_LINE(nomDoc || ', le '||soinDat);
    end if;
  END LOOP;
END LOOP;
END;

/* test de la procedure avec un bloc anonyme par exemple */
begin
qui_a_soigne(1)
end;
