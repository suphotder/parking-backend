from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import relationship
from models import Base 
import uuid

class Locations(Base):
    __tablename__ = 'locations'
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    name = Column(String(50), nullable=False)
    total_spaces = Column(Integer, nullable=False)
    
    relationship("ParkingSpaces", back_populates="locations", cascade="all, delete-orphan")
    
    
    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "total_spaces": self.total_spaces
        }