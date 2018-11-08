-- 1) le nombre de voyage par bus, utilisant des tickets pour le mois de juillet
SELECT Travel.id_vehicle, COUNT(*) AS number_travel
FROM Travel
INNER JOIN Vehicle_travel ON Travel.id_vehicle = Vehicle_travel.id
INNER JOIN Traveler ON Travel.id_traveler = Traveler.id
INNER JOIN Date_travel ON Travel.id_date = Date_travel.id
WHERE Vehicle_travel.type = 'bus'
AND Traveler.anonymous = 1
AND Date_travel.month_year = 7
GROUP BY Travel.id_vehicle
ORDER BY Travel.id_vehicle;

-- 2) le nombre de voyageurs abonnés par ligne pour chaque voyage pour les deux derniers mois.
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

-- 3) Quelle est l'arrêt le plus fréquenté pour chaque ligne ?
SELECT Line.num_line, Station.id, Station.name, COUNT(station.id) AS frequentation
FROM Travel
INNER JOIN Line
	ON Travel.id_line = Line.id
INNER JOIN Station
	ON Travel.id_station = Station.id
GROUP BY Line.num_line, Station.id, Station.name
HAVING COUNT(Station.id) = (SELECT MAX(COUNT(*))
							FROM Travel
							INNER JOIN Line sl
								ON Travel.id_line = sl.id
							INNER JOIN Station
								ON Travel.id_station = Station.id
							WHERE sl.num_line = Line.num_line
							GROUP BY Station.id)
ORDER BY Line.num_line, Station.id;

-- 4) Le nombre de voyage par heure pour chaque ligne
SELECT Line.num_line, Time_travel.hours AS Hour, COUNT(*) AS number_travel
FROM Travel
INNER JOIN Line ON Travel.id_line = Line.id
INNER JOIN Time_travel ON Travel.id_time = Time_travel.id
GROUP BY Line.num_line, Time_travel.hours
ORDER BY Line.num_line, Time_travel.hours;

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
