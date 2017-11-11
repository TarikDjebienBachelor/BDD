-- TP triggers en PL/SQL NUMERO 4

----------------------------------------------
-- Trigger qui assure la cohérence des soins au niveau des dates

CREATE OR REPLACE TRIGGER  "COHERENCE_SOIN"
  before insert on SOINS
  for each row
declare
  CURSOR CurSejour IS SELECT * FROM SEJOURS WHERE SEJOURS.numpat = :NEW.numpat;
  sejour SEJOURS%ROWTYPE;
  ok     boolean;
  nompat PATIENTS.nom%TYPE;
  Entree SEJOURS.entree%TYPE;
  Sortie SEJOURS.sortie%TYPE;
begin
  ok := true;
  Select PATIENTS.nom into nompat from PATIENTS where PATIENTS.numpat= :NEW.numpat;

  FOR sejour IN CurSejour LOOP
  Entree := sejour.entree;
  Sortie := sejour.sortie;
  if NOT(to_date(:NEW.date_soin,'DD/MM/YYYY') BETWEEN to_date(Entree,'DD/MM/YYYY') AND to_date(Sortie,'DD/MM/YYYY')) then
     ok := false;
  end if;
  END LOOP;
  if (ok = true) then
	DBMS_OUTPUT.PUT_LINE('Le soin de '||nompat||' daté du '||:NEW.date_soin||' a bien été enregistré.');
  else
	DBMS_OUTPUT.PUT_LINE('Le soin de '||nompat||' daté du '||:NEW.date_soin||' n''a pas été enregistré, la date de soin est erronée');
    raise_application_error(-20000,"insertion refusée");
  end if;
end;

ALTER TRIGGER  "COHERENCE_SOIN" ENABLE;

----------------------------------------------
-- Trigger qui assure la cohérence des analyses au niveau des dates

CREATE OR REPLACE TRIGGER  "COHERENCE_ANALYSES"
  before insert on REALISER
  for each row
declare
  CURSOR CurSejour IS SELECT * FROM SEJOURS WHERE SEJOURS.numpat = :NEW.numpat;
  sejour SEJOURS%ROWTYPE;
  ok     boolean;
  nompat PATIENTS.nom%TYPE;
  Entree SEJOURS.entree%TYPE;
  Sortie SEJOURS.sortie%TYPE;
begin
  ok := true;
  Select PATIENTS.nom into nompat from PATIENTS where PATIENTS.numpat= :NEW.numpat;

  FOR sejour IN CurSejour LOOP
  Entree := sejour.entree;
  Sortie := sejour.sortie;
  if NOT(to_date(:NEW.date_analyse,'DD/MM/YYYY') BETWEEN to_date(Entree,'DD/MM/YYYY') AND to_date(Sortie,'DD/MM/YYYY')) then
     ok := false;
  end if;
  END LOOP;
  if (ok = true) then
	DBMS_OUTPUT.PUT_LINE('L''analyse de '||nompat||' daté du '||:NEW.date_analyse||' a bien été enregistré.');
  else
	DBMS_OUTPUT.PUT_LINE('L''analyse de '||nompat||' daté du '||:NEW.date_analyse||' n''a pas été enregistré, la date d''analyse est erronée');
    raise_application_error(-20000,"insertion refusée");
  end if;
end;

ALTER TRIGGER  "COHERENCE_ANALYSES" ENABLE;


----------------------------------------------
-- Trigger qui assure la cohérence des services des medecins au niveau des soins

CREATE OR REPLACE TRIGGER  "COHERENCE_SERVICES"
  before insert on SOINS
  for each row
declare
  ok     boolean;
  nompat PATIENTS.nom%TYPE;
  nommed MEDECINS.nom_med%TYPE;
  numServiceDuMedecin SERVICES.numserv%TYPE;
  numServiceDuPatient SEJOURS.numserv%TYPE;
begin
  Select PATIENTS.nom into nompat from PATIENTS where PATIENTS.numpat= :NEW.numpat;
  Select MEDECINS.nom_med into nommed from MEDECINS where MEDECINS.numed= :NEW.numed;
  Select MEDECINS.NUMSERVDETRAVAILLE into numServiceDuMedecin from MEDECINS where MEDECINS.numed = :NEW.numed;
  Select SEJOURS.NUMSERV into numServiceDuPatient from SEJOURS where SEJOURS.numpat = :NEW.numpat;
  if (numServiceDuMedecin = numServiceDuPatient) then
   ok := true;
  else
   ok := false;
  end if;
  if (ok = true) then
	DBMS_OUTPUT.PUT_LINE('Le soin de '||nompat||' qui a sejourné dans le service '||numServiceDuPatient||' a bien été enregistré.');
  else
	DBMS_OUTPUT.PUT_LINE('Le soin de '||nompat||' qui a sejourné dans le service '||numServiceDuPatient||' n''a pas été enregistré, le medecin '||nommed||' n''appartient pas à ce service');
    raise_application_error(-20000,"insertion refusée");
  end if;
end;

ALTER TRIGGER  "COHERENCE_SERVICES" ENABLE;

----------------------------------------------
-- Trigger qui assure la compatibilités des medicaments prescrits pour le patient au niveau des soins
/*
CREATE OR REPLACE TRIGGER  "COMPATIBILITE_MEDICAMENTS"
  before insert on SOINS
  for each row
declare
  CURSOR CurCompatible IS SELECT * FROM COMPATIBLES WHERE COMPATIBLES.refmed = :NEW.refmed;
  medoc  COMPATIBLES%ROWTYPE;
  CURSOR CurSoin IS SELECT * FROM SOINS WHERE SOINS.numpat = :NEW.numpat;
  soin   SOINS%ROWTYPE;

  ok     boolean;
  addMedicament SOINS.refmed%TYPE;
  medCourant SOINS.refmed%TYPE;

begin
  Select SOINS.refmed into addMedicaments from SOINS where SOINS.refmed = :NEW.refmed;
  FOR soin IN CurSoin LOOP
    medCourant := soin.refmed;
    FOR medoc IN CurCompatible LOOP

    END LOOP;
  END LOOP;
end;

ALTER TRIGGER  "COMPATIBILITE_MEDICAMENTS" ENABLE;
*/
