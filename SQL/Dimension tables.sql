--   Dimension Date Table

CREATE TABLE dim_datetime (
    date_id DATE PRIMARY KEY,
    year INT,
    month INT,
    month_name VARCHAR(15),
    day INT,
    weekday_name VARCHAR(10)
);

INSERT INTO dim_datetime (date_id, year, month, month_name, day, weekday_name)
SELECT DISTINCT
    pickup_date,
    YEAR(pickup_date),
    MONTH(pickup_date),
    MONTHNAME(pickup_date),
    DAY(pickup_date),
    DAYNAME(pickup_date)
FROM yellow_tripdata_q1_2024;

SELECT * FROM dim_datetime;




--   Dimension Table for Payments

CREATE TABLE dim_payment (
    payment_type INT PRIMARY KEY,
    payment_description VARCHAR(30)
);

INSERT INTO dim_payment VALUES
(1, 'Credit Card'),
(2, 'Cash'),
(3, 'No Charge'),
(4, 'Dispute'),
(5, 'Unknown'),
(6, 'Voided Trip');

SELECT * FROM dim_payment;



--   Dimension Table for Location


CREATE TABLE dim_location (
    location_id INT PRIMARY KEY,
    borough VARCHAR(50),
    zone VARCHAR(100),
    service_zone VARCHAR(50)
);

-- Imported from taxi_zone_lookup.csv file

SELECT * FROM dim_location;

