-- data base about dogs, needed to find potential mating partners for all dogs; cant be related and needs to be certain age
SELECT f.imie AS Suka, m.imie AS Pies
FROM pies f JOIN pies m
ON f.rasa = m.rasa AND f.plec = 'suka' AND m.plec = 'pies'
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM pies przodek
        WHERE przodek.imie IN (f.matka, f.ojciec) AND przodek.imie IN (m.matka, m.ojciec)
    )
    AND f.data_urodzenia BETWEEN ADD_MONTHS(SYSDATE, -8 * 12) AND ADD_MONTHS(SYSDATE, -3 * 12)
    AND m.data_urodzenia BETWEEN ADD_MONTHS(SYSDATE, -8 * 12) AND ADD_MONTHS(SYSDATE, -3 * 12)
ORDER BY f.imie, m.imie;
