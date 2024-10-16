from flask import jsonify, request

def register_routes(app):
    @app.route('/items', methods=['GET'])
    def get_items():
        return jsonify({"mesage":"hello"})