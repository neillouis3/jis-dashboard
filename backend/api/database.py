import mysql.connector

def get_db_connection():
    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password="nL08172003!",  # Replace with your MySQL password
        database="jisdashboard_db"
    )
    return connection
