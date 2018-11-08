--9)Quel est le type de problème le plus fréquent ?

SELECT MaintenanceType.maintenance_type, COUNT(Maintenance.id_maintenance_type) AS totalCount
FROM Maintenance
INNER JOIN MaintenanceType
	ON  MaintenanceType.id = Maintenance.id_maintenance_type
GROUP BY MaintenanceType.maintenance_type
HAVING COUNT(Maintenance.id_maintenance_type) = (SELECT MAX(COUNT(*))
												FROM Maintenance
												GROUP BY Maintenance.id_maintenance_type);

--10) Nombre de maintenance par année pour chaque local technique?
SELECT TechnicalArea.id, Date_maintenance.month_year, COUNT(Maintenance.id_technical_area)
FROM  Maintenance
INNER JOIN  TechnicalArea
	ON  Maintenance.id_technical_area = TechnicalArea.id
INNER JOIN Date_maintenance
	ON Maintenance.id_date = Date_maintenance.id
GROUP BY TechnicalArea.id, Date_maintenance.month_year;
