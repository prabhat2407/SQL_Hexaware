CREATE DATABASE School;

USE School;

CREATE TABLE CourseMaster (
CID INT PRIMARY KEY,
CourseName VARCHAR(40) NOT NULL,
Category CHAR(1) NULL CHECK (Category IN ('B', 'M', 'A')),
Fee SMALLMONEY NOT NULL CHECK (Fee >= 0)
);

CREATE TABLE StudentMaster(
SID TINYINT PRIMARY KEY,
StudentName VARCHAR(40) NOT NULL,
Origin CHAR(1) NOT NULL CHECK (Origin IN ('L', 'F')),
Type CHAR(1) NOT NULL CHECK (Type IN ('U', 'G'))
);

CREATE TABLE EnrollmentMaster (
CID INT NOT NULL,
SID TINYINT NOT NULL,
DOE DATETIME NOT NULL,
FWF BIT NOT NULL,
Grade CHAR(1) CHECK (Grade IN ('O', 'A', 'B', 'C')),
FOREIGN KEY (CID) REFERENCES CourseMaster(CID),
FOREIGN KEY (SID) REFERENCES StudentMaster(SID)
);

INSERT INTO CourseMaster (CID, CourseName, Category, Fee) VALUES
(1, 'Java', 'A', 1000.00),
(2, 'Python', 'B', 800.00),
(3, 'Data Science', 'A', 1200.00),
(4, 'C++', 'B', 850.00),
(5, 'Web Development', 'M', 700.00),
(6, 'Machine Learning', 'A', 1100.00);

INSERT INTO StudentMaster (SID, StudentName, Origin, Type) VALUES
(1, 'John Doe', 'F', 'U'),
(2, 'Prabhat', 'F', 'G'),
(3, 'Shivam', 'L', 'U'),
(4, 'Robert', 'L', 'G'),
(5, 'Vaibhav', 'L', 'U'),
(6, 'Jiya', 'F', 'G'),
(7, 'Prachi', 'F', 'U'),
(8, 'Jayant', 'F', 'U'),
(9, 'Rohit', 'L', 'U'),
(10, 'Dhruv', 'F', 'G'),
(11, 'Akash', 'L', 'G'),
(12, 'Daniel', 'F', 'U'),
(13, 'Akshay', 'L', 'G'),
(14, 'Devendra', 'L', 'U'),
(15, 'Kiran', 'F', 'U'),
(16, 'Ram', 'L', 'U'),
(17, 'Shyam', 'L', 'G'),
(18, 'Arjun', 'L', 'U'),
(19, 'Karan', 'F', 'U'),
(20, 'Geeta', 'L', 'U'),
(21, 'Sita', 'F', 'U'),
(22, 'Rita', 'L', 'G');

-- Insert into EnrollmentMaster table
INSERT INTO EnrollmentMaster (CID, SID, DOE, FWF, Grade)
VALUES(1, 1, '2020-01-15', 0, 'A'),
(2, 2, '2020-02-20', 1, 'B'),
(3, 3, '2020-03-10', 0, 'C'),
(4, 4, '2020-04-25', 1, 'O'),
(5, 5, '2020-05-05', 0, 'A'),
(6, 6, '2020-06-15', 1, 'B'),
(1, 7, '2021-01-01', 0, 'C'),
(2, 8, '2021-02-15', 1, 'A'),
(3, 9, '2021-03-10', 0, 'O'),
(4, 10, '2021-04-20', 1, 'B'),
(5, 11, '2021-05-05', 0, 'B'),
(6, 12, '2021-06-15', 1, 'A'),
(1, 13, '2022-01-01', 0, 'C'),
(2, 14, '2022-02-15', 1, 'C'),
(3, 15, '2022-03-10', 0, 'O'),
(4, 16, '2022-04-20', 1, 'A'),
(5, 17, '2022-05-05', 0, 'B'),
(6, 18, '2022-06-15', 1, 'C'),
(1, 19, '2023-01-01', 0, 'O'),
(2, 20, '2023-02-15', 1, 'A'),
(3, 21, '2023-03-10', 0, 'A'),
(4, 22, '2023-04-20', 1, 'B'),
(5, 1, '2023-05-05', 0, 'C'),
(6, 2, '2023-06-15', 1, 'C'),
(1, 3, '2023-07-01', 0, 'B'),
(2, 4, '2023-08-12', 1, 'B'),
(3, 5, '2023-09-07', 0, 'O'),
(4, 6, '2023-11-01', 1, 'A'),
(5, 7, '2023-11-12', 0, 'B'),
(6, 8, '2023-12-15', 1, 'C');

/*Q1.List the course wise total no. of Students enrolled. Provide the information only for students 
of foreign origin and only if the total exceeds 10.*/
SELECT C.CourseName, COUNT(E.SID) AS TotalStudents FROM CourseMaster AS C INNER JOIN EnrollmentMaster AS E
ON C.CID = E.CID INNER JOIN StudentMaster AS S ON E.SID = S.SID WHERE Origin = 'F' GROUP BY C.CourseName
HAVING COUNT(E.SID) > 10;

