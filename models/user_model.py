# models.py
from db import get_connection

class UserModel:
    def __init__(self, name, email):
        self.name = name
        self.email = email

    @classmethod
    def create_table(cls):
        conn = get_connection()
        if conn:
            cur = conn.cursor()
            cur.execute("""
            CREATE TABLE IF NOT EXISTS users (
                id SERIAL PRIMARY KEY,
                name VARCHAR(100),
                email VARCHAR(100) UNIQUE NOT NULL
            )
            """)
            conn.commit()
            cur.close()
            conn.close()

    @classmethod
    def save(cls, user):
        conn = get_connection()
        if conn:
            cur = conn.cursor()
            cur.execute("""
            INSERT INTO users (name, email) VALUES (%s, %s)
            """, (user.name, user.email))
            conn.commit()
            cur.close()
            conn.close()

    @classmethod
    def get_all(cls):
        conn = get_connection()
        users = []
        if conn:
            cur = conn.cursor()
            cur.execute("SELECT * FROM users")
            rows = cur.fetchall()
            for row in rows:
                users.append({'id': row[0], 'name': row[1], 'email': row[2]})
            cur.close()
            conn.close()
        return users
