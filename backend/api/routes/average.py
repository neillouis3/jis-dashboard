import mysql.connector
from flask import Blueprint, jsonify, request


# Create a blueprint for the movie routes


# Function to connect to the database
def get_db_connection():
    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password="nL08172003!",  # Replace with your MySQL password
        database="jisdashboard_db"
    )
    return connection

# Function to get the average grade for a specific class
def get_class_average(class_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    query = """
    SELECT AVG(CASE 
                 WHEN grade = 'A' THEN 4.0
                 WHEN grade = 'A-' THEN 3.7
                 WHEN grade = 'B+' THEN 3.3
                 WHEN grade = 'B' THEN 3.0
                 WHEN grade = 'B-' THEN 2.7
                 WHEN grade = 'C+' THEN 2.3
                 WHEN grade = 'C' THEN 2.0
                 WHEN grade = 'C-' THEN 1.7
                 WHEN grade = 'D' THEN 1.0
                 WHEN grade = 'F' THEN 0.0
                 ELSE NULL 
               END) AS class_average
    FROM Student_Grades
    INNER JOIN Class_Student ON Student_Grades.student_id = Class_Student.student_id
    WHERE Class_Student.class_id = %s
    """
    
    cursor.execute(query, (class_id,))
    result = cursor.fetchone()
    class_average = result[0] if result[0] is not None else 0
    conn.close()
    
    return class_average

# Function to get the average grade for a specific teacher's students across all their classes
def get_teacher_student_average(teacher_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    query = """
    SELECT AVG(CASE 
                 WHEN grade = 'A' THEN 4.0
                 WHEN grade = 'A-' THEN 3.7
                 WHEN grade = 'B+' THEN 3.3
                 WHEN grade = 'B' THEN 3.0
                 WHEN grade = 'B-' THEN 2.7
                 WHEN grade = 'C+' THEN 2.3
                 WHEN grade = 'C' THEN 2.0
                 WHEN grade = 'C-' THEN 1.7
                 WHEN grade = 'D' THEN 1.0
                 WHEN grade = 'F' THEN 0.0
                 ELSE NULL 
               END) AS student_average
    FROM Student_Grades
    INNER JOIN Class_Student ON Student_Grades.student_id = Class_Student.student_id
    INNER JOIN Class_Teacher ON Class_Student.class_id = Class_Teacher.class_id
    WHERE Class_Teacher.teacher_id = %s
    """
    
    cursor.execute(query, (teacher_id,))
    result = cursor.fetchone()
    student_average = result[0] if result[0] is not None else 0
    conn.close()
    
    return student_average

# Example usage:
if __name__ == "__main__":
    class_id = 1  # Example class ID
    teacher_id = 1  # Example teacher ID
    
    class_avg = get_class_average(class_id)
    teacher_avg = get_teacher_student_average(teacher_id)
    
    print(f"Class {class_id} Average Grade: {class_avg:.2f}")
    print(f"Teacher {teacher_id} Student Average Grade: {teacher_avg:.2f}")
