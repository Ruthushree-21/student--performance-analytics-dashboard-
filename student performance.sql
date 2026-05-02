CREATE DATABASE student_performanceand_analytics_dashboard;
USE student_performanceand_analytics_dashboard;
DROP TABLE IF EXISTS Feedback;
DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Assessments;
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Instructors;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
    student_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    gender VARCHAR(10),
    admission_year INT
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY IDENTITY(1,1),
    course_name VARCHAR(100)
);

CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100)
);

CREATE TABLE Enrollments (
    enroll_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Attendance (
    att_id INT PRIMARY KEY IDENTITY(1,1),
    enroll_id INT,
    attendance_percentage FLOAT,
    FOREIGN KEY (enroll_id) REFERENCES Enrollments(enroll_id)
);

CREATE TABLE Assessments (
    assessment_id INT PRIMARY KEY IDENTITY(1,1),
    course_id INT,
    assessment_type VARCHAR(50)
);

CREATE TABLE Marks (
    mark_id INT PRIMARY KEY IDENTITY(1,1),
    enroll_id INT,
    assessment_id INT,
    score FLOAT,
    FOREIGN KEY (enroll_id) REFERENCES Enrollments(enroll_id),
    FOREIGN KEY (assessment_id) REFERENCES Assessments(assessment_id)
);

CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT,
    course_id INT,
    rating INT,
    comments VARCHAR(255)
);
INSERT INTO Students (name,email,gender,admission_year) VALUES
('Riya Sharma','riya@gmail.com','F',2023),
('Arjun Patel','arjun@gmail.com','M',2022),
('Neha Khan','neha@gmail.com','F',2023),
('Rahul Das','rahul@gmail.com','M',2021),
('Sneha Reddy','sneha@gmail.com','F',2022);

INSERT INTO Courses (course_name) VALUES
('SQL Basics'),('Data Analytics'),('Python'),('Statistics');

INSERT INTO Instructors (name) VALUES
('Umesh Yadav'),('Rahul Mehta'),('Anita Sharma');

INSERT INTO Enrollments (student_id,course_id) VALUES
(1,1),(2,1),(3,2),(4,3),(5,4),(1,2),(2,3);

INSERT INTO Attendance (enroll_id,attendance_percentage) VALUES
(1,85),(2,60),(3,90),(4,75),(5,50),(6,95),(7,65);

INSERT INTO Assessments (course_id,assessment_type) VALUES
(1,'Assignment'),(1,'Exam'),
(2,'Project'),
(3,'Assignment'),
(4,'Final');

INSERT INTO Marks (enroll_id,assessment_id,score) VALUES
(1,1,80),(1,2,75),
(2,1,40),(2,2,50),
(3,3,88),
(4,4,70),
(5,5,45),
(6,3,92),
(7,4,60);

INSERT INTO Feedback (student_id,course_id,rating,comments) VALUES
(1,1,5,'Excellent'),
(2,1,3,'Average'),
(3,2,4,'Good'),
(4,3,2,'Needs Improvement');
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Marks;
SELECT s.name, AVG(m.score) AS avg_score
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY s.name
ORDER BY avg_score DESC;
SELECT s.name, AVG(m.score) avg_score
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY s.name
HAVING AVG(m.score) < 50;
SELECT s.name, a.attendance_percentage, AVG(m.score) avg_score
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Attendance a ON e.enroll_id = a.enroll_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY s.name, a.attendance_percentage
HAVING a.attendance_percentage < 70 OR AVG(m.score) < 50;
SELECT s.name,
AVG(m.score) avg_score,
RANK() OVER (ORDER BY AVG(m.score) DESC) AS rank
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY s.name;
SELECT 
    s.name,
    AVG(m.score) AS avg_score,
    RANK() OVER (ORDER BY AVG(m.score) DESC) AS rank_position
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY s.name;
SELECT 
    s.name,
    AVG(m.score) AS avg_score,
    CASE 
        WHEN AVG(m.score) >= 75 THEN 'High Performer'
        WHEN AVG(m.score) >= 50 THEN 'Medium Performer'
        ELSE 'Low Performer'
    END AS performance_category
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY s.name;
SELECT 
    c.course_name,
    AVG(m.score) AS avg_score
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY c.course_name;
SELECT 
    s.name,
    a.attendance_percentage,
    AVG(m.score) AS avg_score
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Attendance a ON e.enroll_id = a.enroll_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY s.name, a.attendance_percentage;
SELECT 
    s.name,
    AVG(m.score) AS avg_score,
    CASE 
        WHEN AVG(m.score) >= 50 THEN 'Pass'
        ELSE 'Fail'
    END AS result
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY s.name;
SELECT TOP 3 
    s.name,
    AVG(m.score) AS avg_score
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY s.name
ORDER BY avg_score DESC;
CREATE VIEW Student_Performance AS
SELECT 
    s.name,
    AVG(m.score) AS avg_score
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Marks m ON e.enroll_id = m.enroll_id
GROUP BY s.name;
CREATE INDEX idx_student ON Enrollments(student_id);