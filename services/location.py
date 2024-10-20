from models.locations import Locations
from db import Session

def insert_location(name, total_spaces):
    with Session() as session:
        row = session.query(Locations).filter(Locations.name == name).first()
        if row is None:
            location = Locations(name=name, total_spaces=total_spaces)
            session.add(location)
            session.commit()
            print(f"Inserted location: {location.id}")
        else:
            print(f"Inserted location {name} already")

def get_location_all():
    with Session() as session:
        location = session.query(Locations).all()
        return location
        