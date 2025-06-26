CREATE VIEW vw_heatmap_weekday_hour AS
SELECT 
    d.weekday_name,
    HOUR(y.pickup_time) AS pickup_hour,
    COUNT(*) AS trip_count
FROM yellow_tripdata_q1_2024 y
JOIN dim_datetime d ON y.pickup_date = d.date_id
GROUP BY d.weekday_name, pickup_hour;



CREATE TABLE heatmap_weekday_hour AS
SELECT 
    d.weekday_name,
    HOUR(y.pickup_time) AS pickup_hour,
    COUNT(*) AS trip_count
FROM yellow_tripdata_q1_2024 y
JOIN dim_datetime d ON y.pickup_date = d.date_id
GROUP BY d.weekday_name, pickup_hour;

SELECT * FROM heatmap_weekday_hour;


