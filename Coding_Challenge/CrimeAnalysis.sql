CREATE DATABASE CrimeManagement;

USE CrimeManagement;

CREATE TABLE Crime (
    CrimeID INT PRIMARY KEY,
    IncidentType VARCHAR(255),
    IncidentDate DATE,
    Location VARCHAR(255),
    Description TEXT,
    Status VARCHAR(20)
);

CREATE TABLE Victim (
    VictimID INT PRIMARY KEY,
    CrimeID INT,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255),
    Injuries VARCHAR(255),
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

CREATE TABLE Suspect (
    SuspectID INT PRIMARY KEY,
    CrimeID INT,
    Name VARCHAR(255),
    Description TEXT,
    CriminalHistory TEXT,
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

-- Insert sample data
INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
    (1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
    (2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under Investigation'),
    (3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries)
VALUES
    (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
    (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
    (3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None');

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory)
VALUES
    (1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
    (2, 2, 'Unknown', 'Investigation ongoing', NULL),
    (3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests');


--Q1.Select all open incidents.
SELECT * FROM Crime WHERE status = 'Open';

--Q2.Find the total number of incidents.
SELECT COUNT(*) AS totalIncidents FROM Crime;

--Q3.List all unique incident types.
SELECT DISTINCT incidentType FROM Crime;

--Q4.Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.
SELECT * FROM Crime WHERE incidentDate BETWEEN '2023-09-01' AND '2023-09-10';

--Q5.List persons involved in incidents in descending order of age.
SELECT DISTINCT COALESCE(v.Name, s.Name) AS Name, COALESCE(v.DOB, s.DOB) AS DOB FROM Victim v FULL JOIN Suspect s ON 
v.CrimeID = s.CrimeID ORDER BY COALESCE(v.DOB, s.DOB) DESC;

--Q6.Find the average age of persons involved in incidents.
ALTER TABLE Victim ADD DOB DATE
ALTER TABLE Suspect ADD DOB DATE
UPDATE Victim 
SET DOB ='1999-09-09' WHERE VictimID=1
UPDATE Victim 
SET DOB ='1999-07-09' WHERE VictimID=2
UPDATE Victim 
SET DOB ='1999-05-09' WHERE VictimID=3
UPDATE Suspect 
SET DOB ='1998-09-09' WHERE SuspectID=1
UPDATE Suspect 
SET DOB ='1998-04-09' WHERE SuspectID=2
UPDATE Suspect 
SET DOB ='2000-09-09' WHERE SuspectID=3

SELECT Name, DOB FROM (SELECT Name, DOB FROM Victim UNION SELECT Name, DOB FROM Suspect) AS combinedTable ORDER BY DOB DESC;

--Q6.Find the average age of persons involved in incidents.
SELECT AVG(A.AGE) AS AverageAge FROM (SELECT DATEDIFF(YEAR, P.DOB, GETDATE()) AS AGE FROM (SELECT V.Name, V.DOB FROM Victim V
UNION SELECT S.Name, S.DOB FROM Suspect S) AS P) AS A;

--Q7.List incident types and their counts, only for open cases.
SELECT IncidentType, COUNT(*) AS incidentCount FROM Crime WHERE Status = 'Open' GROUP BY IncidentType;

--Q8.Find persons with names containing 'Doe'.
SELECT N.NAME FROM (SELECT NAME FROM Victim UNION SELECT NAME FROM Suspect) AS N WHERE N.NAME LIKE '%Doe%'

--Q9.Retrieve the names of persons involved in open cases and closed cases.
SELECT V.Name, CASE WHEN C.Status = 'Open' THEN 'Open' ELSE 'Closed' END AS caseStatus FROM Victim V JOIN Crime C ON 
V.CrimeID = C.CrimeID;

--Q10.List incident types where there are persons aged 30 or 35 involved.
SELECT DISTINCT C.IncidentType FROM Crime C INNER JOIN (SELECT CrimeID FROM Victim WHERE DATEDIFF(YEAR, DOB, GETDATE()) IN (30, 35)
UNION SELECT CrimeID FROM Suspect WHERE DATEDIFF(YEAR, DOB, GETDATE()) IN (30, 35)) AS filteredCrimes ON 
C.CrimeID = filteredCrimes.CrimeID;

--Q11..Find persons involved in incidents of the same type as 'Robbery'.
SELECT DISTINCT P.Name FROM (SELECT V.Name, V.CrimeID FROM Victim V JOIN Crime C ON V.CrimeID = C.CrimeID WHERE 
C.IncidentType = 'Robbery' UNION SELECT S.Name, S.CrimeID FROM Suspect S JOIN Crime C ON S.CrimeID = C.CrimeID WHERE 
C.IncidentType = 'Robbery') AS P;

--Q12.List incident types with more than one open case.
SELECT IncidentType, COUNT(*) AS openCases FROM Crime WHERE Status = 'Open' GROUP BY IncidentType HAVING COUNT(*) > 1;

--Q13.List all incidents with suspects whose names also appear as victims in other incidents.
SELECT C.*, S.Name AS SuspectName FROM Crime C INNER JOIN Suspect S ON C.CrimeID = S.CrimeID WHERE S.Name IN 
(SELECT Name FROM Victim WHERE CrimeID = C.CrimeID);

--Q14. Retrieve all incidents along with victim and suspect details.
SELECT C.*, V.Name AS VictimName, V.ContactInfo AS VictimContactInfo, S.Name AS SuspectName, S.CriminalHistory AS 
suspectCriminalHistory FROM Crime C LEFT JOIN Victim V ON C.CrimeID = V.CrimeID LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID;

--Q15.Find incidents where the suspect is older than any victim.
SELECT C.* FROM Crime C INNER JOIN Victim V ON C.CrimeID = V.CrimeID INNER JOIN Suspect S ON C.CrimeID = S.CrimeID
WHERE YEAR(S.DOB) > YEAR(V.DOB);

--Q16.Find suspects involved in multiple incidents.
SELECT SuspectID, Name, COUNT(*) AS IncidentCount FROM Suspect GROUP BY SuspectID, Name HAVING COUNT(*) > 1;

--Q17.List incidents with no suspects involved.
SELECT C.* FROM Crime C LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID WHERE S.SuspectID IS NULL;

--Q18.List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'.
SELECT DISTINCT C1.CrimeID, C1.IncidentType, C1.IncidentDate, C1.Location, CAST(C1.Description AS VARCHAR(MAX)) AS Description, 
C1.Status FROM Crime C1 INNER JOIN Crime C2 ON C1.CrimeID = C2.CrimeID WHERE C1.IncidentType = 'Homicide' AND 
C2.IncidentType = 'Robbery';

/*Q19.Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' 
if there are none.*/
SELECT C.*, COALESCE(S.Name, 'No Suspect') AS SuspectName, COALESCE(S.CriminalHistory, 'No Criminal History') AS 
suspectCriminalHistory FROM Crime C LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID;

--Q20.List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'
SELECT * FROM Suspect AS S INNER JOIN Crime AS C ON C.CrimeID=S.CrimeID WHERE IncidentType IN ('Robbery','Assault')





