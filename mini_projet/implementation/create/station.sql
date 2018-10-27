CREATE TABLE station(
	id NUMBER(10) PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	coord_x NUMBER(3, 5) NOT NULL,
	coord_y NUMBER(3, 5) NOT NULL,
	place VARCHAR(50) NOT NULL,
	disability_access NUMBER(1) NOT NULL,
	sheltered_for_rain NUMBER(1) NOT NULL
);
