from flask import Flask
from db import Session, check_connection
from controllers.item import register_routes

app = Flask(__name__)

check_connection()

@app.before_request
def before_request():
    app.session = Session() 

@app.teardown_request
def teardown_request(exception):
    app.session.close()  

register_routes(app)

if __name__ == '__main__':
    app.run(debug=True, use_reloader=False)