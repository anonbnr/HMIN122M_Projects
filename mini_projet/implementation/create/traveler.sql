CREATE TABLE traveler(
	id NUMBER(10) PRIMARY KEY,
	anonymous NUMBER(1) NOT NULL,
	birth_year NUMBER(4),
	address VARCHAR(100),
	name VARCHAR(50),
	surname VARCHAR(50),
	gender VARCHAR(8),
	nationality VARCHAR(50),
	subscription_type VARCHAR(10),
	subscription_fees NUMBER(3, 2)
);
