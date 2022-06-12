import os
from flask import Flask, render_template, request
import mysql.connector
from mysql.connector import errorcode

app = Flask(__name__, template_folder="templates")

env = os.environ['environment']

config = {
    'host': 'db01-mysqlserver-' +
    env + ".mysql.database.azure.com",
    'user': 'mysqladminun@db01-mysqlserver-' + env,
    'password': 'H@Sh1CoR3!',
    'database': 'db01',  # + env,
    'client_flags': [mysql.connector.ClientFlag.SSL]
}

# Creating a connection cursor
# cursor = mysql.connection.cursor()
conn = mysql.connector.connect(**config)
cursor = conn.cursor()
# Executing SQL Statements
# cursor.execute(''' CREATE TABLE table_name(field1, field2...) ''')
# cursor.execute(''' INSERT INTO table_name VALUES(v1,v2...) ''')
# cursor.execute(''' DELETE FROM table_name WHERE condition ''')
cursor.execute("DROP TABLE IF EXISTS inventory;")
cursor.execute(
    "CREATE TABLE IF NOT EXISTS inventory( name VARCHAR(50), age INTEGER)")

# Saving the Actions performed on the DBmysql = MySQL(app)


@app.route('/form')
def form():
    return render_template('./form.html')


@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'GET':
        return "Login via the login Form"

    if request.method == 'POST':
        name = request.form['name']
        age = request.form['age']
        cursor = conn.cursor()

        cursor.execute(
            "INSERT INTO inventory (name, age) VALUES (%s, %s);", (name, age))
        conn.commit()
        cursor.close()
        # cursor.execute(
        #     f"INSERT INTO inventory (name, age) VALUES ({name},{age});")
        cursor = conn.cursor()
        rows = cursor.execute("SELECT * FROM inventory")
        # print(cursor.fetchall())

        # conn.close()
        return str(cursor.fetchall())


app.run(host='localhost', port=5000)
