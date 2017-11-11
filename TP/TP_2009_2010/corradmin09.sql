--1 RECREER LA BASE
create table adherents   as select * from mediatheque.adherents;
create table auteurs     as select * from mediatheque.auteurs;
create table oeuvres     as select * from mediatheque.oeuvres;
create table ouvrages    as select * from mediatheque.ouvrages ;
create table editeurs    as select * from mediatheque.editeurs;
create table exemplaires as select * from mediatheque.exemplaires ;
create table ecrit       as select * from mediatheque.ecrit;

create view obj(nom, type) as secelt(substr(object_name,1,30), object_type from user_objects;

alter table adherents add constraint PK_adhe primary key(numadhe);
alter table auteurs  add constraint PK_auteurs primary key(numaut);
alter table oeuvres  add constraint PK_oeuvres primary key(numo);
alter table ouvrages  add constraint PK_ouvrages primary key(numouv);
alter table editeurs  add constraint PK_edit primary key(numedit);
alter table exemplaires   add constraint PK_exemp primary key(numouv,numex);
alter table ecrit add constraint PK_ecrit primary key(numaut,numo)
alter table ecrit add constraint FK_ecaut foreign key(numaut) references auteurs.numaut on delete set null;
alter table ecrit add constraint FK_ecoeuv foreign key(numo) references oeuvres.numo on delete set null;

--2 VUES ET AUTORISATIONS

create view gestion as select unique ex.numouv, ex.numex,o.titre,ex.etat,o.prix, o.support from ouvrages o, exemplaires ex , emprunts e where o.numouv=ex.numouv and ex.numouv=e.numouv and ex.numex=e.numex order by numouv, numex;


create view audio as select ex.numouv, ex.numex, o.titre,ex.etat,o.prix, o.support from   ouvrages o, exemplaires ex , emprunts e where o.numouv=ex.numouv and ex.numouv=e.numouv and ex.numex=e.numex and  o.support='CD';

create view tout as select  * from gestion union (select * from audio);

select unique nom, prenom from tout t, adherents a, exmprunts e where a.numadhe=e.numadhe and e.numouv=t.numouv and o.support='CD';

select text from user_views where view_name='TOUT';

grant select on tout to U;
commit;

revoke select on tout from U;
commit;
create role monRole;
grant select on tout to monRole;
grant monRole to U;
commit;


--3 MODIFIER LA STRUCTURE D'UNE TABLE

create table critiques(numcrit number, auteur varchar2(50), revue varchar2(50),dateparution varchar2(30), texte varchar2(1000));

desc critiques

alter table critiques add titre varchar2(10);
alter table critiques modify titre varchar2(300);

insert into critiques values(1,'PASCAL','LIRE','octobre 2009',??absolument boulversifiant !??,'Les Pensées');

insert into critiques values(2 ,  'Descartes', 'Lecture pour tous', 'septembre 2009', 'Le style est assez bon, mais on recherche en vain la recette de la pâte à crêpe. Dans un genre asez proche, nous gardons notre préférence pour le dernier roman de Beigbeder','Méditations Métaphysiques');

alter table critiques add numo number;
update critiques set numo=(select numo from oeuvres where titre=critiques.titre); 

select rowid, numo, titre from critiques;
delete from critiques where rowid=...

alter table critiques add constraint PK_crit primary key(numcrit);




--4) LE PROCESSEUR DE CONTRAINTES

--4.1) 
create table essai(cle number, valeur varchar2(50), constraint pk_es primary key(cle));

create table liaison(key number, lien number, constraint pk_l primary key(key),
                          constraint fk_le foreign key(lien) references essai(cle) );


--4.2) 
insert into essai values(null, 'abc')
                         *

ERREUR à la ligne 1 :
ORA-01400: impossible d'insérer NULL dans ("INFOTOUR"."ESSAI"."CLE") 
La contrainte de clé primaire interdit l'insertion

--4.3) 
insert into essai values(1, 'abc');
1 ligne créée.

insert into essai values(1, 'abc')
*

ERREUR à la ligne 1 :
ORA-00001: violation de contrainte unique (INFOTOUR.PK_ES)
Le processeur de contrainte interdit l'insertion d'un doublon


--4.4) 
insert into liaison values(1,2)
*

ERREUR à la ligne 1 :
ORA-02291: violation de contrainte d'intégrité (INFOTOUR.FK_LE) - clé parent introuvable 
tentative de rattacher l'enregistrement à un enregistrement (le n° 2) absent de la table essai

 insert into liaison values(1,1)
1 ligne créée.

--4.5)
update essai set cle=2 where cle=1;

update essai set cle=2 where cle=1
*

ERREUR à la ligne 1 :
ORA-02292: violation de contrainte (INFOTOUR.FK_LE) d'intégrité - enregistrement fils existant
Mise à jour impossible sans une clause on update cascade dans la déclaration de la clé étrangère


4.6)delete from essai where cle=1;
delete from essai
*

ERREUR à la ligne 1 :
ORA-02292: violation de contrainte (INFOTOUR.FK_LE) d'intégrité - enregistrement fils existant 
Le message est explicite


--4.7) 
alter table liaison drop constraint FK_LE;
Table modifiée.


alter table liaison add  constraint fk_le foreign key(lien) references essai(cle) on delete  cascade;
Table modifiée.



--4.8) 
alter table liaison drop constraint FK_LE;
Table modifiée.
alter table liaison add  constraint fk_le foreign key(lien) references essai(cle) on delete  set null;
Table modifiée.

delete from essai where cle=1;
1 ligne supprimée. 
La clause on delete sur FK_LE rend la suppression possible

select * from liaison;
aucune ligne sélectionnée 

Le suppression a été automatiquement  menée sur l'enregistrement correspondant de liaison




--6) Fonctionnement de l'optimiseur

--6.1) 
analyze table adherents compute statistics;
Table analysée.

select * from user_tables where table_name='ADHERENTS'

(résultat trop gros pour être affiché ici)



--6.2) 
set autotrace on explain.
Commande exécutée

select * from adherents where ville='LILLE';

--Plan d'exécution

----------------------------------------------------------

Plan hash value: 30385603

-------------------------------------------------------------------------------
| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |     3 |   150 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| ADHERENTS |     3 |   150 |     3   (0)| 00:00:01 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   1 - filter("VILLE"='LILLE')

-- Adherents ayant emprunté

select * from adherents a, emprunts e where a.numadhe=e.numadhe and ville='LILLE';

--Plan d'exécution
----------------------------------------------------------

Plan hash value: 1670545201

------------------------------------------------------------------------------------------
| Id  | Operation                    | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |           |     3 |   225 |     4   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                |           |     3 |   225 |     4   (0)| 00:00:01 |
|   2 |   TABLE ACCESS FULL          | EMPRUNTS  |    13 |   325 |     3   (0)| 00:00:01 |
|*  3 |   TABLE ACCESS BY INDEX ROWID| ADHERENTS |     1 |    50 |     1   (0)| 00:00:01 |
|*  4 |    INDEX UNIQUE SCAN         | PK_ADHE   |     1 |       |     0   (0)| 00:00:01 |
------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   3 - filter("VILLE"='LILLE')
   4 - access("A"."NUMADHE"="E"."NUMADHE")

