from models.locations import Locations
from db import Session

def insert_location(name, total_spaces):
    session = Session()
    try:
        row = session.query(Locations).filter(Locations.name == name).first()
        if row is None:
            location = Locations(name=name, total_spaces=total_spaces)
            session.add(location)
            session.commit()
            print(f"Inserted location: {location.id}")
        else:
            print(f"Inserted location {name} already")
    except Exception as e:
        session.rollback()
        print(f"Error inserting location: {e}")
    finally:
        session.close()

def get_location_all():
    session = Session()
    try:
        location = session.query(Locations).all()
        return location
    except Exception as e:
        print(f"Error fetching location: {e}")
        return None
    finally:
        session.close()