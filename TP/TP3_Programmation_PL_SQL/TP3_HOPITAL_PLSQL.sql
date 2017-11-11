/* script créé le : Sat Nov 20 21:23:13 CET 2010 ;
*  Author : Djebien Tarik;
*/

/* scriptSQL de creation des fonctions et procedures de HOPITAL */

/* Q1 */
CREATE OR replace function duree_sejour(patient NUMBER,de CHAR) return NUMBER is
  nbjours NUMBER;
begin
  select to_date(sortie,'DD/MM/YYYY') - to_date(entree,'DD/MM/YYYY') into nbjours from SEJOURS
  where numpat = patient and entree = de;
  return nbjours;
end;

/* Q2 */
CREATE OR replace function cout_sejour(patient NUMBER,de CHAR) return NUMBER is

  coutTotal             NUMBER;
  coutHopital           NUMBER;
  coutMedecin           NUMBER;
  coutSoins             NUMBER;
  coutDesMedicaments    NUMBER;
  coutDesAnalyses       NUMBER;
  prixJournee           NUMBER;
  nbJours               NUMBER;
  prixVisite            NUMBER;
  nbVisites             NUMBER;
  dateSortie            CHAR(10);

begin
  select prix_journee,prix_visite
  into prixJournee,prixVisite
  from TARIFS;

  select sortie
  into dateSortie
  from SEJOURS
  where numpat = patient and entree = de;

  select to_date(sortie,'DD/MM/YYYY') - to_date(entree,'DD/MM/YYYY')
  into nbJours
  from SEJOURS
  where numpat = patient and entree = de;

  select count(*)
  into nbVisites
  from VISITES
  where numpat = patient
  and to_date(VISITES.jour,'DD/MM/YYYY')
  BETWEEN to_date(de,'DD/MM/YYYY') and to_date(dateSortie,'DD/MM/YYYY');

  select sum(MEDICAMENTS.prix)
  into coutDesMedicaments
  from SOINS,MEDICAMENTS
  where SOINS.numpat = patient and SOINS.refmed = MEDICAMENTS.refmed
  and to_date(SOINS.date_soin,'DD/MM/YYYY')
  BETWEEN to_date(de,'DD/MM/YYYY') and to_date(dateSortie,'DD/MM/YYYY');

  select sum(ANALYSES.prix_anl)
  into coutDesAnalyses
  from REALISER,ANALYSES
  where REALISER.numpat = patient and REALISER.numanl = ANALYSES.numanl
  and to_date(REALISER.date_analyse,'DD/MM/YYYY')
  BETWEEN to_date(de,'DD/MM/YYYY') and to_date(dateSortie,'DD/MM/YYYY');

  coutHopital := nbJours*prixJournee;
  coutMedecin := nbVisites*prixVisite;
  coutSoins := coutDesMedicaments + coutDesAnalyses;
  coutTotal := coutHopital + coutMedecin + coutSoins;
  return coutTotal;
end;

/* Q3 */
CREATE OR replace function cout_moyen_journee return NUMBER is

CURSOR Cur IS SELECT * FROM SEJOURS;
sejour SEJOURS%ROWTYPE;
nbsejour NUMBER;
res NUMBER;

BEGIN
res:=0;
select count(*) into nbsejour from SEJOURS;
FOR sejour IN Cur LOOP
res:= res + cout_sejour(sejour.numpat,sejour.entree);
END LOOP;
return res/nbsejour;
END;

/* Q4 */
CREATE OR replace function cout_total_patient(patient NUMBER) return NUMBER is

CURSOR Cur IS SELECT * FROM SEJOURS;
sejour SEJOURS%ROWTYPE;
res NUMBER;

BEGIN
res:=0;

FOR sejour IN Cur LOOP
IF (sejour.numpat = patient)THEN
res:= res + cout_sejour(sejour.numpat,sejour.entree);
END IF;
END LOOP;

return res;
END;

/* Q5 */
CREATE OR replace procedure historique_medicaments(patient NUMBER) is

CURSOR CurSoin IS SELECT * FROM SOINS WHERE SOINS.numpat= patient ORDER BY SOINS.date_soin;
CURSOR CurMed  IS SELECT * FROM MEDICAMENTS;
soin   SOINS%ROWTYPE;
medoc  MEDICAMENTS%ROWTYPE;
nom    PATIENTS.nom%TYPE;
med    SOINS.refmed%TYPE;

BEGIN
select PATIENTS.nom into nom from PATIENTS where PATIENTS.numpat=patient;
DBMS_OUTPUT.PUT_LINE('Liste des medicaments pour : ' || nom );

FOR soin IN CurSoin LOOP
  med:= soin.refmed;
  for medoc in CurMed loop
    if (medoc.refmed = med) then
    DBMS_OUTPUT.PUT_LINE(medoc.designation );
    end if;
  end loop;
END LOOP;
END;

/* Q6 */
CREATE OR replace procedure historique_soins(patient NUMBER) is

CURSOR CurSejour IS SELECT * FROM SEJOURS WHERE SEJOURS.numpat= patient;
CURSOR CurSoin   IS SELECT * FROM SOINS WHERE SOINS.numpat= patient;
CURSOR CurDoc    IS SELECT * FROM MEDECINS ;
CURSOR CurMed    IS SELECT * FROM MEDICAMENTS;


sejour SEJOURS%ROWTYPE;
soin   SOINS%ROWTYPE;
doc    MEDECINS%ROWTYPE;
medoc  MEDICAMENTS%ROWTYPE;

nom    PATIENTS.nom%TYPE;
nomDoc MEDECINS.nom_med%TYPE;
debut  SEJOURS.entree%TYPE;
fin    SEJOURS.sortie%TYPE;
docNum MEDECINS.numed%TYPE;
medNum MEDICAMENTS.refmed%TYPE;


BEGIN
select PATIENTS.nom into nom from PATIENTS where PATIENTS.numpat=patient;
DBMS_OUTPUT.PUT_LINE('Nom patient :' || nom );

FOR sejour IN CurSejour LOOP
  debut:= sejour.entree;
  fin  := sejour.sortie;
  DBMS_OUTPUT.PUT_LINE(' entrée le ' || debut || ' sortie le '|| fin);
  FOR soin IN CurSoin LOOP
    if(to_date(soin.date_soin,'DD/MM/YYYY') BETWEEN to_date(debut,'DD/MM/YYYY') AND to_date(fin,'DD/MM/YYYY')) then
      docNum:= soin.numed;
      medNum:= soin.refmed;
      select MEDECINS.nom_med into nomDoc from MEDECINS where MEDECINS.numed=docNum;
      DBMS_OUTPUT.PUT_LINE(' medecin : ' || nomDoc );
      FOR doc IN CurDoc LOOP
        FOR medoc in CurMed LOOP
          if(doc.numed=docNum AND medoc.refmed=medNum) then
          DBMS_OUTPUT.PUT_LINE(nomDoc || ' a prescrit : '||medoc.designation);
          end if;
        END LOOP;
      END LOOP;
    end if;
  END LOOP;
END LOOP;

END;

/* Q7 */
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
DBMS_OUTPUT.PUT_LINE( nom || ' a été soigné par : ' );

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
