from sqlalchemy import Column, String, DateTime, ForeignKey, Integer
from sqlalchemy.orm import relationship
from models import Base 
import uuid

class Transactions(Base):
    __tablename__ = 'transactions'
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    parking_spaces_id = Column(String(36), ForeignKey('parking_spaces.id'), nullable=False)
    on_time = Column(DateTime)
    out_time = Column(DateTime)
    license_plate = Column(String(100))
    amount = Column(Integer)
    payment_status = Column(String(50))
    
    relationship("ParkingSpaces", back_populates="transactions")
    
    def to_dict(self):
        return {
            'id': self.id,
            'parking_spaces_id': self.parking_spaces_id,
            'on_time': self.on_time.isoformat() if self.on_time else None,
            'out_time': self.out_time.isoformat() if self.out_time else None,
            'license_plate': self.license_plate,
            "amount": self.amount,
            "payment_status": self.payment_status
        }