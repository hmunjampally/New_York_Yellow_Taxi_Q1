
-- grouping trips by part of the day (Morning, Afternoon, Evening, Night)


CREATE TABLE trip_bucket_by_hour AS
SELECT 
    CASE 
        WHEN HOUR(pickup_time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(pickup_time) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN HOUR(pickup_time) BETWEEN 17 AND 21 THEN 'Evening'
        ELSE 'Night'
    END AS time_bucket,
    COUNT(*) AS total_trips,
    ROUND(AVG(total_amount), 2) AS avg_total_amount
FROM yellow_tripdata_q1_2024
GROUP BY time_bucket
ORDER BY FIELD(time_bucket, 'Morning', 'Afternoon', 'Evening', 'Night');




CREATE TABLE trip_bucket_by_hour AS
SELECT 
    CASE 
        WHEN HOUR(pickup_time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(pickup_time) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN HOUR(pickup_time) BETWEEN 17 AND 21 THEN 'Evening'
        ELSE 'Night'
    END AS time_bucket,
    COUNT(*) AS total_trips,
    ROUND(AVG(total_amount), 2) AS avg_total_amount
FROM yellow_tripdata_q1_2024
GROUP BY time_bucket
ORDER BY FIELD(time_bucket, 'Morning', 'Afternoon', 'Evening', 'Night');



CREATE VIEW vw_tip_analysis_by_payment AS
SELECT 
    dp.payment_description,
    COUNT(*) AS total_trips,
    ROUND(AVG(y.tip_amount), 2) AS avg_tip,
    ROUND(SUM(y.tip_amount), 2) AS total_tip_amount
FROM yellow_tripdata_q1_2024 y
JOIN dim_payment dp ON y.payment_type = dp.payment_type
GROUP BY dp.payment_description
ORDER BY avg_tip DESC;


CREATE VIEW vw_tip_analysis_by_payment AS
SELECT 
    dp.payment_description,
    COUNT(*) AS total_trips,
    ROUND(AVG(y.tip_amount), 2) AS avg_tip,
    ROUND(SUM(y.tip_amount), 2) AS total_tip_amount
FROM yellow_tripdata_q1_2024 y
JOIN dim_payment dp ON y.payment_type = dp.payment_type
GROUP BY dp.payment_description
ORDER BY avg_tip DESC;
