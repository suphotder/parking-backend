# models.py
from db import get_connection
import json

class LocationsModel:
    _has_saved = False
    def __init__(self, name, total_spots):
        self.name = name
        self.total_spots = total_spots
    
    @classmethod
    def create_table(cls):
        print("create_table")
        conn = get_connection()
        if conn:
            cur = conn.cursor()
            cur.execute("""
            CREATE TABLE IF NOT EXISTS locations (
                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                name VARCHAR(100),
                total_spots INTEGER
            )
            """)
            conn.commit()
            cur.close()
            conn.close()
            
    @classmethod
    def save(cls, item):
        conn = get_connection()
        if conn:
            cur = conn.cursor()
            cur.execute("""
            INSERT INTO locations (name, total_spots) VALUES (%s, %s)
            """, (item.name, item.total_spots))
            conn.commit()
            cur.close()
            conn.close()
    
     
    @classmethod
    def save_multiple_from_json(cls, json_data):
        try:
            locations = json.loads(json_data)
            conn = get_connection()
            if conn:
                try:
                    cur = conn.cursor()
                    for loc in locations:
                        # ตรวจสอบว่ามีข้อมูลอยู่ในฐานข้อมูลแล้วหรือไม่
                        cur.execute("SELECT COUNT(*) FROM locations WHERE name = %s", (loc['name'],))
                        count = cur.fetchone()[0]
                        
                        if count == 0:  # ถ้าไม่มีข้อมูลซ้ำ
                            cur.execute("""
                            INSERT INTO locations (name, total_spots) VALUES (%s, %s)
                            """, (loc['name'], loc['total_spots']))
                            print(f"Inserted: {loc['name']}")
                        else:
                            print(f"Location already exists: {loc['name']}")
                    
                    conn.commit()
                except Exception as e:
                    print(f"Error saving multiple locations from JSON: {e}")
                finally:
                    cur.close()
                    conn.close()
        except json.JSONDecodeError as e:
            print(f"Error decoding JSON: {e}")