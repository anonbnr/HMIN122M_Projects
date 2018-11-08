-- 2) le nombre de voyageurs abonnés par ligne pour chaque voyage
-- pour les deux derniers mois.

SELECT Line.num_line, COUNT(Traveler.id) AS number_travelers
FROM Travel
INNER JOIN Line
	ON Travel.id_line = Line.id
INNER JOIN Traveler
	ON Travel.id_traveler = Traveler.id
INNER JOIN Date_travel 
	ON Travel.id_date = Date_travel.id
WHERE Date_travel.year = EXTRACT(YEAR FROM SYSDATE)
AND Date_travel.month_year >= (EXTRACT(MONTH FROM SYSDATE) - 2)
AND Traveler.anonymous = 0
GROUP BY Line.num_line
ORDER BY Line.num_line;

-- 5) Pour chaque ligne quelle est le véhicule le plus utilisé par les voyageurs

SELECT Line.num_line, Vehicle_travel.id, COUNT(Vehicle_travel.id) AS number_vehicle
FROM Travel
INNER JOIN Line
	ON Travel.id_line = Line.id
INNER JOIN Vehicle_travel
	ON Travel.id_vehicle = Vehicle_travel.id
GROUP BY Line.num_line, Vehicle_travel.id
HAVING COUNT(Vehicle_travel.id) = (SELECT MAX(COUNT(*))
							FROM Travel
							INNER JOIN Line sl
								ON Travel.id_line = sl.id
							INNER JOIN Vehicle_travel
								ON Travel.id_vehicle = Vehicle_travel.id
							WHERE sl.num_line = Line.num_line
							GROUP BY Vehicle_travel.id)
ORDER BY Line.num_line, Vehicle_travel.id;

-- 6) le nombre de bus maintenus pour le mois de septembre 2018.

SELECT COUNT(*) AS number_maintained_bus
FROM Maintenance
INNER JOIN Vehicle_maintenance
	ON Maintenance.id_vehicle = Vehicle_maintenance.id
INNER JOIN Date_maintenance
	ON Maintenance.id_date = Date_maintenance.id
WHERE Vehicle_maintenance.type = 'bus'
AND Date_maintenance.month_year = 9
AND Date_maintenance.year = 2018;

-- 7) les X méchaniciens qui ont maintenu le plus de bus l'année précédente
SELECT Employee.id, COUNT(*) as intervention
FROM Maintenance
INNER JOIN Employee
	ON Maintenance.id_employee = Employee.id
INNER JOIN Vehicle_maintenance
	ON Maintenance.id_vehicle = Vehicle_maintenance.id
INNER JOIN Date_maintenance
	ON Maintenance.id_date = Date_maintenance.id
WHERE Vehicle_maintenance.type = 'bus'
AND Date_maintenance.year = 2018
GROUP BY Employee.id; 
