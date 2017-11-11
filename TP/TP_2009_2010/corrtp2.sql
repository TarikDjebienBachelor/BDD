-- SUPPRESSION DE LA BASE
drop table familles;
drop table partis;
drop table elections;
drop table electeurs;
drop table candidats;
drop table regions;
drop table departements;
drop table communes;
drop table bureaux;
drop table argumentaires;
drop table inscrit;
drop table vote;
drop table est_membre;
drop table appartenance;
drop table se_presente;
drop table elu;

drop sequence seq_fam;
drop sequence seq_part;
drop sequence seq_can;
drop sequence seq_electn;
drop sequence seq_electr;
drop sequence seq_arg;
drop sequence seq_com;
drop sequence seq_reg;
drop sequence seq_bur;
drop sequence seq_inscr;
drop sequence seq_app;
drop sequence seq_memb;
drop sequence seq_pre;

-- CREATION DE TABLES
create table familles(numfam number, intitule,
constraint pk_fam primary key(numfam))

create table partis(numpart number,sigle char(10), nom varchar2(50),
adresse varchar2(100), code_postal char(5), ville varchar2(50), 
secretaire number, telephone char(10),
constraint pk_partis primary key(numpart));

create table elections(numelectn number, nature char(20), tour number(1), 
date_elect char(10), constraint pk_elctn primary key numelectn);

create table electeurs(numelectr number, nom varchar2(50), prenom varchar2(50),
adresse varchar2(100), code_postal number(5),  ville varchar2(50),
constraint pk_electr primary key(numelectr));

create table candidats(numcand number, civilite char(5), nom varchar2(50), prenom varchar2(50),adresse varchar2(100), code_postal number(5), ville varchar2(50),
telephone char(10),constraint pk_cand primary key(numcand));


create table regions(numreg number, nomreg varchar2(50),
constraint pk_reg primary key(numreg));

create table departements(numdept char(3), nomdept varchar2(50), numreg number,
constraint pk_dept primary key(numdept));

create table communes(numcom number, nomcom varchar2(50), numdept number,
constraint pk_com primary key(numcom));

create table bureaux(numbureau number, adr_bureau varchar2(100),numcom number,
constraint pk_bur primary key(numbureau));

create table argumentaire(numero number, numcand number, 
texte varchar2(5000), date_discours char(10),
constraint pk_arg primary key(numero));

create table inscrit(numinscr number, numelectr number, numbureau number,
depuis char(10), jusqua char(10),
constraint pk_inscr primary key(numinscr));
-- numinscr=cle primaire creee a la place de (numelectr,numbureau,depuis)

create table vote(numelectr number, numelectn number,
constraint pk_vote primary key(numelect, numelectn));

create table estMembre(nummembre number, numcand number, numpart number,
depuis char(10), jusqua char(10), numcarte number,
constraint pk_estmembre primary key(nummembre));
-- cle primaire creee a la place de (numcand,numpart,depuis)

create table appartenance(numappart number, numpart number, numfam number, 
depuis char(10), jusqua char(10),
constraint pk_appart primary key(numappart));

create table se_presente(numpre number, numcand number, numelectn number, numbureau number, nbvoix number, constraint pk_pre primary key(numpre));
-- cle primaire creee a la place de (numcand,numelectn, numbureau)

create table elu(numcand number, numelectn number,nbvoix number,
constraint pk_elu primary key(numcand, numelectn));

-- SEQUENCES
create sequence seq_fam;
create sequence seq_part;
create sequence seq_can;
create sequence seq_electn;
create sequence seq_electr;
create sequence seq_arg;
create sequence seq_com;
create sequence seq_reg;
create sequence seq_bur;
create sequence seq_inscr;
create sequence seq_app;
create sequence seq_memb;
create sequence seq_pre;

-- ***************** DONNEES ***************
--CANDIDATS

insert into candidats values(seq_cand.nextval,'M', 'Torvalds', 'Linus',null,80585,'Ste Carte Mère',null);
insert into candidats values(seq_cand.nextval,'M', 'Dupont', 'Georges', null,80585,'Ste Carte Mère',null);
insert into candidats values(seq_cand.nextval,'M', 'de Poidsfort', 'Octet',null,80585,'Ste Carte Mère',null);
insert into candidats values(seq_cand.nextval,'Mme', 'Langage', 'Ada', null,80585,'Ste Carte Mère',null);
insert into candidats values(seq_cand.nextval,'M', 'Menletant', 'Gérard', null,80585,'Ste Carte Mère',null);
insert into candidats values(seq_cand.nextval,'M', 'Saplante', 'Touletant', null,80585,'Ste Carte Mère',null);
insert into candidats values(seq_cand.nextval,'M', 'Wirth', 'Pascal', null,80585,'Ste Carte Mère',null);
insert into candidats values(seq_cand.nextval,'M', 'Gates', 'Bill', null,80585,'Ste Carte Mère',null);


