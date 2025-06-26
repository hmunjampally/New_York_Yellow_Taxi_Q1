# 🚖 Advanced SQL Analysis on NYC Yellow Taxi Trips (Q1 2024)

This project analyzes over **8.5 million NYC Yellow Taxi trips (Jan–Mar 2024)** using only **SQL** and **Python**. It demonstrates advanced SQL skills — including dimensional modeling, CTEs, window functions, and time-series logic — paired with Python for bulk data ingestion.

---

## 🧠 Project Goal

Build a high-performance, SQL-only data model and analytical layer to uncover insights from NYC Yellow Taxi data — enabling downstream dashboards and reports.

---

## 🗂️ Dataset Overview

- **Source**: NYC TLC Yellow Taxi Trip Data (2024)
- **Volume**: ~8.5 million rows
- **Preprocessing**: Converted from Parquet → CSV → MySQL via Python
- **Schema**: Star schema with fact and dimension tables

---

## 🔄 Data Ingestion Using Python

- Loaded large CSV files (~8.5M rows) using chunked inserts with `pandas.to_sql()`
- Used `SQLAlchemy` to connect Python to MySQL
- Script available at: [`python/connecting_python_mysql.py`](python/connecting_python_mysql.py)

---

## 🛠️ Tools & Tech Stack

- **Python 3** (with `pandas`, `sqlalchemy`, `mysql-connector`) for data loading and ETL
- **MySQL 8.0** for storage, querying, and modeling
- **SQL** for CTEs, window functions, aggregations, and views
- **Power BI** (optional) for dashboard visualizations


---

## 🏗️ Schema Diagram (Star Schema)

                             ┌──────────────────────┐
                             │     dim_payment      │
                             └────────┬─────────────┘
                                      │
                                      │
                             ┌────────▼────────────────┐
                             │ yellow_tripdata_q1_2024 │
                             │    (Fact Table)         │
                             └────────┬────────────────┘
             ┌────────────────────────┼────────────────────────┐
             │                        │                        │
             ▼                        ▼                        ▼
    ┌────────────────┐      ┌──────────────────┐     ┌──────────────────┐
     │  dim_datetime  │      │   dim_location   │     │   dim_location   │
     │  (pickup_date) │      │ (PULocationID)   │     │ (DOLocationID)   │
    └────────────────┘      └──────────────────┘     └──────────────────┘


---

## ✅ SQL Skills Demonstrated

| Skill                        | Usage Example |
|-----------------------------|----------------|
| **Data Cleaning**           | Trip duration filters, NULL handling |
| **Joins**                   | Linking locations, dates, and payment types |
| **CTEs**                    | Weekday-wise summaries, sub-aggregates |
| **Window Functions**        | Zone ranking, rolling averages |
| **CASE Statements**         | Fare bucketing, time-of-day grouping |
| **Views**                   | Dashboard-ready logic encapsulated |
| **Indexes**                 | Improved filter performance |
| **Python ETL**              | Loaded multi-million row CSV into MySQL using pandas + SQLAlchemy |

---

## 🔍 Analytical Highlights

### ✅ Time-Based Analysis
- Trip duration trends by **weekday**
- Revenue by **source month**
- Volume by **time of day** (Morning, Afternoon, Night)

### ✅ Location & Route Analysis
- **Top pickup zones** per borough
- **Most frequent routes**
- **Top drop-off zones by tips**

### ✅ Payment & Tip Analysis
- **Tip % by payment type**
- **Average tip by borough**
- **Dispute/no-charge trends**

### ✅ Visual-Ready Tables/Views
- `vw_trip_summary_by_date`
- `vw_heatmap_weekday_hour`
- `vw_ranked_top_zones`
- `vw_top_routes`
- `vw_tip_analysis_by_payment`

---

## 🧠 Advanced Features

- **Rolling 7-day average** trip volumes
- **Rush hour** traffic analysis (8–10 AM by weekday)
- **Heatmap-ready** view: trips by weekday × pickup hour

---

## 📁 Project Files

| File                        | Purpose                             |
|-----------------------------|-------------------------------------|
| `table.sql`                | Fact table + index creation         |
| `Dimension tables.sql`     | All 3 dimension tables              |
| `Indexing.sql`             | Indexes for optimization            |
| `SQL queries and views.sql`| All key queries & views             |
| `insights.sql`             | Bonus KPIs + deep insights          |
| `README.md`                | Documentation (this file)           |

---

## 🚀 How to Use

1. Clone repo
2. Import all `.sql` files into MySQL
3. Query views or export to Power BI / Tableau for dashboards
4. Extend: Add more dimensions or dashboard layers if needed

---

## 👤 Author

Built by Hima Sameera Munjampally — data analyst with real-world SQL problem-solving ability on high-volume datasets.

---
