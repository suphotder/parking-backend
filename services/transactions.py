from models.transactions import Transactions
from models.response import Response
from services.parking_space import update_status_parking_space, check_car_on_parking_space, get_parking_space_vacant_random, check_car_on_parking_space_all
from db import Session
from datetime import datetime
import pytz


def insert_transaction(data):
    session = Session()
    bangkok_tz = pytz.timezone('Asia/Bangkok')
    current_datetime_with_tz = datetime.now(bangkok_tz)
    iso_format = current_datetime_with_tz.isoformat()
    location_id = data['location_id']
    license_plate = data['license_plate']
    if data['type'] == "on":
        if is_car_on_parking_space_all(license_plate) == False:
            try:
                parking_space = get_parking_space_vacant_random(data)
                transaction = Transactions(parking_spaces_id=parking_space.id, license_plate=license_plate, on_time=iso_format, payment_status="unpaid")
                session.add(transaction)
                session.commit()
                update_status_parking_space(parking_space.id, license_plate, "not vacant")
                return Response(status=200, message="Success.", data=transaction.to_dict())
            finally:
                session.close()
        else:
            return Response(status=500, message="This license plate already exists.")
    elif data['type'] == "out":
        if is_car_on_parking_space(location_id, license_plate):
            try:
                transaction_id = data['transaction_id']
                parking_space = check_car_on_parking_space(location_id, license_plate)
                if get_transaction_unpaid(transaction_id) is None:
                    return Response(status=500, message="Invalid transaction number.")
                session.query(Transactions).filter(Transactions.id == transaction_id).update({
                    Transactions.payment_status: "paid"
                })
                session.commit()
                transaction = get_transaction_id(transaction_id)
                update_status_parking_space(parking_space.id, None, "vacant")
                return Response(status=200, message="Success.", data=transaction.to_dict())
            finally:
                session.close()
        else:
            return Response(status=500, message="This license plate does not exist.")
    else:
        return Response(status=500, message="This transaction is not available.")
    
def get_transaction_service_fee(location_id, license_plate):
    try:
        session = Session()
        bangkok_tz = pytz.timezone('Asia/Bangkok')
        current_datetime_with_tz = datetime.now(bangkok_tz)
        iso_format = current_datetime_with_tz.isoformat()
        parking_space = check_car_on_parking_space(location_id, license_plate)
        transaction = get_transaction_out_time(parking_space.id, license_plate)
        if transaction.out_time == None:
            now = datetime.now() 
            elapsed_time = now - transaction.on_time
            minutes_elapsed = elapsed_time.total_seconds() / 60
            session.query(Transactions).filter(Transactions.id == transaction.id,Transactions.out_time == None).update({
                Transactions.out_time: iso_format,
                Transactions.amount: minutes_elapsed
            })
            session.commit()
        transaction = get_transaction_id(transaction.id)
        return Response(status=200, message="Success.", data=transaction.to_dict())
    finally:
        session.close()
        
def get_transaction_unpaid(transaction_id):
    with Session() as session:
        row = session.query(Transactions).filter(
                Transactions.id == transaction_id,
                Transactions.payment_status == "unpaid"
            ).first()        
        return row
    
def get_transaction_out_time(parking_spaces_id, license_plate):
    with Session() as session:
        row = session.query(Transactions).filter(
                Transactions.parking_spaces_id == parking_spaces_id,
                Transactions.license_plate == license_plate
            ).first()        
        return row

def get_transaction_id(id):
    with Session() as session:
        row = session.query(Transactions).filter(
                Transactions.id==id 
            ).first()        
        return row
        
def is_car_on_parking_space(location_id, license_plate):
    row = check_car_on_parking_space(location_id, license_plate)
    if row is None:
        return False
    else:
        return True
    
def is_car_on_parking_space_all(license_plate):
    rows = check_car_on_parking_space_all(license_plate)
    if not rows:
        print("False")
        return False
    else:
        print("True")
        return True
        