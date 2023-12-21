CREATE DATABASE CrimeAnalysis;

USE CrimeAnalysis;

CREATE TABLE LawAgency(
agencyID INT PRIMARY KEY,
agencyName VARCHAR(50),
juridiction VARCHAR(30),
phone VARCHAR(20),
address VARCHAR(50),
email VARCHAR(50)
);

CREATE TABLE Incidents(
incidentID INT PRIMARY KEY,
incidentType VARCHAR(30),
incidentDate Date,
Location VARCHAR(30),
description VARCHAR(50),
victimID INT,
suspectID INT,
agencyID INT,
status VARCHAR(30) CHECK (status IN ('Open', 'Closed','Under Investigation')),
FOREIGN KEY (agencyID) REFERENCES LawAgency(agencyID) ON DELETE CASCADE
);

CREATE TABLE Victims(
victimID INT PRIMARY KEY,
firstName VARCHAR(50),
lastName VARCHAR(50),
DOB DATE,
gender CHAR(1) CHECK (gender IN ('M','F')),
phone VARCHAR(20),
address VARCHAR(50),
incidentID INT,
FOREIGN KEY (incidentID) REFERENCES Incidents(incidentID)ON DELETE CASCADE
);

CREATE TABLE Suspects(
incidentID INT,
firstName VARCHAR(50),
lastName VARCHAR(50),
DOB DATE,
gender CHAR(1) CHECK (gender IN ('M','F')),
phone VARCHAR(20),
address VARCHAR(50),
FOREIGN KEY (incidentID) REFERENCES Incidents(incidentID)ON DELETE CASCADE
);

CREATE TABLE Evidence(
evidenceID INT PRIMARY KEY,
description VARCHAR(50),
location VARCHAR(30),
incidentID INT,
FOREIGN KEY (incidentID) REFERENCES Incidents(incidentID)ON DELETE CASCADE
);


CREATE TABLE Officers(
officerID INT PRIMARY KEY,
firstName VARCHAR(50),
lastName VARCHAR(50),
badgeNumber INT,
rank VARCHAR(20),
phone VARCHAR(40),
email VARCHAR(30),
address VARCHAR(50),
agencyID INT,
FOREIGN KEY (agencyID)REFERENCES LawAgency(agencyID) ON DELETE CASCADE
);

CREATE TABLE Reports(
reportID INT PRIMARY KEY,
incidentID INT,
officerID INT,
reportDate DATE,
reportDetails VARCHAR(50),
status VARCHAR(20) CHECK(status IN('Draft', 'Finalized')),
FOREIGN KEY (incidentID) REFERENCES Incidents(incidentID) ON DELETE NO ACTION,
FOREIGN KEY (officerID) REFERENCES Officers(officerID) ON DELETE CASCADE
);

INSERT INTO LawAgency (agencyID, agencyName, juridiction, phone, address, email) VALUES
(1, 'Legal Experts LLC', 'State A', '123-456-7890', '123 Main St, City A', 'legal.experts@example.com'),
(2, 'Justice Associates', 'State B', '987-654-3210', '456 Oak St, City B', 'justice.associates@example.com'),
(3, 'Law Solutions Inc', 'State C', '555-123-7890', '789 Elm St, City C', 'law.solutions@example.com'),
(4, 'Elite Attorneys', 'State D', '111-222-3333', '321 Pine St, City D', 'elite.attorneys@example.com'),
(5, 'Pro Legal Services', 'State E', '999-888-7777', '654 Maple St, City E', 'pro.legal@example.com'),
(6, 'Legal Guardianship', 'State F', '777-555-1111', '987 Cedar St, City F', 'legal.guardianship@example.com'),
(7, 'Justice League Law Firm', 'State G', '333-444-5555', '234 Birch St, City G', 'justice.league@example.com'),
(8, 'Defense Masters', 'State H', '222-666-9999', '876 Walnut St, City H', 'defense.masters@example.com'),
(9, 'Courthouse Consultants', 'State I', '444-777-0000', '543 Spruce St, City I', 'courthouse.consultants@example.com'),
(10, 'Legal Minds Group', 'State J', '666-999-1111', '765 Fir St, City J', 'legal.minds@example.com');

INSERT INTO Incidents (incidentID, incidentType, incidentDate, location, description, victimID, suspectID, agencyID, status) VALUES
(1, 'Theft', '2023-01-10', 'City A', 'Stolen vehicle', 101, 201, 1, 'Open'),
(2, 'Assault', '2023-02-15', 'City B', 'Physical altercation', 102, 202, 2, 'Closed'),
(3, 'Burglary', '2023-03-20', 'City C', 'Break-in at a residence', 103, 203, 3, 'Under Investigation'),
(4, 'Fraud', '2023-04-25', 'City D', 'Financial scam', 104, 204, 4, 'Open'),
(5, 'Kidnapping', '2023-05-30', 'City E', 'Abduction case', 105, 205, 5, 'Closed'),
(6, 'Vandalism', '2023-06-05', 'City F', 'Property damage', 106, 206, 6, 'Under Investigation'),
(7, 'Robbery', '2023-07-10', 'City G', 'Armed robbery', 107, 207, 7, 'Open'),
(8, 'Homicide', '2023-08-15', 'City H', 'Murder investigation', 108, 208, 8, 'Closed'),
(9, 'Domestic Violence', '2023-09-20', 'City I', 'Family dispute', 109, 209, 9, 'Under Investigation'),
(10, 'Cybercrime', '2023-10-25', 'City J', 'Online fraud', 110, 210, 10, 'Open');

