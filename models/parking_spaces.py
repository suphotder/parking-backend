from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import relationship
from models import Base 
import uuid

class ParkingSpaces(Base):
    __tablename__ = 'parking_spaces'
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    location_id = Column(String(36), ForeignKey('locations.id'), nullable=False)
    number_spaces = Column(Integer, nullable=False)
    license_plate = Column(String(50), nullable=False)
    status = Column(String(50), nullable=False)
    locations = relationship("Locations", back_populates="parking_spaces")
    transactions = relationship("Transactions", back_populates="parking_spaces", cascade="all, delete-orphan")