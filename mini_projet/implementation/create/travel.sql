CREATE TABLE travel(
	id_travel NUMBER(10) UNIQUE,
	id_date NUMBER(10),
	id_time NUMBER(10),
	id_traveler NUMBER(10),
	id_line NUMBER(10),
	id_station NUMBER(10),
	id_vehicle NUMBER(10),
	CONSTRAINT PK_TRAVEL PRIMARY KEY (id_travel, id_date, id_time, id_traveler, id_line, id_station, id_vehicle)
);
