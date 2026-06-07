from flask import Flask, jsonify, request
import os
import psycopg2

db_host = os.environ ["DB_HOST"]
db_name = os.environ ["DB_NAME"]
db_user = os.environ ["DB_USER"]
db_password = os.environ ["DB_PASSWORD"]
db_port =  os.environ ["DB_PORT"]

connection = psycopg2.connect(
    host = db_host,
    database = db_name,
    user = db_user,
    password = db_password ,
    port = db_port,
)

cursor = connection.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS users (
id SERIAL PRIMARY KEY,
    username VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100)
);               
""");

connection.commit()


app = Flask(__name__)
@app.route('/users/', methods=['GET', 'POST'])
def home():
    cursor = connection.cursor()
    
    if request.method == 'POST':
        data = request.get_json()
        cursor.execute(
            "INSERT INTO users (username, email, password) VALUES (%s, %s, %s)",
            (data["username"], data["email"], data["password"])
        )
        connection.commit()
    cursor.execute("SELECT username, email, password FROM users")
    rows = cursor.fetchall()
    users_from_db = []

    for row in rows:
        users_from_db.append({
            "username": row[0],
            "email": row[1],
            "password": row[2]
        })

    return jsonify(users_from_db)



user1 = {"username": "barak",
         "email": "barak@test.com",
         "password": "secret"}

user2 = {"username": "dana",
         "email": "dana@test.com",
         "password": "secret"}

user3 = {"username": "avi",
         "email": "avi@test.com",
         "password": "123"}  

users = [user1, user2, user3]

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0',port=5000)

#print(users[0]["username"])