Create database nyc_taxi_data;
use nyc_taxi_data;

CREATE TABLE yellow_tripdata_q1_2024 (
    VendorID VARCHAR(10),
    passenger_count INT,
    trip_distance FLOAT,
    RatecodeID INT,
    store_and_fwd_flag CHAR(1),
    PULocationID INT,
    DOLocationID INT,
    payment_type INT,
    fare_amount FLOAT,
    extra FLOAT,
    mta_tax FLOAT,
    tip_amount FLOAT,
    tolls_amount FLOAT,
    improvement_surcharge FLOAT,
    total_amount FLOAT,
    congestion_surcharge FLOAT,
    Airport_fee FLOAT,
    source_month VARCHAR(10),
    pickup_date DATE,
    pickup_time TIME,
    dropoff_date DATE,
    dropoff_time TIME,
    trip_duration_mins FLOAT
);

SELECT COUNT(*) FROM yellow_tripdata_q1_2024;

SELECT DISTINCT(source_month) FROM yellow_tripdata_q1_2024;

DESCRIBE yellow_tripdata_q1_2024;


-- Converting Text to respective Date and Time Datatypes

ALTER TABLE yellow_tripdata_q1_2024
MODIFY pickup_date DATE;

ALTER TABLE yellow_tripdata_q1_2024
MODIFY dropoff_date DATE;

ALTER TABLE yellow_tripdata_q1_2024
MODIFY pickup_time TIME;

ALTER TABLE yellow_tripdata_q1_2024
MODIFY dropoff_time TIME;


-- created index on pickup_date, PULocationID, DOLocationID, payment_type

CREATE INDEX id_pickup_date ON yellow_tripdata_q1_2024 (pickup_date);
CREATE INDEX id_pulocation ON yellow_tripdata_q1_2024 (PULocationID);
CREATE INDEX id_dolocation ON yellow_tripdata_q1_2024 (DOLocationID);
CREATE INDEX id_payment_type ON yellow_tripdata_q1_2024 (payment_type);




