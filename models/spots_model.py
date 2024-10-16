from db import get_connection

class SpotsModel:
    @classmethod
    def create_table(cls):
        conn = get_connection()
        if conn:
            cur = conn.cursor()
            cur.execute("""
            CREATE TABLE IF NOT EXISTS spots (
                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                location_id UUID,
                spot_number INTEGER,
                status BOOLEAN DEFAULT true,
                vehicle VARCHAR(20),
                FOREIGN KEY (location_id) REFERENCES locations(id)
            )
            """)
            conn.commit()
            cur.close()
            conn.close()
