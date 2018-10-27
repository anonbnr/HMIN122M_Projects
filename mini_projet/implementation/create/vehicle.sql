CREATE TABLE vehicle(
	id NUMBER(10) PRIMARY KEY,
	type VARCHAR(5) NOT NULL,
	capacity_max NUMBER(4) NOT NULL,
	nb_seats NUMBER(3) NOT NULL,
	wheelchair_capacity NUMBER(3) NOT NULL,
	max_speed NUMBER(3) NOT NULL,
	model VARCHAR(50) NOT NULL,
);