--PARTIS

insert into partis values(seq_part.nextval, 'UNIX',null,null,null,null,null,null);
insert into partis values(seq_part.nextval, 'BSD',null,null,null,null,null,null);
insert into partis values(seq_part.nextval, 'EPS',null,null,null,null,null,null);
insert into partis values(seq_part.nextval, 'MAC OS',null,null,null,null,null,null);
insert into partis values(seq_part.nextval, 'PC',null,null,null,null,null,null);
insert into partis values(seq_part.nextval, 'PDF',null,null,null,null,null,null);
insert into partis values(seq_part.nextval, 'LCP','Libres Citoyens Programmeurs',null,null,null,null,null);
insert into partis values(seq_part.nextval, 'XP',null,null,null,null,null,null);

--FAMILLES

insert into familles values(seq_fam.nextval,'CENTRE GAUCHE');
insert into familles values(seq_fam.nextval,'DIVERS GAUCHE');
insert into familles values(seq_fam.nextval,'GAUCHE');
insert into familles values(seq_fam.nextval,'DROITE');
insert into familles values(seq_fam.nextval,'DIVERS DROITE');
insert into familles values(seq_fam.nextval,'DIVERS CENTRE');
insert into familles values(seq_fam.nextval,'DROITE EXTREME');

--APPARTENANCE

insert into appartenance values(seq_app.nextval, 1,1,null, null);
insert into appartenance values(seq_app.nextval, 2,2,null, null);
insert into appartenance values(seq_app.nextval, 3,3,null, null);
insert into appartenance values(seq_app.nextval, 4,4,null, null);
insert into appartenance values(seq_app.nextval, 5,2,null, null);
insert into appartenance values(seq_app.nextval, 6,5,null, null);
insert into appartenance values(seq_app.nextval, 7,6,null, null);
insert into appartenance values(seq_app.nextval, 8,7,null, null);

--REGIONS
insert into regions values(seq_reg.nextval,'NORD-PICARDIE');

--DEPARTEMENTS
insert into departements values('80','PICARDIE',null);
update departements set numreg=(select numreg from regions where nomreg like '%PICARDIE%');

--COMMUNES
insert into communes values(seq_com.nextval, 'SAINTE CARTE-MERE','80');

-- BUREAUX

insert into bureaux values(seq_bur.nextval, 'école Gambetta');	 
insert into bureaux values(seq_bur.nextval,'Colège César Franck');  	 
insert into bureaux values(seq_bur.nextval,'école du C'  );	 
insert into bureaux values(seq_bur.nextval,'Lycée Cobol'  );	 
insert into bureaux values(seq_bur.nextval,'école maternelle du Fortran');

--ARGUMENTAIRE
insert into argumentaires values(seq_arg.nextval,null,'Programmeurs, programmeuses, le grand ordinateur vous ment, le grand ordinateur vous exploite. Tous ensemble, luttons pour imposer la loi du peuple programmeur et faire tomber la tyranie des compilateurs au service du grand ordinateur!');


insert into argumentaires values(seq_arg.nextval,null,'Chers amis informaticiens,vous en avez assez des bugs et des virus, moi aussi. Solidaire avec vous, avec vos problèmes, je vous demande de voter pour moi afin de me permettre de déposer la loi qui pourra rendre ces infames compilateurs enfin tolérants vis à vis de nos façons de programmer!');


insert into argumentaires values(seq_arg.nextval,null, 'Chers programmeurs, ensemble, nous nous sommes affranchis des cartes et des rubans perforés, des machines à lampes, lentes et peu fiables, et des processeurs 8 bits à 1 MHz. Mais il faut accomplir encore un effort pour que notre labeur nous soit payé de retour, pour atteindre enfin la productivité à laquelle nous rêvons et qui nous permettra de jouir tranquillement du fruit de nos applications. Avec moi, en votant pour moi, vous allez permettre enfin l''émergence de processeurs 64bits à 5GHz que nous attendons tous.');

update argumentaire set numcand=(select numcand from candidats where nom ='SAPLANTE');
update argumentaire set numcand=(select numcand from candidats where nom ='POIDSFORT');
update argumentaire set numcand=(select numcand from candidats where nom ='LANGAGE');

