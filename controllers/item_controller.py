# controllers/item_controller.py
from flask import jsonify, request
from services.item_service import get_all_items

def register_routes(app):
    @app.route('/items', methods=['GET'])
    def get_items():
        items = get_all_items()
        return jsonify(items)