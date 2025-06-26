
-- monthly revenue


CREATE TABLE monthly_Revenue AS 
SELECT 
    source_month,
    COUNT(*) AS total_trips,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_trip_revenue
FROM yellow_tripdata_q1_2024
GROUP BY source_month
ORDER BY FIELD(source_month, 'January', 'February', 'March');

SELECT * from monthly_Revenue;


-- Top 5 Drop-Off Zones by Tips


CREATE TABLE top_5_dropoffzone_tips AS 
SELECT 
    dl.zone AS dropoff_zone,
    ROUND(SUM(y.tip_amount), 2) AS total_tips,
    COUNT(*) AS trip_count,
    ROUND(AVG(y.tip_amount), 2) AS avg_tip
FROM yellow_tripdata_q1_2024 y
JOIN dim_location dl ON y.DOLocationID = dl.location_id
GROUP BY dl.zone
ORDER BY total_tips DESC
LIMIT 5;


SELECT * from top_5_dropoffzone_tips;



-- Weekday vs Weekend Patterns

CREATE TABLE weekday_weekend_pattern AS
SELECT 
    CASE 
        WHEN d.weekday_name IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS total_trips,
    ROUND(AVG(y.total_amount), 2) AS avg_total_amount,
    ROUND(AVG(y.tip_amount), 2) AS avg_tip
FROM yellow_tripdata_q1_2024 y
JOIN dim_datetime d ON y.pickup_date = d.datetime_id
GROUP BY day_type;

SELECT * from top_5_dropoffzone_tips;



-- Most Frequent Trip Routes 


CREATE TABLE most_frequent_routes  AS
SELECT 
	y.PULocationID,
    y.DOLocationID,
    pu.zone AS pickup_zone,
    do.zone AS dropoff_zone,
    COUNT(*) AS trip_count
FROM yellow_tripdata_q1_2024 y
JOIN dim_location pu ON y.PULocationID = pu.location_id
JOIN dim_location do ON y.DOLocationID = do.location_id
GROUP BY y.PULocationID, y.DOLocationID, pickup_zone, dropoff_zone
ORDER BY trip_count DESC
LIMIT 10;


SELECT * FROM most_frequent_routes;



-- Tip % by Borough

CREATE TABLE tip_by_borough AS 
SELECT 
    dl.borough,
    ROUND(SUM(y.tip_amount) / NULLIF(SUM(y.fare_amount), 0) * 100, 2) AS avg_tip_percent
FROM yellow_tripdata_q1_2024 y
JOIN dim_location dl ON y.PULocationID = dl.location_id
GROUP BY dl.borough
ORDER BY avg_tip_percent DESC;


SELECT * FROM tip_by_borough;


-- Rolling 7-Day Avg Trip Volume Using Window Function


CREATE TABLE rolling_7_day_avg_trips (
    pickup_date DATE PRIMARY KEY,
    daily_trip_count INT,
    rolling_7_day_avg FLOAT
);

INSERT INTO rolling_7_day_avg_trips (pickup_date, daily_trip_count, rolling_7_day_avg)
SELECT 
    pickup_date,
    daily_trip_count,
    ROUND(AVG(daily_trip_count) OVER (
        ORDER BY pickup_date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_7_day_avg
FROM (
    SELECT 
        pickup_date,
        COUNT(*) AS daily_trip_count
    FROM yellow_tripdata_q1_2024
    GROUP BY pickup_date
) AS daily_trips;


SELECT * FROM rolling_7_day_avg_trips;



-- Rush Hour Volume by Weekday


CREATE TABLE rush_hour_weekdays AS
SELECT 
    d.weekday_name,
    COUNT(*) AS trip_count
FROM yellow_tripdata_q1_2024 y
JOIN dim_datetime d ON y.pickup_date = d.datetime_id
WHERE HOUR(y.pickup_time) BETWEEN 8 AND 10
GROUP BY d.weekday_name
ORDER BY FIELD(d.weekday_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

SELECT * FROM rush_hour_weekdays;


-- Top Routes View

CREATE VIEW vw_top_routes AS
SELECT 
    pu.zone AS pickup_zone,
    do.zone AS dropoff_zone,
    COUNT(*) AS trip_count
FROM yellow_tripdata_q1_2024 y
JOIN dim_location pu ON y.PULocationID = pu.location_id
JOIN dim_location do ON y.DOLocationID = do.location_id
GROUP BY pickup_zone, dropoff_zone
ORDER BY trip_count DESC
LIMIT 20;

SELECT * FROM vw_top_routes;



-- Rank, dense_rank, row_number

CREATE VIEW vw_ranked_top_zones AS
WITH trip_counts AS (
    SELECT 
        dl.borough,
        dl.zone,
        COUNT(*) AS trip_count
    FROM yellow_tripdata_q1_2024 y
    JOIN dim_location dl ON y.PULocationID = dl.location_id
    GROUP BY dl.borough, dl.zone
),
ranked_zones AS (
    SELECT 
        borough,
        zone,
        trip_count,
        RANK() OVER (PARTITION BY borough ORDER BY trip_count DESC) AS `rank`,
        DENSE_RANK() OVER (PARTITION BY borough ORDER BY trip_count DESC) AS `dense_rank`,
        ROW_NUMBER() OVER (PARTITION BY borough ORDER BY trip_count DESC) AS `row_number`
    FROM trip_counts
)
SELECT *
FROM ranked_zones
WHERE `rank` <= 3
ORDER BY borough, `rank`;


SELECT * FROM vw_ranked_top_zones;