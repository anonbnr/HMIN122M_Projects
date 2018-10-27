CREATE TABLE date(
	id NUMBER(10) PRIMARY KEY,
	date DATE,
	year NUMBER(4),
	month_year NUMBER(6),
	month_calendar VARCHAR(16),
	day_month NUMBER(6),
	day_calendar VARCHAR(16),
	day_week NUMBER(2),
	day_year NUMBER(6),
	holiday_indicator VARCHAR(8),
	weekday_indicator VARCHAR(8)
);
