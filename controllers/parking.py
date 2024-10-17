from flask import jsonify, request
from services.location import get_location_all
from services.transactions import insert_transaction
from services.parking_space import get_parking_space_vacant_random

def register_parking_routes(app):
    @app.route('/parking/transaction', methods=['POST'])
    def parking_services():
        try:
            data = request.json
            res = insert_transaction(data)
            if res.status == 200:
                return  jsonify(res.data)
            else:
               return jsonify({"error": res.message}), res.status
        except Exception as e:
            return jsonify({"error": str(e)}), 500

    @app.route('/parking/location', methods=['GET'])
    def location_all():
        try:
            locations = get_location_all()
            res = [location.to_dict() for location in locations]
            return jsonify(res)
        except Exception as e:
            return jsonify({"error": str(e)}), 500
    