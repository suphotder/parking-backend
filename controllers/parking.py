from flask import jsonify, request
from services.location import get_location_all

def register_parking_routes(app):
    @app.route('/parking/service', methods=['POST'])
    def parking_services():
        return jsonify({"message": "hello"})

    @app.route('/parking/location', methods=['GET'])
    def location_all():
        try:
            locations = get_location_all()
            res = [location.to_dict() for location in locations]
            return jsonify(res)
        except Exception as e:
            return jsonify({"error": str(e)}), 500
    