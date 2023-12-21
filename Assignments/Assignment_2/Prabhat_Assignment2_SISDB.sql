--Q1.1 Create the database named "SISDB"
CREATE DATABASE SISDB;

USE SISDB;

/*Q2 Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and 
relationships. 
• Students
• Courses
• Enrollments
• Teacher
• Payments*/
CREATE TABLE Students(
studentID INT PRIMARY KEY,
firstName VARCHAR(50),
lastName VARCHAR(50),
DOB DATE,
email VARCHAR(50),
phoneNumber VARCHAR(20)
);

CREATE TABLE Teacher(
teacherID INT PRIMARY KEY,
firstName VARCHAR(50),
lastName VARCHAR(50),
email VARCHAR(50)
);

CREATE TABLE Courses(
courseID INT PRIMARY KEY,
courseName VARCHAR(255),
credits INT,
teacherID INT,
FOREIGN KEY (teacherID) REFERENCES Teacher(teacherID)ON DELETE CASCADE
);

CREATE TABLE Enrollment(
enrollmentID INT PRIMARY KEY,
studentID INT,
courseID INT,
enrollmentDate Date,
FOREIGN KEY (studentID) REFERENCES Students(studentID) ON DELETE CASCADE,
FOREIGN KEY (courseID) REFERENCES Courses(courseID) ON DELETE CASCADE,
);


CREATE TABLE Payments(
paymentID INT PRIMARY KEY,
studentID INT,
amount DECIMAL(10,2),
paymentDate Date,
FOREIGN KEY (studentID) REFERENCES Students(studentID) ON DELETE CASCADE,
);


--Q3.a Insert at least 10 sample records into each table.
INSERT INTO Students (studentID, firstName, lastName, DOB, email, phoneNumber)
VALUES(1, 'Jane', 'Smith', '1991-08-20', 'jane.smith@example.com', '987-654-3210'),
(2, 'Alice', 'Johnson', '1989-02-10', 'alice.johnson@example.com', '555-123-4567'),
(3, 'Bob', 'Williams', '1995-11-30', 'bob.williams@example.com', '111-222-3333'),
(4, 'Eva', 'Brown', '1993-04-25', 'eva.brown@example.com', '999-888-7777'),
(5, 'Mike', 'Taylor', '1992-07-12', 'mike.taylor@example.com', '444-555-6666'),
(6, 'Sara', 'Miller', '1994-09-18', 'sara.miller@example.com', '777-666-5555'),
(7, 'Chris', 'Davis', '1996-03-05', 'chris.davis@example.com', '222-333-4444'),
(8, 'Emily', 'Clark', '1997-06-22', 'emily.clark@example.com', '888-999-0000'),
(9, 'David', 'Anderson', '1988-12-08', 'david.anderson@example.com', '333-444-5555'),
(10, 'Sophie', 'Moore', '1998-01-17', 'sophie.moore@example.com', '666-777-8888');

INSERT INTO Teacher (teacherID, firstName, lastName, email)
VALUES(1, 'Mark', 'Johnson', 'mark.johnson@example.com'),
(2, 'Emily', 'Smith', 'emily.smith@example.com'),
(3, 'Michael', 'Brown', 'michael.brown@example.com'),
(4, 'Laura', 'Davis', 'laura.davis@example.com'),
(5, 'Brian', 'Williams', 'brian.williams@example.com'),
(6, 'Rachel', 'Miller', 'rachel.miller@example.com'),
(7, 'Tom', 'Anderson', 'tom.anderson@example.com'),
(8, 'Emma', 'Taylor', 'emma.taylor@example.com'),
(9, 'Alex', 'Clark', 'alex.clark@example.com'),
(10, 'Sophia', 'Moore', 'sophia.moore@example.com');

INSERT INTO Courses (courseID, courseName, credits, teacherID)
VALUES(1, 'Mathematics', 3, 1),
(2, 'History', 4, 2),
(3, 'Physics', 3, 3),
(4, 'English', 3, 4),
(5, 'Computer Science', 4, 5),
(6, 'Biology', 3, NULL),
(7, 'Chemistry', 4, 6),
(8, 'Art', 2, 7),
(9, 'Geography', 3, 8),
(10, 'Music', 2, 9);

INSERT INTO Enrollment (enrollmentID, studentID, courseID, enrollmentDate)
VALUES(1, 1, 1, '2023-01-01'),
(2, 2, 2, '2023-01-02'),
(3, 3, 3, '2023-01-03'),
(4, 4, 4, '2023-01-04'),
(5, 5, 5, '2023-01-05'),
(6, 6, 6, '2023-01-06'),
(7, 7, 7, '2023-01-07'),
(8, 8, NULL, NULL),
(9, 9, 8, '2023-01-09'),
(10, 10, 9, '2023-01-10');

