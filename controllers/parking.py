from flask import jsonify, request
from services.location import get_location_all
from services.transactions import insert_transaction, get_transaction_service_fee
from services.parking_space import get_parking_space_vacant_random, get_parking_space_location_id

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
        
    @app.route('/parking/service-fee', methods=['POST'])
    def parking_servie_fee():
        try:
            data = request.get_json()
            location_id = data.get('location_id')
            license_plate = data.get('license_plate')
            res = get_transaction_service_fee(location_id, license_plate)
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
        
    @app.route('/parking/space', methods=['GET'])
    def parking_space_location():
        try:
            location_id = request.args.get('locationId') 
            parking_spaces, parked_count = get_parking_space_location_id(location_id)
            res = [parking_space.to_dict() for parking_space in parking_spaces]
            return jsonify({"data":res, "total":len(res), "parked":parked_count})
        except Exception as e:
            return jsonify({"error": str(e)}), 500
    