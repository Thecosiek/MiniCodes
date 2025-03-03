-- The database was about publication of profesors in my faculty. We needed to create Pilipczuk Michal number, same as Erdos number

WITH RECURSIVE LiczbaErdosa AS (
    SELECT 
        a.Autor AS Autor,
        0 AS Poziom
    FROM autorstwo a
    WHERE a.Autor = 'Pilipczuk Mi'
    
    UNION
    
    SELECT 
        aut.Autor AS Autor,
        le.Poziom + 1 AS Poziom
    FROM LiczbaErdosa le
    JOIN autorstwo au ON au.Autor = le.Autor
    JOIN autorstwo aut ON aut.Praca = au.Praca AND aut.Autor != le.Autor 
    WHERE le.Poziom < 130 -- ograniczona liczba poziomów rekurencji
)
, LiczbaErdosaFinal AS (
    SELECT 
        le.Autor AS Autor,
        MIN(le.Poziom) AS LiczbaErdosa
    FROM LiczbaErdosa le
    GROUP BY le.Autor
)
SELECT 
    a.ID AS Autor,
    le.LiczbaErdosa
FROM autorzy a
LEFT JOIN LiczbaErdosaFinal le ON a.ID = le.Autor
ORDER BY le.LiczbaErdosa, a.ID;
