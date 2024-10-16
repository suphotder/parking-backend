import psycopg2
from psycopg2 import sql

def get_connection():
    try:
        conn = psycopg2.connect(
            host="localhost",
            port="5432",
            database="ParkingDB",
            user="Note",
            password="Love1234"
        )
        return conn
    except Exception as e:
        print(f"Error connecting to the database: {e}")
        return None