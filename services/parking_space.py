from sqlalchemy import func
from models.parking_spaces import ParkingSpaces
from db import Session
import random

def insert_parking_space(location_id, number_spaces, license_plate, status):
    with Session() as session:
        row = session.query(ParkingSpaces).filter(ParkingSpaces.location_id == location_id, ParkingSpaces.number_spaces == number_spaces).first()
        if row is None:
            parking_space = ParkingSpaces(location_id=location_id, number_spaces=number_spaces, license_plate=license_plate, status=status)
            session.add(parking_space)
            session.commit()
            print(f"Inserted ParkingSpaces: {parking_space.id}")
        else:
            print(f"Inserted ParkingSpaces already")
    
def get_parking_space_location_id(location_id):
    with Session() as session:
        rows = session.query(ParkingSpaces).filter(ParkingSpaces.location_id==location_id).order_by(ParkingSpaces.number_spaces).all()
        parked_count = session.query(
            func.count(ParkingSpaces.id).label('parked_count')
        ).filter(
            ParkingSpaces.status == "not vacant",
            ParkingSpaces.location_id == location_id
        ).scalar()
        return rows , parked_count
    
def get_parking_space_vacant_id(id):
    with Session() as session:
        row = session.query(ParkingSpaces).filter(
                ParkingSpaces.id == id, 
                ParkingSpaces.status == "vacant"  
            ).first()
        return row

def check_car_on_parking_space(location_id, license_plate):
    with Session() as session:
        row = session.query(ParkingSpaces).filter(
            ParkingSpaces.location_id == location_id,
            ParkingSpaces.license_plate == license_plate
        ).first()    
        return row

def check_car_on_parking_space_all(license_plate):
    with Session() as session:
        row = session.query(ParkingSpaces).filter(
            ParkingSpaces.license_plate == license_plate
        ).all()    
        return row
        
def get_parking_space_vacant_random(data):
    with Session() as session:
        rows = session.query(ParkingSpaces).filter(
                ParkingSpaces.location_id == data['location_id'], 
                ParkingSpaces.status == "vacant"  
            ).all()
        if rows:
            random_parking_space = random.choice(rows)
            return random_parking_space
        else:
            return None

def update_status_parking_space(parking_space_id, license_plate, status):
    with Session() as session:
        session.query(ParkingSpaces).filter(ParkingSpaces.id == parking_space_id).update({
            ParkingSpaces.license_plate: license_plate,
            ParkingSpaces.status: status
        })
        session.commit()
    