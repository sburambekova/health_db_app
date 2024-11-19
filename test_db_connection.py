import psycopg2
import os

# Get the DATABASE_URL from environment variables
DATABASE_URL = os.getenv('DATABASE_URL')

try:
    # Attempt to connect to the database
    conn = psycopg2.connect(DATABASE_URL, sslmode='require')
    print("Connection successful!")
    conn.close()  # Close the connection
except Exception as e:
    print(f"Error: {e}")
