-- COMPAGNIE AERIENNE
------------------------------------------------------

--Exo2.1 -

SELECT C.eid, MAX (A.portee) 
FROM Certifications C, Avion A 
WHERE C.aid = A.aid
GROUP BY C.eid 
HAVING	COUNT (*) > 3


-----------------------------------------------------
-- Exo2.2 -

   SELECT DISTINCT E.enom 
   FROM	Employees E
   WHERE	E.salaire <	 
 ( 
SELECT MIN (F.prix) 
FROM	Vols V
WHERE	V.dep = 'CDG' 
AND  V.arr = 'NOU' 
)

---- alternative 1
select e.nom, e.eid
from employees e
where e.salaire < ALL
(
	select prix from vols v
	where v.dep='CDG' and v.arr='NOU'
)

----- alternative 2
select e.nom, e.eid
from employees e
where not exists
(
	select prix
	from vols v
	where v.prix<e.salaire and v.dep='CDG' and v.arr='NOU'
)

--------------------------------------------------------
---Exo 2.3 -

SELECT E.enom 
FROM Employees E, Certifications C, Avion A 
WHERE C.aid = A.aid AND E.eid = C.eid
GROUP BY E.eid, E.enom
HAVING EVERY (A.portee > 1500)

----- alternative 1

SELECT E.enom 
FROM Employees E, Certifications C, Avion A 
WHERE C.aid = A.aid AND E.eid = C.eid
GROUP BY E.eid, E.enom
HAVING Min (A.portee) > 1500


------ alternative 2

SELECT e.nom, e.eid
from Employees E
where not exists
(select * 
from certifications c, avions a
where c.eid=e.eid and c.aid=a.aid and protee <=1500)

---------------------------------------------------
----- Exo2.4-

SELECT E.ename 
FROM Employees E, Certifications C, Avion A 
WHERE C.aid = A.aid AND E.eid = C.eid 
GROUP BY E.eid,  E.enom
HAVING EVERY (A.portee > 1500) AND COUNT (*) > 1

----------------------------------------------------
------ Exo 2.5-

SELECT  E.ename 
FROM Employees E, Certifications C, Avion A 
WHERE C.aid = A.aid AND E.eid = C.eid 
GROUP BY E.eid, E.enom
HAVING EVERY (A.portee > 1500) AND ANY (A.anom Like ’%Boeing%’)

