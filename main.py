from flask import Flask
from flask_cors import CORS
from db import Session, check_connection
from controllers.parking import register_parking_routes
from services.location import insert_location, get_location_all
from services.parking_space import insert_parking_space

app = Flask(__name__)
CORS(app)

check_connection()

session = Session() 
try:
    insert_location(name="Central Plaza", total_spaces=30)
    insert_location(name="Central Plaza", total_spaces=180)
    insert_location(name="Mega Mall", total_spaces=150)
    insert_location(name="Park View", total_spaces=110)
    insert_location(name="Downtown Garage", total_spaces=90)
    insert_location(name="City Center", total_spaces=80)
    insert_location(name="Sunset Parking", total_spaces=300)
    insert_location(name="Eastside Lot", total_spaces=150)
    insert_location(name="West End Parking", total_spaces=60)
    insert_location(name="North Shore Garage", total_spaces=40)
    insert_location(name="South Street Lot", total_spaces=100)
    locations = get_location_all()
    if locations:
        for item in locations:
            for i in range(item.total_spaces):
                insert_parking_space(location_id=item.id, number_spaces=i+1, license_plate=None, status="vacant")
    else:
        print("No locations found.")
except Exception as e:
    session.rollback()
    print(f"Error: {e}")
finally:
    session.close()

register_parking_routes(app)

if __name__ == '__main__':
    app.run(debug=True, use_reloader=False)