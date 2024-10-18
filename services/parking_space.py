from sqlalchemy import func
from models.parking_spaces import ParkingSpaces
from db import Session
import random

def insert_parking_space(location_id, number_spaces, license_plate, status):
    session = Session()
    row = session.query(ParkingSpaces).filter(ParkingSpaces.location_id == location_id, ParkingSpaces.number_spaces == number_spaces).first()
    if row is None:
        parking_space = ParkingSpaces(location_id=location_id, number_spaces=number_spaces, license_plate=license_plate, status=status)
        session.add(parking_space)
        session.commit()
        print(f"Inserted ParkingSpaces: {parking_space.id}")
    else:
        print(f"Inserted ParkingSpaces already")
    session.close()
    
def get_parking_space_location_id(location_id):
    with Session() as session:
        rows = session.query(ParkingSpaces).filter(ParkingSpaces.location_id==location_id).all()
        parked_count = session.query(
            func.count(ParkingSpaces.id).label('parked_count')
        ).filter(
            ParkingSpaces.status == "not vacant",
            ParkingSpaces.location_id == location_id
        ).scalar()

        print(parked_count)
        return rows , parked_count
    
def get_parking_space_vacant_id(id):
    session = Session()
    row = session.query(ParkingSpaces).filter(
            ParkingSpaces.id == id, 
            ParkingSpaces.status == "vacant"  
        ).first()        
    session.close()
    return row

def check_car_on_parking_space(location_id, license_plate):
    session = Session()
    row = session.query(ParkingSpaces).filter(
        ParkingSpaces.location_id == location_id,
        ParkingSpaces.license_plate == license_plate
    ).first()    
    return row
        
def get_parking_space_vacant_random(data):
    session = Session()
    rows = session.query(ParkingSpaces).filter(
            ParkingSpaces.location_id == data['location_id'], 
            ParkingSpaces.status == "vacant"  
        ).all()
    random_parking_space = random.choice(rows)        
    session.close()
    return random_parking_space

def update_status_parking_space(parking_space_id, license_plate, status):
    session = Session()
    session.query(ParkingSpaces).filter(ParkingSpaces.id == parking_space_id).update({
        ParkingSpaces.license_plate: license_plate,
        ParkingSpaces.status: status
    })
    session.commit()
    session.close()
    