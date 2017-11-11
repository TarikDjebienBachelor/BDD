drop table notes;
drop table etud;
drop table matieres;

create table notes (numet number, note number, codmat varchar(4), coeff number);

insert into notes values (1234567890,10,'BDD',2);
insert into notes values (1234567890,13,'COO',2);
insert into notes values (1234567890,20,'ANG1',1);

insert into notes values (2345678901,6,'BDD',2);
insert into notes values (2345678901,4,'COO',2);
insert into notes values (2345678901,15,'ANG1',3);

insert into notes values (3456789012,6,'BDD',1);
insert into notes values (3456789012,10,'COO',2);

insert into notes values (4567890123,10,'BD',2);
insert into notes values (4567890123,10,'COO',2);

insert into notes values (6542314532,10,'COO',2);



create table etud(numet number, nom varchar(50), prenom varchar(50));

insert into etud values(1234567890,'Brown','James');
insert into etud values(2345678901,'Cooper','Alice');
insert into etud values(3456789012,'Lennon','John');
insert into etud values(4567890123,'Hendrix','Jimmy');

create table matieres(codmat varchar(4), nomprof varchar(20));

insert into matieres values ('BDD','Boyd-Codd');
insert into matieres values ('COO','Boyd-Codd');
insert into matieres values ('ENG1','Joplin');
insert into matieres values ('ANG2','Joplin');
insert into matieres values ('COM1','Santana');
insert into matieres values ('COM2','Santana');
