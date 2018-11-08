SELECT line.num_line, COUNT(traveler.id)
FROM travel
INNER JOIN line
	ON travel.id_line = line.id
INNER JOIN traveler
	ON travel.id_traveler = traveler.id
INNER JOIN date_t
	ON travel.id_date = date_t.id
WHERE date_t.year = YEAR(getdate())
AND date_t.month_year >= (MONTH(getdate()) - 2)
AND traveler.anonymous = 0
GROUP BY line.num_line;

SELECT line.num_line, MAX(COUNT(vehicle.id))
FROM travel
INNER JOIN line
	ON travel.id_line = line.id
INNER JOIN vehicle
	ON vehicle.id_vehicle = vehicle.id
GROUP BY line.num_line;

SELECT COUNT(*)
FROM maintenance
INNER JOIN vehicle
	ON vehicle.id_vehicle = vehicle.id
WHERE vehicle.type = 'bus';
