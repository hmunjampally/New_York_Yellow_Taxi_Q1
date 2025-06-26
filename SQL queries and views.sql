
-- creating table for faster data access


CREATE TABLE trips_summary_by_weekday AS
WITH trips_by_day AS (
    SELECT 
        d.weekday_name,
        COUNT(*) AS total_trips,
        ROUND(AVG(y.trip_duration_mins), 2) AS avg_trip_duration
    FROM yellow_tripdata_q1_2024 y
    JOIN dim_datetime d ON y.pickup_date = d.datetime_id
    GROUP BY d.weekday_name
)
SELECT *
FROM trips_by_day
ORDER BY FIELD(weekday_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');


-- creating views for future data updates

CREATE VIEW vw_trips_summary_by_weekday AS
WITH trips_by_day AS (
    SELECT 
        d.weekday_name,
        COUNT(*) AS total_trips,
        ROUND(AVG(y.trip_duration_mins), 2) AS avg_trip_duration
    FROM yellow_tripdata_q1_2024 y
    JOIN dim_datetime d ON y.pickup_date = d.datevw_trip_bucket_by_hourvw_trip_bucket_by_hour_id
    GROUP BY d.weekday_name
)
SELECT *
FROM trips_by_day;


SELECT * FROM trips_summary_by_weekday;