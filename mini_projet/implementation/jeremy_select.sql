SELECT Line.num_line, COUNT(Traveler.id) AS number_travelers
FROM Travel
INNER JOIN Line
	ON Travel.id_line = Line.id
INNER JOIN Traveler
	ON Travel.id_traveler = Traveler.id
INNER JOIN Date_t
	ON Travel.id_date = Date_t.id
WHERE Date_t.year = YEAR(getdate())
AND Date_t.month_year >= (MONTH(getdate()) - 2)
AND Traveler.anonymous = 0
GROUP BY Line.num_line;

SELECT Line.num_line, Vehicle.id, COUNT(Vehicle.id)
FROM Travel
INNER JOIN Line
	ON Travel.id_line = Line.id
INNER JOIN Vehicle
	ON Travel.id_vehicle = Vehicle.id
GROUP BY Line.num_line
ORDER BY Line.num_line, Vehicle.id;

SELECT COUNT(*) AS number_maintained_bus
FROM Maintenance
INNER JOIN Vehicle
	ON Vehicle.id_vehicle = Vehicle.id
WHERE Vehicle.type = 'bus';
