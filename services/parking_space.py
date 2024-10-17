from models.parking_spaces import ParkingSpaces
from db import Session

def insert_parking_space(location_id, number_spaces, license_plate, status):
    session = Session()
    try:
        row = session.query(ParkingSpaces).filter(ParkingSpaces.location_id == location_id, ParkingSpaces.number_spaces == number_spaces).first()
        if row is None:
            parkingSpace = ParkingSpaces(location_id=location_id, number_spaces=number_spaces, license_plate=license_plate, status=status)
            session.add(parkingSpace)
            session.commit()
            print(f"Inserted ParkingSpaces: {parkingSpace.id}")
        else:
            print(f"Inserted ParkingSpaces already")
    except Exception as e:
        session.rollback()
        print(f"Error inserting location: {e}")
    finally:
        session.close()