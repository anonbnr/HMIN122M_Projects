CREATE TABLE line(
	id NUMBER(10) PRIMARY KEY,
	start_station VARCHAR(50) NOT NULL,
	end_station VARCHAR(50) NOT NULL,
	nb_stations NUMBER(3) NOT NULL,
	distance_travel NUMBER(3) NOT NULL,
	avg_duration_travel NUMBER(3) NOT NULL,
	type_vehicle VARCHAR(5) NOT NULL,
	nb_served_people NUMBER(4) NOT NULL,
	avg_duration_btw_stations NUMBER(2) NOT NULL,
	num_line NUMBER(2) NOT NULL
);
