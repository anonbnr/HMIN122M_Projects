SELECT Line.num_line, COUNT(Traveler.id) AS number_travelers
FROM Travel
INNER JOIN Line
	ON Travel.id_line = Line.id
INNER JOIN Traveler
	ON Travel.id_traveler = Traveler.id
INNER JOIN Date_t
	ON Travel.id_date = Date_t.id
WHERE Date_t.year = EXTRACT(YEAR FROM SYSDATE)
AND Date_t.month_year >= (EXTRACT(MONTH FROM SYSDATE) - 2)
AND Traveler.anonymous = 0
GROUP BY Line.num_line
ORDER BY Line.num_line;

SELECT Line.num_line, Vehicle.id, COUNT(Vehicle.id) AS number_vehicle
FROM Travel
INNER JOIN Line
	ON Travel.id_line = Line.id
INNER JOIN Vehicle
	ON Travel.id_vehicle = Vehicle.id
GROUP BY Line.num_line, Vehicle.id
HAVING COUNT(Vehicle.id) = (SELECT MAX(COUNT(*))
							FROM Travel
							INNER JOIN Line sl
								ON Travel.id_line = sl.id
							INNER JOIN Vehicle
								ON Travel.id_vehicle = Vehicle.id
							WHERE sl.num_line = Line.num_line
							GROUP BY Vehicle.id)
ORDER BY Line.num_line, Vehicle.id;

SELECT COUNT(*) AS number_maintained_bus
FROM Maintenance
INNER JOIN Vehicle
	ON Maintenance.id_vehicle = Vehicle.id
WHERE Vehicle.type = 'bus';
