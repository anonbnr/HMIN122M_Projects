CREATE TABLE time(
	id NUMBER(10) PRIMARY KEY,
	full_time_description : VARCHAR(20),
	hours NUMBER(2),
	minutes NUMBER(2),
	AM_PM_indicator VARCHAR(2),
	day_part_segment VARCHAR(10)
);
