CREATE TABLE Vehicule(
	id int,
	type varchar(50),
	capacity int,
	number_seat int,
	number_standing int,
	wheelchair_capacity int,
	max_speed int,
	model varchar(50),
	PRIMARY KEY (id)
);

CREATE TABLE Time(
	id int,
	full_time_description varchar(50),
	hours int,
	minutes int,
	AM_PM_indicator varchar(2),
	day_part_segment varchar(50),
	PRIMARY KEY(id)
);
CREATE TABLE Date_t(
	id int,
	date_t int,
	year int, 
	month_year int,
	month_calendar varchar(10),
	day_month int,
	day_calendar varchar(10),
	day_week int,
	day_year int,
	holiday_indicator varchar(20),
	weekday_indicator varchar(20),
	PRIMARY KEY(id)
);
CREATE TABLE Employee(
	id int,
	birth_year int,
	address varchar(150),
	employee_name varchar(50),
	surname varchar(50),
	gender varchar(10),
	nationality varchar(50),
	contract_type varchar(50),
	contract_start_year int,
	salary number,
	experience_year int,
	PRIMARY KEY(id)
);

CREATE TABLE MaintenanceType(
	id int,
	maintenanceType varchar(150),
	nb_completed_levels int,
	PRIMARY KEY(id)
);

CREATE TABLE TechnicalArea(
	id int,
	address varchar(15),
	vehicule_capacity int,
	type_maintained_vehicules varchar(5),
	surface int,
	monthly_cost number,
	equipment_level int,
	workforce_size int,
	PRIMARY KEY(id)
);

CREATE TABLE Maintenance(
	id_date int,
	id_time int,
	id_vehicule int,
	id_employee int,
	id_technical_area int,
	id_maintenance_type int,
	cost number,
	estimated_time int,
	completion_status int,
	FOREIGN KEY (id_date) REFERENCES Date_t(id),
	FOREIGN KEY (id_time) REFERENCES Time(id),
	FOREIGN KEY (id_vehicule) REFERENCES Vehicule(id),
	FOREIGN KEY (id_employee) REFERENCES Employee(id),
	FOREIGN KEY (id_technical_area) REFERENCES TechnicalArea(id),
	FOREIGN KEY (id_maintenance_type) REFERENCES MaintenanceType(id)
);