--ELECTIONS
insert into elections values(seq_electn.nextval,'communales',1,'18/10/2009');
insert into elections values(seq_electn.nextval,'legislatives',1,'13/09/2009');

--ELU

insert into elu values(1,1,2495);
insert into elu values(2,1,1150);
insert into elu values(3,1,1120);
insert into elu values(4,1,1140);
insert into elu values(7,1,2004);
insert into elu values(1,2, 115367);

-- SE_PRESENTE


insert into se_presente values(seq_pre.nextval,1,1,1,501);
insert into se_presente values(seq_pre.nextval,1,1,2,495);
insert into se_presente values(seq_pre.nextval,1 ,1,3, 530);
insert into se_presente values(seq_pre.nextval,1 ,1,4, 682);
insert into se_presente values(seq_pre.nextval,1 ,1,5, 287);
insert into se_presente values(seq_pre.nextval,2,1,1, 200);
insert into se_presente values(seq_pre.nextval,2,1,2, 195);
insert into se_presente values(seq_pre.nextval,2,1,3, 200);
insert into se_presente values(seq_pre.nextval,2,1,4, 150);
insert into se_presente values(seq_pre.nextval,2,1,5, 405);
insert into se_presente values(seq_pre.nextval,3,1,1, 150,);
insert into se_presente values(seq_pre.nextval,3,1,2, 210);
insert into se_presente values(seq_pre.nextval,3,1,3, 195);
insert into se_presente values(seq_pre.nextval,3,1,4, 180);
insert into se_presente values(seq_pre.nextval,3,1,5, 385);
insert into se_presente values(seq_pre.nextval,4,1,1, 217);
insert into se_presente values(seq_pre.nextval,4,1,2, 212);
insert into se_presente values(seq_pre.nextval,4,1,3, 198);
insert into se_presente values(seq_pre.nextval,4,1,4, 232);
insert into se_presente values(seq_pre.nextval,4,1,5, 281);
insert into se_presente values(seq_pre.nextval,5,1,1, 128);
insert into se_presente values(seq_pre.nextval,5,1,2, 182);
insert into se_presente values(seq_pre.nextval,5,1,3, 118);
insert into se_presente values(seq_pre.nextval,5,1,4, 155);
insert into se_presente values(seq_pre.nextval,5,1,5, 217);
insert into se_presente values(seq_pre.nextval,6,1,1, 131);
insert into se_presente values(seq_pre.nextval,6,1,2, 143);
insert into se_presente values(seq_pre.nextval,6,1,3, 117);
insert into se_presente values(seq_pre.nextval,6,1,4, 142);
insert into se_presente values(seq_pre.nextval,6,1,5, 277);
insert into se_presente values(seq_pre.nextval,7,1,1, 433);
insert into se_presente values(seq_pre.nextval,7,1,2, 518);
insert into se_presente values(seq_pre.nextval,7,1,3, 446);
insert into se_presente values(seq_pre.nextval,7,1,4, 385);
insert into se_presente values(seq_pre.nextval,7,1,5, 222);
insert into se_presente values(seq_pre.nextval,8,1,1, 14);
insert into se_presente values(seq_pre.nextval,8,1,2, 18);
insert into se_presente values(seq_pre.nextval,8,1,3, 22);
insert into se_presente values(seq_pre.nextval,8,1,4, 21);
insert into se_presente values(seq_pre.nextval,8,1,5, 35);

--EST_MEMBRE
insert into estMembre values(seq_memb.nextval,1,1, null,null,null);
insert into estMembre values(seq_memb.nextval,2,2, null,null,null);
insert into estMembre values(seq_memb.nextval,3,3, null,null,null);
insert into estMembre values(seq_memb.nextval,4,4, null,null,null);
insert into estMembre values(seq_memb.nextval,5,5, null,null,null);
insert into estMembre values(seq_memb.nextval,6,6, null,null,null);
insert into estMembre values(seq_memb.nextval,7,7, null,null,null);
insert into estMembre values(seq_memb.nextval,8,8, null,null,null);

--ELECTEURS
insert into electeurs values(seq_electr.nextval,'Toto','Bob',null,59000,'LILLE');

--VOTE
insert into vote values(1,1);


--Correction du schéma

create table cantons(numcanton number, intitule varchar2(30), numdept number, 
constraint pk_canton  primary key(numcanto,));

insert into cantons values(1,'Dur-Ledisque','80');

alter table communes add numcanton number;
update communes set numcanton=1 where nom like '%CARTE%';