from sqlalchemy import Column, String, Date, ForeignKey
from sqlalchemy.orm import relationship
from models import Base 
import uuid

class Transactions(Base):
    __tablename__ = 'transactions'
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    parking_spaces_id = Column(String(36), ForeignKey('parking_spaces.id'), nullable=False)
    entry_time = Column(Date, nullable=False)
    exit_time = Column(Date, nullable=False)
    license_plate = Column(String(50), nullable=False)
    
    relationship("ParkingSpaces", back_populates="transactions")