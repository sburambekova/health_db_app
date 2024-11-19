import psycopg2
from psycopg2 import OperationalError

connection_string = "postgresql://health_reporting_db_user:dgh22mH4EbUWMEjwxWbCN7woDHywIuIo@dpg-cstnvd5umphs73frp4e0-a.oregon-postgres.render.com/health_reporting_db?sslmode=require"

try:
    conn = psycopg2.connect(connection_string)
    print("Connection successful!")
except OperationalError as e:
    print(f"Error: {e}")
finally:
    if conn:
        conn.close()