--Q2.	List the names of the Students who have not enrolled for Java course
SELECT S.StudentName FROM StudentMaster AS S WHERE S.SID NOT IN (SELECT E.SID FROM CourseMaster AS C
INNER JOIN EnrollmentMaster AS E ON C.CID = E.CID WHERE C.CourseName = 'Java');

--Q3.List the name of the advanced course where the enrollment by foreign students is the highest.
SELECT C.CourseName FROM CourseMaster AS C INNER JOIN EnrollmentMaster AS E ON C.CID = E.CID
INNER JOIN StudentMaster AS S ON E.SID = S.SID AND S.Origin = 'F' WHERE C.Category = 'A' GROUP BY 
C.CourseName ORDER BY COUNT(DISTINCT E.SID) DESC;

--Q4.List the names of the students who have enrolled for at least one basic course in the current month.
SELECT DISTINCT S.StudentName FROM StudentMaster AS S INNER JOIN EnrollmentMaster AS E ON S.SID = E.SID 
INNER JOIN CourseMaster AS C ON E.CID = C.CID WHERE C.Category = 'B' AND MONTH(E.DOE) = MONTH(GETDATE());

--Q5.List the names of the Undergraduate, local students who have got a “C” grade in any basic course.
SELECT DISTINCT S.StudentName FROM StudentMaster AS S INNER JOIN EnrollmentMaster AS E ON S.SID = E.SID 
INNER JOIN CourseMaster AS C ON E.CID = C.CID WHERE S.Type = 'U' AND S.Origin = 'L' AND C.Category = 'B' 
AND E.Grade = 'C';

--Q6.List the names of the courses for which no student has enrolled in the month of May 2020.
SELECT C.CourseName FROM CourseMaster AS C WHERE C.CID NOT IN (SELECT DISTINCT E.CID FROM 
EnrollmentMaster AS E WHERE MONTH(E.DOE) = 5 AND YEAR(E.DOE) = 2020);

/*Q7.List name, Number of Enrollments and Popularity for all Courses. Popularity has to be displayed as 
“High” if number of enrollments is higher than 50,  “Medium” if greater than or equal to 20 and less than 
50, and “Low” if the no.  Is less than 20.*/
SELECT C.CourseName, COUNT(E.SID) AS NumberofEnrollments,
IIF(COUNT(E.SID) > 50, 'High', IIF(COUNT(E.SID) >= 20, 'Medium', 'Low')) AS Popularity
FROM CourseMaster AS C LEFT JOIN EnrollmentMaster AS E ON C.CID = E.CID GROUP BY C.CourseName;

/*Q8.List the most recent enrollment details with information on Student Name, Course name and age 
of enrollment in days.*/
SELECT TOP 1 S.StudentName, C.CourseName, E.DOE, DATEDIFF(DAY, E.DOE, GETDATE()) AS AgeOfEnrollmentInDays
FROM EnrollmentMaster AS E INNER JOIN StudentMaster AS S ON E.SID = S.SID INNER JOIN CourseMaster AS C 
ON E.CID = C.CID ORDER BY E.DOE DESC;

--Q9.List the names of the Local students who have enrolled for exactly 3 basic courses.
SELECT S.StudentName FROM StudentMaster AS S INNER JOIN EnrollmentMaster AS E ON S.SID = E.SID INNER JOIN
CourseMaster AS C ON E.CID = C.CID WHERE S.Origin = 'L' AND S.Type = 'U' AND C.Category = 'B'
GROUP BY S.StudentName HAVING COUNT(E.CID) = 3;

--Q10.List the names of the Courses enrolled by all (every) students.
SELECT C.CourseName FROM CourseMaster AS C WHERE NOT EXISTS (SELECT S.SID FROM StudentMaster AS S WHERE 
NOT EXISTS (SELECT E.CID FROM EnrollmentMaster AS E WHERE E.CID = C.CID AND E.SID = S.SID));

/*Q11.For those enrollments for which fee have been waived, provide the names of students who have got 
‘O’ grade.*/
SELECT S.StudentName FROM StudentMaster AS S INNER JOIN EnrollmentMaster AS E ON S.SID = E.SID WHERE
E.FWF = 1 AND E.Grade = 'O';

--Q12.List the names of the foreign, undergraduate students who have got grade ‘C’ in any basic course.
SELECT DISTINCT S.StudentName FROM StudentMaster AS S INNER JOIN EnrollmentMaster AS E ON S.SID = E.SID
INNER JOIN CourseMaster AS C ON E.CID = C.CID WHERE S.Origin = 'F' AND S.Type = 'U' AND 
C.Category = 'B' AND E.Grade = 'C';

--Q13.List the course name, total no. of enrollments in the current month.
SELECT C.CourseName, COUNT(E.SID) AS TotalEnrollments FROM CourseMaster AS C LEFT JOIN EnrollmentMaster AS E
ON C.CID = E.CID WHERE MONTH(E.DOE) = MONTH(GETDATE()) AND YEAR(E.DOE) = YEAR(GETDATE()) 
GROUP BY C.CourseName;


