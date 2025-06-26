import pandas as pd
import mysql.connector
from sqlalchemy import create_engine

# Load the cleaned CSV
df = pd.read_csv("combined_cleaned_yellow_tripdata_Q1_2024.csv")

# Create SQLAlchemy connection string
user = "root"
password = "Mysql"
host = "localhost"
database = "nyc_taxi_data"

engine = create_engine(f"mysql+mysqlconnector://{user}:{password}@{host}/{database}", echo=False)

# Load into MySQL
df.to_sql(name='yellow_tripdata_q1_2024', con=engine, if_exists='replace', index=False, chunksize=50000)

print("✅ Data uploaded to MySQL!")
