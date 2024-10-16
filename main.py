from flask import Flask
from models.locations_model import LocationsModel
from models.spots_model import SpotsModel
from models.transactions_model import TransactionsModel
from controllers.item_controller import register_routes

app = Flask(__name__)
LocationsModel.create_table()
SpotsModel.create_table()
TransactionsModel.create_table()

json_array = '''
[
    {"name": "Parking 1", "total_spots": 150},
    {"name": "Parking 2", "total_spots": 100},
    {"name": "Parking 3", "total_spots": 90},
    {"name": "Parking 4", "total_spots": 150},
    {"name": "Parking 5", "total_spots": 60},
    {"name": "Parking 6", "total_spots": 40},
    {"name": "Parking 7", "total_spots": 120},
    {"name": "Parking 8", "total_spots": 140},
    {"name": "Parking 9", "total_spots": 110},
    {"name": "Parking 10", "total_spots": 80}
]
'''

LocationsModel.save_multiple_from_json(json_array)

register_routes(app)

if __name__ == '__main__':
     app.run(debug=True, use_reloader=False)