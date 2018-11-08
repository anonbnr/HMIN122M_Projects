-- 1) le nombre de voyage par bus, utilisant des tickets pour le mois de juillet

SELECT Travel.id_vehicle, COUNT(*) AS number_travel
FROM Travel
INNER JOIN Vehicle ON Travel.id_vehicle = Vehicle.id
INNER JOIN Traveler ON Travel.id_traveler = Traveler.id
INNER JOIN Date_t ON Travel.id_date = Date_t.id
WHERE Vehicle.type = 'bus'
AND Traveler.anonymous = 1
AND Date_t.month_year = 7
GROUP BY Travel.id_vehicle
ORDER BY Travel.id_vehicle;

-- 4) Le nombre de voyage par heure pour chaque ligne
SELECT Line.num_line, Time_t.hours AS Hour, COUNT(*) AS number_travel
FROM Travel
INNER JOIN Line ON Travel.id_line = Line.id
INNER JOIN Time_t ON Travel.id_time = Time_t.id
GROUP BY Line.num_line, Time_t.hours
ORDER BY Line.num_line, Time_t.hours;


-- 8) les X premiers véhicules qui ont nécessité le plus de maintenance pour les 6 dernier mois.
SELECT Maintenance.id_vehicle, COUNT(*) AS number_maintenance
FROM Maintenance
INNER JOIN Vehicle ON Maintenance.id_vehicle = Vehicle.id
INNER JOIN Date_t ON Maintenance.id_date = Date_t.id
WHERE Date_t.month_year >= (EXTRACT(MONTH FROM SYSDATE) - 6)
AND rownum < 5
GROUP BY Maintenance.id_vehicle
ORDER BY number_maintenance DESC;
