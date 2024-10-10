DROP DATABASE IF EXISTS  `jisdashboard_db`;
CREATE DATABASE `jisdashboard_db`;
USE `jisdashboard_db`;

-- 1. Students Table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    date_of_birth DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. Teachers Table
CREATE TABLE Teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    hire_date DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Subjects Table
CREATE TABLE Subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 4. Classes Table
CREATE TABLE Classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    subject_id INT,
    teacher_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- 5. Class_Student Table (Many-to-Many relationship between Classes and Students)
CREATE TABLE Class_Student (
    class_student_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    student_id INT,
    enrollment_date DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- 6. Class_Teacher Table (Many-to-Many relationship between Classes and Teachers)
CREATE TABLE Class_Teacher (
    class_teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    teacher_id INT,
    subject_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- 7. Student_Grades Table (Grades for each student in each subject)
CREATE TABLE Student_Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    grade VARCHAR(5) NOT NULL,  -- For example, A, B, C, D, F
    grade_date DATE,  -- Date when the grade was assigned
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- 1. Insert Sample Data into Students Table
INSERT INTO Students (first_name, last_name, email, date_of_birth)
VALUES 
('John', 'Doe', 'john.doe@example.com', '2005-05-15'),
('Jane', 'Smith', 'jane.smith@example.com', '2006-07-22'),
('Emily', 'Johnson', 'emily.johnson@example.com', '2005-11-10');

-- 2. Insert Sample Data into Teachers Table
INSERT INTO Teachers (first_name, last_name, email, hire_date)
VALUES 
('Alice', 'Brown', 'alice.brown@example.com', '2015-09-01'),
('Robert', 'Davis', 'robert.davis@example.com', '2018-03-15');

-- 3. Insert Sample Data into Subjects Table
INSERT INTO Subjects (subject_name, description)
VALUES 
('Mathematics', 'Study of numbers, shapes, and patterns.'),
('English', 'Study of language, literature, and composition.'),
('Science', 'Study of the natural world through observation and experiments.');

-- 4. Insert Sample Data into Classes Table
INSERT INTO Classes (class_name, subject_id, teacher_id)
VALUES 
('Math 101', 1, 1),  -- Mathematics taught by Alice Brown
('English 101', 2, 2), -- English taught by Robert Davis
('Science 101', 3, 1); -- Science taught by Alice Brown

-- 5. Insert Sample Data into Class_Student Table
INSERT INTO Class_Student (class_id, student_id, enrollment_date)
VALUES 
(1, 1, '2023-09-01'),  -- John Doe enrolled in Math 101
(1, 2, '2023-09-01'),  -- Jane Smith enrolled in Math 101
(2, 2, '2023-09-01'),  -- Jane Smith enrolled in English 101
(2, 3, '2023-09-01'),  -- Emily Johnson enrolled in English 101
(3, 1, '2023-09-01'),  -- John Doe enrolled in Science 101
(3, 3, '2023-09-01');  -- Emily Johnson enrolled in Science 101

-- 6. Insert Sample Data into Class_Teacher Table
INSERT INTO Class_Teacher (class_id, teacher_id, subject_id)
VALUES 
(1, 1, 1),  -- Alice Brown teaches Math 101 (Mathematics)
(2, 2, 2),  -- Robert Davis teaches English 101 (English)
(3, 1, 3);  -- Alice Brown teaches Science 101 (Science)

-- 7. Insert Sample Data into Student_Grades Table
INSERT INTO Student_Grades (student_id, subject_id, grade, grade_date)
VALUES 
(1, 1, 'A', '2023-12-15'),  -- John Doe received an A in Mathematics
(2, 1, 'B+', '2023-12-15'), -- Jane Smith received a B+ in Mathematics
(2, 2, 'A-', '2023-12-15'), -- Jane Smith received an A- in English
(3, 2, 'B', '2023-12-15'),  -- Emily Johnson received a B in English
(1, 3, 'B+', '2023-12-15'), -- John Doe received a B+ in Science
(3, 3, 'A', '2023-12-15');  -- Emily Johnson received an A in Science