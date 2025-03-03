-- We had database about dog heretage and needed to write the biggest amount of births for each female dog
WITH mioty AS(
    SELECT matka, data_urodzenia, COUNT(imie) AS Ile_szczeniakow
    FROM pies
    GROUP BY matka, data_urodzenia
)
SELECT a.imie AS Suczka, NVL(MAX(Ile_szczeniakow), 0) AS Najwiekszy_miot
FROM pies a LEFT JOIN mioty ON a.imie = mioty.matka
WHERE a.plec = 'suka'
GROUP BY a.imie;
