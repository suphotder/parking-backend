from models.transactions import Transactions
from models.response import Response
from services.parking_space import update_status_parking_space, check_car_on_parking_space, get_parking_space_vacant_random
from db import Session
from datetime import datetime
import pytz


def insert_transaction(data):
    session = Session()
    bangkok_tz = pytz.timezone('Asia/Bangkok')
    current_datetime_with_tz = datetime.now(bangkok_tz)
    iso_format = current_datetime_with_tz.isoformat()
    if data['type'] == "on":
        if is_car_on_parking_space(data['license_plate']) == False:
            try:
                parking_space = get_parking_space_vacant_random(data)
                transaction = Transactions(parking_spaces_id=parking_space.id, license_plate=data['license_plate'], on_time=iso_format)
                session.add(transaction)
                session.commit()
                update_status_parking_space(parking_space.id, data['license_plate'], "not vacant")
                return Response(status=200, message="Success.", data=transaction.to_dict())
            finally:
                session.close()
        else:
            return Response(status=500, message="This license plate is already parked.")
    elif data['type'] == "out":
        if is_car_on_parking_space(data['license_plate']):
            try:
                license_plate = data['license_plate']
                parking_space = check_car_on_parking_space(license_plate)
                transaction = get_transaction_license_plate(parking_space.id, license_plate)
                now = datetime.now() 
                elapsed_time = now - transaction.on_time
                minutes_elapsed = elapsed_time.total_seconds() / 60
                session.query(Transactions).filter(Transactions.parking_spaces_id==parking_space.id, Transactions.license_plate == license_plate).update({
                    Transactions.out_time: iso_format,
                    Transactions.amount: minutes_elapsed
                })
                session.commit()
                transaction = get_transaction_id(transaction.id)
                update_status_parking_space(parking_space.id, None, "vacant")
                return Response(status=200, message="Success.", data=transaction.to_dict())
            finally:
                session.close()
        else:
            return Response(status=500, message="This license plate is not parked.")
    else:
        return Response(status=500, message="This transaction is not available.")
    
def get_transaction_license_plate(parking_spaces_id, license_plate):
    session = Session()
    row = session.query(Transactions).filter(
            Transactions.parking_spaces_id==parking_spaces_id, Transactions.license_plate == license_plate 
        ).first()        
    session.close()
    return row

def get_transaction_id(id):
    session = Session()
    row = session.query(Transactions).filter(
            Transactions.id==id 
        ).first()        
    session.close()
    return row
    
def is_car_on_parking_space(license_plate):
    row = check_car_on_parking_space(license_plate)
    if row is None:
        return False
    else:
        return True
        