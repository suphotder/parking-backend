from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from models.users import Base as UsersBase
from models.locations import Base as LocationsBase
from models.parking_spaces import Base as ParkingSpaces
from models.transactions import Base as Transactions

POSTGRES_USER = 'Note'
POSTGRES_PASSWORD = 'Love1234'
POSTGRES_DB = 'ParkingDB'
POSTGRES_HOST = 'localhost'

DATABASE_URL = f"postgresql+psycopg2://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}/{POSTGRES_DB}"
engine = create_engine(DATABASE_URL)
# UsersBase.metadata.create_all(engine)
LocationsBase.metadata.create_all(engine)
ParkingSpaces.metadata.create_all(engine)
Transactions.metadata.create_all(engine)
Session = sessionmaker(bind=engine)

def check_connection():
    try:
        connection = engine.connect()
        print("Connection to PostgreSQL was successful!")
        connection.close()
    except Exception as e:
        print("Error occurred while connecting to PostgreSQL:", e)