INSERT INTO Payments (paymentID, studentID, amount, paymentDate)
VALUES(1, 1, 100.00, '2023-01-01'),
(2, 2, 150.50, '2023-01-02'),
(3, 3, 200.00, '2023-01-03'),
(4, 4, 75.25, '2023-01-04'),
(5, 5, 120.75, '2023-01-05'),
(6, 6, 90.00, '2023-01-06'),
(7, 7, 180.50, '2023-01-07'),
(8, 8, 50.00, '2023-01-08'),
(9, 9, 135.25, '2023-01-09'),
(10, 10, 95.75, '2023-01-10');


--Q3.b Write SQL queries for the following tasks: 
/*1.Write an SQL query to insert a new student into the "Students" table with the following details:
a. First Name: John
b. Last Name: Doe
c. Date of Birth: 1995-08-15
d. Email: john.doe@example.com
e. Phone Number: 1234567890 */
INSERT INTO Students (studentID, firstName, lastName, DOB, email, phoneNumber)
VALUES(11, 'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

/*2.Write an SQL query to enroll a student in a course. Choose an existing student and course and 
insert a record into the "Enrollments" table with the enrollment date.*/
INSERT INTO Enrollment (enrollmentID, studentID, courseID, enrollmentDate)
VALUES(11, 11, 1, '2023-11-15');

/*3.Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and 
modify their email address.*/
UPDATE Teacher SET email = 'emily.smith@example.com' WHERE teacherID = 2;

/*4.Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select 
an enrollment record based on student and course.*/
DELETE FROM Enrollment WHERE studentID = 11 AND courseID = 1;

/*5.Update the "Courses" table to assign a specific teacher to a course. Choose any course and 
teacher from the respective tables.*/
UPDATE Courses SET teacherID = 4 WHERE courseID = 7;

/*6.Delete a specific student from the "Students" table and remove all their enrollment records 
from the "Enrollments" table. Be sure to maintain referential integrity.*/
DELETE FROM Enrollment WHERE studentID = 10;
DELETE FROM Students WHERE studentID = 10;

/*7.Update the payment amount for a specific payment record in the "Payments" table. Choose any 
payment record and modify the payment amount.*/
UPDATE Payments SET amount = 215.00 WHERE paymentID = 3;

--Q4 Joins
/*1.Write an SQL query to calculate the total payments made by a specific student. You will need to 
join the "Payments" table with the "Students" table based on the student's ID.*/
SELECT S.studentID, S.firstName, S.lastName, COUNT(P.amount) AS TotalPayment FROM Students AS S
INNER JOIN Payments AS P ON S.studentID = P.studentID WHERE S.studentID = 1 GROUP BY 
S.studentID, S.firstName, S.lastName;

/*2.Write an SQL query to retrieve a list of courses along with the count of students enrolled in each 
course. Use a JOIN operation between the "Courses" table and the "Enrollments" table.*/
SELECT C.courseID, C.courseName, COUNT(E.studentID) AS enrolledStudents FROM Courses AS C
LEFT JOIN Enrollment AS E ON C.courseID = E.courseID GROUP BY C.courseID, C.courseName;

/*3.Write an SQL query to find the names of students who have not enrolled in any course. Use a 
LEFT JOIN between the "Students" table and the "Enrollments" table to identify students 
without enrollments.*/
SELECT S.studentID, S.firstName, S.lastName FROM Students AS S LEFT JOIN Enrollment AS E ON 
S.studentID = E.studentID WHERE E.studentID IS NULL;

/*4.Write an SQL query to retrieve the first name, last name of students, and the names of the 
courses they are enrolled in. Use JOIN operations between the "Students" table and the 
"Enrollments" and "Courses" tables.*/
SELECT S.firstName, S.lastName, C.courseName FROM Students AS S INNER JOIN Enrollment AS E ON 
S.studentID = E.studentID INNER JOIN Courses AS C ON C.courseID = E.courseID;

/*5.Create a query to list the names of teachers and the courses they are assigned to. Join the 
"Teacher" table with the "Courses" table.*/
SELECT T.firstName, T.lastName, C.courseName FROM Teacher AS T INNER JOIN Courses AS C ON 
T.teacherID = C.teacherID;

/*6.Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the 
"Students" table with the "Enrollments" and "Courses" tables.*/
SELECT S.firstName, S.lastName, E.enrollmentDate FROM Students AS S INNER JOIN Enrollment AS E ON
S.studentID = E.studentID WHERE E.courseID = 4;

/*7.Find the names of students who have not made any payments. Use a LEFT JOIN between the 
"Students" table and the "Payments" table and filter for students with NULL payment records.*/
SELECT S.firstName, S.lastName, P.amount FROM Students AS S LEFT JOIN Payments AS P ON
S.studentID = P.paymentID WHERE amount IS NULL;

/*8.Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN 
between the "Courses" table and the "Enrollments" table and filter for courses with NULL 
enrollment records.*/
SELECT C.courseID, C.courseName FROM Courses AS C LEFT JOIN Enrollment AS E ON E.courseID = C.courseID
WHERE E.courseID IS NULL;

/*9.Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" 
table to find students with multiple enrollment records.*/
SELECT S.studentID, S.firstName, S.lastName FROM Students AS S JOIN Enrollment AS E ON
S.studentID = E.studentID GROUP BY S.studentID, S.firstName, S.lastName 
HAVING count(DISTINCT E.courseID) > 1;

/*10.Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" 
table and the "Courses" table and filter for teachers with NULL course assignments.*/
SELECT T.teacherID, T.firstName, T.lastName FROM Teacher AS T LEFT JOIN Courses AS C 
ON C.teacherID = T.teacherID WHERE C.teacherID IS NULL;

--Q5.Aggregate Functions and Subqueries:
/*1.Write an SQL query to calculate the average number of students enrolled in each course. Use 
aggregate functions and subqueries to achieve this.*/
SELECT courseID, AVG(numberOfStudents) AS averageStudentsEnrolled FROM (SELECT courseID, COUNT(studentID) 
AS numberOfStudents FROM Enrollment GROUP BY courseID)numberOfStudents GROUP BY courseID;

/*2.Identify the student(s) who made the highest payment. Use a subquery to find the maximum 
payment amount and then retrieve the student(s) associated with that amount.*/
SELECT S.studentID, S.firstName, S.lastName, P.amount AS highestPayment FROM Students AS S
INNER JOIN Payments AS P ON P.studentID = S.studentID WHERE amount = (SELECT MAX(amount) FROM Payments);

/*3.Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the 
course(s) with the maximum enrollment count.*/
SELECT courseID, courseName, credits FROM Courses WHERE courseID IN (SELECT TOP 1 courseID FROM Enrollment
GROUP BY courseID ORDER BY COUNT(studentID) DESC);

/*4.Calculate the total payments made to courses taught by each teacher. Use subqueries to sum 
payments for each teacher's courses.*/
SELECT T.teacherID, T.firstName, T.lastName, (SELECT SUM(P.amount) FROM Enrollment AS E INNER JOIN 
Payments AS P ON E.studentID = P.studentID WHERE C.courseID = E.courseID) AS totalPayments
FROM Teacher AS T INNER JOIN Courses AS C ON T.teacherID = C.teacherID;

/*5.Identify students who are enrolled in all available courses. Use subqueries to compare a 
student's enrollments with the total number of courses.*/
SELECT S.studentID, S.firstName, S.lastName FROM Students AS S WHERE (SELECT COUNT(DISTINCT courseID) FROM 
Courses) = (SELECT COUNT(DISTINCT courseID) FROM Enrollment AS E WHERE S.studentID = E.studentID);

/*6.Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to 
find teachers with no course assignments.*/
SELECT teacherID, firstName, lastName FROM Teacher WHERE teacherID NOT IN (SELECT DISTINCT teacherID 
FROM Courses);

/*7.Calculate the average age of all students. Use subqueries to calculate the age of each student 
based on their date of birth.*/
SELECT AVG(DATEDIFF(YEAR, DOB,GETDATE())) AS averageAge FROM Students;

/*8.Identify courses with no enrollments. Use subqueries to find courses without enrollment records.*/
SELECT courseID, courseName FROM Courses WHERE courseID NOT IN (SELECT DISTINCT courseID FROM Enrollment);

/*9.Calculate the total payments made by each student for each course they are enrolled in. Use 
subqueries and aggregate functions to sum payments.*/
SELECT E.studentID, C.courseID, (SELECT SUM(amount) FROM Payments WHERE studentID = E.studentID) AS 
totalPayments FROM Enrollment AS E INNER JOIN Courses AS C ON E.courseID = C.courseID;

/*10.Identify students who have made more than one payment. Use subqueries and aggregate functions 
to count payments per student and filter for those with counts greater than one.*/
SELECT S.studentID, S.firstName, S.lastName FROM Students AS S WHERE S.studentID IN (SELECT studentID
FROM Payments AS P GROUP BY studentID HAVING COUNT(P.paymentID) > 1);

/*11. Write an SQL query to calculate the total payments made by each student. Join the "Students" 
table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.*/
SELECT S.studentID, S.firstName, S.lastName, (SELECT SUM(amount) FROM Payments WHERE 
studentID = S.studentID) AS totalPayments FROM Students AS S;

/*12. Retrieve a list of course names along with the count of students enrolled in each course. 
Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count 
enrollments.*/
SELECT C.courseName, (SELECT COUNT(studentID) FROM Enrollment WHERE courseID = C.courseID) AS 
enrolledStudentsCount FROM Courses AS C;

/*13. Calculate the average payment amount made by students. Use JOIN operations between the "Students" 
table and the "Payments" table and GROUP BY to calculate the average.*/
SELECT S.studentID, S.firstName, S.lastName,(SELECT AVG(amount) FROM Payments WHERE studentID = S.studentID) 
AS averagePaymentAmount FROM Students AS S;
