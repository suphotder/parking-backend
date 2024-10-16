from sqlalchemy import Column, String, Integer
from sqlalchemy.ext.declarative import declarative_base
import uuid

Base = declarative_base()
class Users(Base):
    __tablename__ = 'users'
    id = Column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    name = Column(String(50), nullable=False)
    age = Column(Integer, nullable=False)
    # def __repr__(self):
    #     return f"<User(name={self.name}, age={self.age})>"