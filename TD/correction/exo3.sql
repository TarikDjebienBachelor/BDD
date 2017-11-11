---5-1 ETUDIANTS
---------------------------------
-----Exo 3.1  -- cours avec >= 15 participants
SELECT	E.cours 
FROM	Participer E 
GROUP BY E.cours 
HAVING	COUNT (*) >= 15


-----Exo 3.2  -- age moyen par niveau
SELECT E.niveau, AVG(E.age) 
FROM Etudiants E
GROUP BY E.niveau

-----Exo 3.3  --- age moyen par niveau, sauf pour Lic 1
SELECT E.niveau, AVG(S.age) 
FROM Etudiants E 
WHERE E.niveau <> "Licence 1"
GROUP BY E.niveau

-----Exo 3.4  --- cours en R128 ou avec >= 15 etudiants
SELECT C.titre 
FROM Cours C 
WHERE C.salle = "R128" 
OR C.cours IN 
   (SELECT	E.cours 
   FROM	Participer E 
   GROUP BY E.cours 
   HAVING	COUNT (*) >= 15)



--------Exo 3.5 (pour profs uniquement en R128, nom + nombre de ses cours ) -----------------------------

---- avec sous-requete correlative et NOT EXISTS

select c.prof_id, count(*) as nbcours
from cours c
where

not exists (select * from cours c2
    	   	     where c2.prof_id= c.prof_id
		     and c2.salle <> 'R128')

group by c.prof_id

---- avec having every

SELECT F.prof_nom, COUNT(*) AS Nbcours 
FROM  Profs P, Cours  C 
WHERE P.prof_id = C.prof_id 
GROUP BY P.prof_id, P.prof_nom
HAVING EVERY ( C.salle = "R128" )

----Exo 3.6 ----------Q 10--------------------------------
SELECT 
DISTINCT E.e_nom 
FROM Etudiants E 
WHERE E.e_id IN 
      (SELECT	P.etudiant   --- id de l'etudiant ayant suivi le plus de cours
      FROM	Participer P 
      GROUP BY P.etudiant
      HAVING COUNT (*) >= ALL 
            (SELECT	COUNT (*) FROM	Participer P2 GROUP BY P2.etudiant ) --- nombre de cours par etudiant
)

----------Exo 3.7----------------------------------------

SELECT DISTINCT E.e_nom 
FROM	Etudiant E 
WHERE E.et_id NOT IN (SELECT P.e_id from participer P)

------- solution alternative 

select e.e_id from etudiants e

minus

(select e_id from participer)


-------- Exo 3.8 -------------------------------------------------

SELECT	E.age, E.niveau
FROM	etudiant E
GROUP BY E.age, E.niveau,
HAVING
S.niveau IN ----------- niveau le plus frequent pour cet age (E.age du groupe!)
	 (SELECT  E1.niveau  
	 FROM etudiant E1
	 WHERE E1.age = E.age   -- pour cet age
	 GROUP BY E1.niveau, E1.age 
	 HAVING	COUNT (*) >= ALL  
	 	      (SELECT COUNT (*) 
		       FROM etudiants  E2 
		       WHERE s1.age = E2.age 
		       GROUP BY E2.niveau, E2.age)
)		      
