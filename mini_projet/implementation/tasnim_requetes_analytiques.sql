--9)Quel est le type de problème le plus fréquent ?

SELECT MaintenanceType.maintenance_type, COUNT(Maintenance.id_maintenance_type) as totalCount
FROM Maintenance
INNER JOIN MaintenanceType
	ON  MaintenanceType.id = Maintenance.id_maintenance_type
GROUP BY MaintenanceType.maintenance_type
HAVING MAX(totalCount) >0

--10) Nombre de maintenance par année pour chaque local technique?
SELECT Maintenance.id_date,TechnicalArea.address ,COUNT(Maintenance.id_technical_area)
FROM  Maintenance
INNER JOIN  TechnicalArea
	ON  Maintenance.id_technical_area = TechnicalArea.id
INNER JOIN Date_t
	ON Maintenance.id_date = date_t.id
GROUP BY Maintenance.id_date