INSERT INTO Victims (victimID, firstName, lastName, DOB, gender, phone, address, incidentID) VALUES
(101, 'John', 'Doe', '1990-05-15', 'M', '555-1234', '123 Main St, City A', 1),
(102, 'Jane', 'Smith', '1985-08-22', 'F', '555-5678', '456 Oak St, City B', 2),
(103, 'Robert', 'Johnson', '1993-02-10', 'M', '555-9876', '789 Elm St, City C', 3),
(104, 'Emily', 'Williams', '1988-11-30', 'F', '555-4321', '321 Pine St, City D', 4),
(105, 'Michael', 'Brown', '1995-07-18', 'M', '555-8765', '654 Maple St, City E', 5),
(106, 'Sarah', 'Miller', '1992-04-05', 'F', '555-1111', '987 Cedar St, City F', 6),
(107, 'Daniel', 'Taylor', '1987-09-12', 'M', '555-2222', '234 Birch St, City G', 7),
(108, 'Olivia', 'Davis', '1998-01-25', 'F', '555-3333', '876 Walnut St, City H', 8),
(109, 'Christopher', 'Clark', '1991-06-08', 'M', '555-4444', '543 Spruce St, City I', 9),
(110, 'Sophia', 'Moore', '1989-03-14', 'F', '555-5555', '765 Fir St, City J', 10);

INSERT INTO Suspects (incidentID, firstName, lastName, DOB, gender, phone, address) VALUES
(1, 'Robert', 'Johnson', '1990-03-15', 'M', '555-1234', '123 Main St, City A'),
(2, 'Emily', 'Williams', '1985-08-22', 'F', '555-5678', '456 Oak St, City B'),
(3, 'Daniel', 'Taylor', '1993-02-10', 'M', '555-9876', '789 Elm St, City C'),
(4, 'Sophia', 'Moore', '1988-11-30', 'F', '555-4321', '321 Pine St, City D'),
(5, 'Michael', 'Brown', '1995-07-18', 'M', '555-8765', '654 Maple St, City E'),
(6, 'Olivia', 'Davis', '1992-04-05', 'F', '555-1111', '987 Cedar St, City F'),
(7, 'Christopher', 'Clark', '1987-09-12', 'M', '555-2222', '234 Birch St, City G'),
(8, 'Sarah', 'Miller', '1998-01-25', 'F', '555-3333', '876 Walnut St, City H'),
(9, 'John', 'Doe', '1991-06-08', 'M', '555-4444', '543 Spruce St, City I'),
(10, 'Jane', 'Smith', '1989-03-14', 'F', '555-5555', '765 Fir St, City J');

INSERT INTO Evidence (evidenceID, description, location, incidentID) VALUES
(1, 'Fingerprint on door handle', 'Crime scene A', 1),
(2, 'Surveillance footage', 'Street B', 2),
(3, 'Broken window glass', 'Residence C', 3),
(4, 'Financial transaction records', 'Business D', 4),
(5, 'Witness statement', 'Area E', 5),
(6, 'Vandalized property', 'Street F', 6),
(7, 'Stolen item recovered', 'Alley G', 7),
(8, 'Forensic report', 'Crime scene H', 8),
(9, 'Domestic disturbance report', 'Residence I', 9),
(10, 'Digital evidence', 'Online platform J', 10);

INSERT INTO Officers (officerID, firstName, lastName, badgeNumber, rank, phone, email, address, agencyID) VALUES
(1, 'John', 'Smith', 1234, 'Detective', '555-123-4567', 'john.smith@example.com', '123 Main St, City A', 1),
(2, 'Emily', 'Johnson', 5678, 'Officer', '555-234-5678', 'emily.johnson@example.com', '456 Oak St, City B', 2),
(3, 'Daniel', 'Williams', 9876, 'Sergeant', '555-345-6789', 'daniel.williams@example.com', '789 Elm St, City C', 3),
(4, 'Sophia', 'Brown', 4321, 'Lieutenant', '555-456-7890', 'sophia.brown@example.com', '321 Pine St, City D', 4),
(5, 'Michael', 'Taylor', 8765, 'Captain', '555-567-8901', 'michael.taylor@example.com', '654 Maple St, City E', 5),
(6, 'Olivia', 'Miller', 1111, 'Detective', '555-678-9012', 'olivia.miller@example.com', '987 Cedar St, City F', 6),
(7, 'Christopher', 'Davis', 2222, 'Officer', '555-789-0123', 'christopher.davis@example.com', '234 Birch St, City G', 7),
(8, 'Sarah', 'Clark', 3333, 'Sergeant', '555-890-1234', 'sarah.clark@example.com', '876 Walnut St, City H', 8),
(9, 'John', 'Moore', 4444, 'Lieutenant', '555-901-2345', 'john.moore@example.com', '543 Spruce St, City I', 9),
(10, 'Jane', 'Smith', 5555, 'Captain', '555-012-3456', 'jane.smith@example.com', '765 Fir St, City J', 10);

INSERT INTO Reports (reportID, incidentID, officerID, reportDate, reportDetails, status) VALUES
(1, 1, 1, '2023-01-12', 'Theft investigation report', 'Draft'),
(2, 2, 2, '2023-02-18', 'Assault incident report', 'Finalized'),
(3, 3, 3, '2023-03-25', 'Burglary investigation report', 'Draft'),
(4, 4, 4, '2023-04-30', 'Fraud case report', 'Finalized'),
(5, 5, 5, '2023-06-05', 'Kidnapping incident report', 'Draft'),
(6, 6, 6, '2023-07-12', 'Vandalism investigation report', 'Finalized'),
(7, 7, 7, '2023-08-18', 'Robbery incident report', 'Draft'),
(8, 8, 8, '2023-09-24', 'Homicide investigation report', 'Finalized'),
(9, 9, 9, '2023-10-30', 'Domestic Violence report', 'Draft'),
(10, 10, 10, '2023-12-05', 'Cybercrime investigation report', 'Finalized');
