/*
*  Author : Djebien Tarik;
*/


/* Exercice 2 SQL */

/* 1 */
/* remarque : dans mes tables nom_med équivaut à nom */
select nom_med from medecins, soins
where soins.numed = medecins.numed
and soins.numpat =
(select numpat from patients where nom = 'MOUGIN');

/* 2 */
select designation from medicaments, soins
where medicaments.refmed = soins.refmed
and soins.numed = 
(select numed from medecins where nom_med = 'LUCAS')
and soins.numpat =
(select numpat from patients where nom = 'MOUGIN');

/ 3 */

select medicaments.designation 
from medicaments, Vsoins
where medicaments.refmed = Vsoins.refmed
and Vsoins.numpat =
(select numpat 
 from patients 
 where nom = 'MOUGIN')
and Vsoins.date > 
( select AVG(Vsoins.date) 
  from Vsoins 
  where Vsoins.numpat = ( select numpat 
                          from patients 
                          where nom = 'MOUGIN'
                        )
);

/* 4 */
/* R1 */
select date_soin, prix
from soins, medicaments
where soins.refmed = medicaments.refmed
and soins.numpat = (select numpat 
                    from patients 
                    where nom = 'MOUGIN');

/* ensuite on cherche la date et le prix max des medicaments dans R1 */

select date_soin ,prix from
(select date_soin, prix
from soins, medicaments
where soins.refmed = medicaments.refmed
and soins.numpat = (select numpat from patients 
                          where nom = 'MOUGIN')
)
where prix =
(select MAX(prix)
from soins, medicaments
where soins.refmed = medicaments.refmed
and soins.numpat = (select numpat from patients 
                          where nom = 'MOUGIN')
);

/* finalement on donne la designation correspondant a ce prix */

select date_soin ,prix,designation from
(select date_soin, prix,designation
from soins, medicaments
where soins.refmed = medicaments.refmed
and soins.numpat = (select numpat from patients 
                          where nom = 'MOUGIN')
)
where prix =
(select MAX(prix)
from soins, medicaments
where soins.refmed = medicaments.refmed
and soins.numpat = (select numpat from patients 
                          where nom = 'MOUGIN')
);