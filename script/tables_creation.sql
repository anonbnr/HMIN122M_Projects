/**
@author Jérémy Bourgin
@author Joseph Saba
*/

/*DIMENSIONS*/
CREATE TABLE Date_t(
  id INT,
	date_t DATE,
	year INT,
	month_year INT,
	month_calendar VARCHAR(16),
	day_month INT,
	day_calendar VARCHAR(16),
	day_week INT,
	day_year INT,
	holiday_indicator VARCHAR(20),
	weekday_indicator VARCHAR(20),
	CONSTRAINT PK_DATE
		PRIMARY KEY(id)
);

CREATE TABLE Time_t(
	id INT,
	full_time_description VARCHAR(20),
	hours INT,
	minutes INT,
	AM_PM_indicator VARCHAR(2),
	day_part_segment VARCHAR(50),
	CONSTRAINT PK_TIME
		PRIMARY KEY(id)
);

CREATE TABLE Vehicle(
	id INT,
	type VARCHAR(5) NOT NULL,
  model VARCHAR(50) NOT NULL,
	capacity INT NOT NULL,
	nb_seats INT NOT NULL,
	wheelchair_capacity INT NOT NULL,
	max_speed INT,
	CONSTRAINT PK_VEHICLE
		PRIMARY KEY(id)
);

CREATE TABLE Line(
	id INT,
  num_line INT NOT NULL,
	start_station VARCHAR(50) NOT NULL,
	end_station VARCHAR(50) NOT NULL,
	nb_stations INT NOT NULL,
	distance_travel DECIMAL NOT NULL,
	avg_duration_travel DECIMAL NOT NULL,
	type_vehicle VARCHAR(5) NOT NULL,
	nb_served_people INT NOT NULL,
	avg_duration_btw_stations DECIMAL NOT NULL,
	CONSTRAINT PK_LINE
		PRIMARY KEY(id)
);

CREATE TABLE Station(
	id INT,
	name VARCHAR(50) NOT NULL,
	coord_x DECIMAL(8, 5) NOT NULL,
	coord_y DECIMAL(8, 5) NOT NULL,
	place VARCHAR(50) NOT NULL,
	disability_access DECIMAL(1) NOT NULL,
	sheltered_for_rain DECIMAL(1) NOT NULL,
	CONSTRAINT PK_STATION
		PRIMARY KEY(id)
);

CREATE TABLE Traveler(
	id INT,
	anonymous TINYINT(1) NOT NULL,
	birth_year INT,
	address VARCHAR(100),
	name VARCHAR(50),
	surname VARCHAR(50),
	gender VARCHAR(8),
	nationality VARCHAR(50),
	subscription_type VARCHAR(10),
	subscription_fees DECIMAL(5, 2),
	CONSTRAINT PK_TRAVELER
		PRIMARY KEY(id)
);

CREATE TABLE Employee(
	id INT,
	birth_year INT,
	address VARCHAR(100),
	name VARCHAR(50),
	surname VARCHAR(50),
	gender VARCHAR(8),
	nationality VARCHAR(50),
	contract_type VARCHAR(50),
	contract_start_year INT,
	salary DECIMAL,
	experience_year INT,
  CONSTRAINT PK_EMPLOYEE
    PRIMARY KEY(id)
);

CREATE TABLE MaintenanceType(
  id INT,
  maintenance_type VARCHAR(150),
  nb_completed_levels INT,
  CONSTRAINT PK_MAINTENANCE_TYPE
    PRIMARY KEY(id)
);

CREATE TABLE TechnicalArea(
	id INT,
	address VARCHAR(100),
	vehicule_capacity INT,
	type_maintained_vehicules VARCHAR(15),
	surface INT,
	monthly_cost DECIMAL,
	equipment_level INT,
	workforce_size INT,
  CONSTRAINT PK_TECHNICAL_AREA
    PRIMARY KEY(id)
);

/*FACTS*/
CREATE TABLE Travel(
  id_travel INT UNIQUE,
	id_date INT,
	id_time INT,
	id_traveler INT,
	id_line INT,
	id_station INT,
	id_vehicle INT,
	CONSTRAINT PK_TRAVEL
		PRIMARY KEY(id_travel, id_date, id_time, id_traveler, id_line, id_station, id_vehicle),
	CONSTRAINT FK_TRAVEL_DATE
		FOREIGN KEY(id_date) REFERENCES Date_t(id),
	CONSTRAINT FK_TRAVEL_TIME
		FOREIGN KEY(id_time) REFERENCES Time_t(id),
	CONSTRAINT FK_TRAVEL_TRAVELER
		FOREIGN KEY(id_traveler) REFERENCES Traveler(id),
	CONSTRAINT FK_TRAVEL_LINE
		FOREIGN KEY(id_line) REFERENCES Line(id),
	CONSTRAINT FK_TRAVEL_STATION
		FOREIGN KEY(id_station) REFERENCES Station(id),
	CONSTRAINT FK_TRAVEL_VEHICLE
		FOREIGN KEY(id_vehicle) REFERENCES Vehicle(id)
);

CREATE TABLE Maintenance(
	id_date INT,
	id_time INT,
	id_vehicle INT,
	id_employee INT,
	id_technical_area INT,
	id_maintenance_type INT,
	cost DECIMAL,
	estimated_time INT,
	completion_status INT,
  CONSTRAINT PK_MAINTENANCE
    PRIMARY KEY(id_date, id_time, id_vehicle, id_employee, id_technical_area, id_maintenance_type),
  CONSTRAINT FK_MAINTENANCE_DATE
    FOREIGN KEY(id_date) REFERENCES Date_t(id),
  CONSTRAINT FK_MAINTENANCE_TIME
    FOREIGN KEY(id_time) REFERENCES Time_t(id),
  CONSTRAINT FK_MAINTENANCE_VEHICLE
    FOREIGN KEY(id_vehicle) REFERENCES Vehicle(id),
  CONSTRAINT FK_MAINTENANCE_EMPLOYEE
    FOREIGN KEY(id_employee) REFERENCES Employee(id),
  CONSTRAINT FK_MAINTENANCE_TECHNICAL_AREA
    FOREIGN KEY(id_technical_area) REFERENCES TechnicalArea(id),
  CONSTRAINT FK_MAINTENANCE_MAIN_TYPE
    FOREIGN KEY(id_maintenance_type) REFERENCES MaintenanceType(id)
);
