# 🎓 Student Performance Database & Analytics Dashboard

## 🚀 Project Overview
This project is a real-world SQL-based Student Performance Analytics System designed to track, analyze, and visualize academic performance, attendance, and course outcomes.

It simulates how **schools, colleges, and EdTech companies** use data to monitor student progress and improve academic decision-making.

## 🎯 Objective
- Design a relational database for academic data
- Track student performance, attendance, and feedback
- Analyze academic trends using SQL queries
- Identify top performers and at-risk students
- Generate actionable insights for institutions

## 🛠️ Tools Used
- SQL Server / PostgreSQL
- SQL (Joins, Aggregations, Window Functions)
- GitHub for version control
- Optional: Power BI / Excel (for visualization)

## 🧱 Database Schema

### 📌 Tables Created:
- Students
- Courses
- Instructors
- Enrollments
- Attendance
- Assessments
- Marks
- Feedback

## 🔗 Relationships
- Students → Enrollments (1:M)
- Courses → Enrollments (1:M)
- Enrollments → Marks (1:M)
- Enrollments → Attendance (1:M)
- Courses → Assessments (1:M)

## 📊 Key SQL Features Used
- INNER JOIN / LEFT JOIN
- GROUP BY & HAVING
- Aggregate Functions (AVG, SUM, COUNT)
- CASE Statements
- Window Functions (RANK, DENSE_RANK)
- Subqueries

## 📈 Key Insights Generated

✔ Top performing students  
✔ Low performing students  
✔ Attendance vs performance correlation  
✔ Course-wise performance analysis  
✔ At-risk student identification  
✔ Instructor/course effectiveness  

## 🚨 At-Risk Student Logic
Students are flagged as at-risk if:
- Attendance < 70%
- OR Average marks < 50%

## 🏆 Sample Analytics Queries
- Student ranking based on performance
- Course-wise average marks
- Attendance summary
- Pass/Fail classification
- Performance categorization (High / Medium / Low)
