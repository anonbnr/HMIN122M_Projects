-- 6) le coût total de maintenance de chaque véhicule
SELECT Vehicle_maintenance.id, SUM(cost)
FROM Maintenance
INNER JOIN Vehicle_maintenance
	ON Maintenance.id_vehicle = Vehicle_maintenance.id
GROUP BY Vehicle_maintenance.id;

-- 7) le nombre total de maintenances effectués sur les bus par employé pour l'année 2018
SELECT Employee.id AS Employee, COUNT(*) as intervention
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

-- 8) le nombre total de maintenances effectué par véhicule pour les 6 dernier mois.
SELECT Maintenance.id_vehicle, COUNT(*) AS number_maintenance
FROM Maintenance
INNER JOIN Vehicle_maintenance ON Maintenance.id_vehicle = Vehicle_maintenance.id
INNER JOIN Date_maintenance ON Maintenance.id_date = Date_maintenance.id
WHERE Date_maintenance.month_year >= (EXTRACT(MONTH FROM SYSDATE) - 6)
AND Maintenance.id_operation_type = 5
GROUP BY Maintenance.id_vehicle
ORDER BY number_maintenance DESC;

--9) Quel est le type de problème le plus fréquent ?
SELECT MaintenanceType.maintenance_type AS type, COUNT(Maintenance.id_maintenance_type) AS totalCount
FROM Maintenance
INNER JOIN MaintenanceType
	ON  MaintenanceType.id = Maintenance.id_maintenance_type
GROUP BY MaintenanceType.maintenance_type
HAVING COUNT(Maintenance.id_maintenance_type) = (SELECT MAX(COUNT(*))
												FROM Maintenance
												GROUP BY Maintenance.id_maintenance_type);

--10) Le nombre de maintenances par mois pour chaque local technique ?
SELECT TechnicalArea.id, Date_maintenance.month_year, COUNT(Maintenance.id_technical_area) AS numberMaintenance
FROM  Maintenance
INNER JOIN  TechnicalArea
	ON Maintenance.id_technical_area = TechnicalArea.id
INNER JOIN Date_maintenance
	ON Maintenance.id_date = Date_maintenance.id
GROUP BY TechnicalArea.id, Date_maintenance.month_year
ORDER BY TechnicalArea.id, Date_maintenance.month_year;

-- 11) Le nombre de véhicules qui ont été maintenus le matin, et le nombre de véhicule qui ont été maintenu l'après midi
SELECT Time_maintenance.AM_PM_indicator, COUNT(Vehicle_maintenance.id) AS numberMaintenance
FROM Maintenance
INNER JOIN Vehicle_maintenance
	ON Maintenance.id_vehicle = Vehicle_maintenance.id
INNER JOIN Time_maintenance
	ON Maintenance.id_time = Time_maintenance.id
GROUP BY Time_maintenance.AM_PM_indicator;
