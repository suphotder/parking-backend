from db import get_connection

class TransactionsModel:
    @classmethod
    def create_table(cls):
        conn = get_connection()
        if conn:
            cur = conn.cursor()
            cur.execute("""
            CREATE TABLE IF NOT EXISTS transactions (
                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                spot_id UUID,
                entry_time DATE,
                exit_time DATE,
                FOREIGN KEY (spot_id) REFERENCES spots(id)
            )
            """)
            conn.commit()
            cur.close()
            conn.close()
