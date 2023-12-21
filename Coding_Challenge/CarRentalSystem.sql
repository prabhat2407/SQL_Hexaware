CREATE DATABASE CarRentalSyStem;

USE CarRentalSystem;

--Vehicle Table
CREATE TABLE VEHICLE(
vehicleID INT PRIMARY KEY,
make VARCHAR(50),
model VARCHAR(50),
year INT,
dailyRate DECIMAL(10, 2),
status INT DEFAULT 1 CHECK (status IN (1, 0)),
passengerCapacity INT,
engineCapacity INT
);

--Customer Table
CREATE TABLE Customer(
customerID INT PRIMARY KEY,
firstName VARCHAR(50),
lastName VARCHAR(50),
email VARCHAR(50),
phoneNumber VARCHAR(20)
);

--Lease Table
CREATE TABLE Lease(
leaseID INT PRIMARY KEY,
vehicleID INT,
customerID INT,
startDate DATE,
endDate DATE,
type VARCHAR(20) DEFAULT 'DailyLease' CHECK(type IN('DailyLease','MonthlyLease')),
FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID) ON DELETE CASCADE,
FOREIGN KEY (customerID) REFERENCES Customer(customerID) ON DELETE CASCADE
);

--Payment Table
CREATE TABLE Payment(
paymentID INT PRIMARY KEY,
leaseID INT,
paymentDate DATE,
amount DECIMAL(10,2)
);

-- Inserting into Vehicle Table
INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (3, 'Ford', 'Focus', 2022, 48.00, 0, 4, 1400);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (7, 'BMW', '3 Series', 2023, 60.00, 1, 7, 2499);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (9, 'Audi', 'A4', 2022, 55.00, 0, 4, 2500);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (10, 'Lexus', 'ES', 2023, 54.00, 1, 4, 2500);

-- Inserting into Customer Table
INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES (1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555');

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES (2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567');

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES (3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234');

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES (4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890');

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES (5, 'David', 'Lee', 'david@example.com', '555-987-6543');

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES (6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678');

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES (7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432');

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES (8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098');

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES (9, 'William', 'Taylor', 'william@example.com', '555-321-6547');

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES (10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

-- Inserting into Lease Table
INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES (1, 1, 1, '2023-01-01', '2023-01-05', 'DailyLease');

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES (2, 2, 2, '2023-02-15', '2023-02-28', 'MonthlyLease');

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES (3, 3, 3, '2023-03-10', '2023-03-15', 'DailyLease');

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES (4, 4, 4, '2023-04-20', '2023-04-30', 'MonthlyLease');

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES (5, 5, 5, '2023-05-05', '2023-05-10', 'DailyLease');

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES (6, 4, 3, '2023-06-15', '2023-06-30', 'MonthlyLease');

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES (7, 7, 7, '2023-07-01', '2023-07-10', 'DailyLease');

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES (8, 8, 8, '2023-08-12', '2023-08-15', 'MonthlyLease');

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES (9, 3, 3, '2023-09-07', '2023-09-10', 'DailyLease');

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES (10, 10, 10, '2023-10-10', '2023-10-31', 'MonthlyLease');

-- Inserting into Payment Table
INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES (1, 1, '2023-01-03', 200.00);

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES (2, 2, '2023-02-20', 1000.00);

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES (3, 3, '2023-03-12', 75.00);

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES (4, 4, '2023-04-25', 900.00);

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES (5, 5, '2023-05-07', 60.00);

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES (6, 6, '2023-06-18', 1200.00);

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES (7, 7, '2023-07-03', 40.00);

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES (8, 8, '2023-08-14', 1100.00);

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES (9, 9, '2023-09-09', 80.00);

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES (10, 10, '2023-10-25', 1500.00);

--Q1.Update the daily rate for a Mercedes car to 68.
UPDATE Vehicle SET dailyRate = 68.00 WHERE make = 'Mercedes';

--Q2.Delete a specific customer and all associated leases and payments.
DELETE FROM Payment WHERE leaseID IN (SELECT leaseID FROM Lease WHERE customerID =5);
DELETE FROM Lease WHERE customerID = 5;
DELETE FROM Customer WHERE customerID = 5;

--Q3.Rename the "paymentDate" column in the Payment table to "transactionDate".
EXEC sp_rename 'Payment.paymentDate', 'transactionDate';

--Q4.Find a specific customer by email.
SELECT * FROM Customer WHERE email = 'sarah@example.com';

--Q5.Get active leases for a specific customer.
SELECT * FROM Lease WHERE customerID = 2 AND endDate >= startDate;

--Q6.Find all payments made by a customer with a specific phone number.
SELECT * FROM Payment WHERE leaseID IN (SELECT leaseID FROM Lease WHERE customerID IN 
(SELECT customerID FROM Customer WHERE phoneNumber = '555-432-1098'));

--Q7.Calculate the average daily rate of all available cars.SELECT AVG(dailyRate) AS AvgDailyRate FROM Vehicle WHERE status = 1;--Q8.Find the car with the highest daily rate.SELECT TOP 1 * FROM Vehicle ORDER BY dailyRate DESC;--Q9.Retrieve all cars leased by a specific customer.SELECT * FROM VEHICLE WHERE vehicleID IN(SELECT vehicleID FROM Lease WHERE customerID = 7);--Q10.Find the details of the most recent lease.SELECT TOP 1* FROM Lease ORDER BY endDate DESC;--Q11.List all payments made in the year 2023.SELECT * FROM Payment WHERE YEAR(transactionDate) = '2023';--Q12.Retrieve customers who have not made any payments.SELECT * FROM Customer WHERE customerID NOT IN (SELECT DISTINCT customerID FROM Payment);--Q13.Retrieve Car Details and Their Total Payments.SELECT v.*, SUM(Payment.amount) AS TotalPayment FROM VEHICLE AS v LEFT JOIN Lease ON v.vehicleID = Lease.vehicleID LEFT JOIN Payment ON Lease.leaseID = Payment.leaseIDGROUP BY v.vehicleID, v.make, v.model, v.year, v.dailyRate, v.status, v.passengerCapacity, v.engineCapacity;--Q14.Calculate Total Payments for Each Customer.SELECT c.*, SUM(Payment.amount) AS TotalPayment FROM Customer AS c LEFT JOIN Lease ON c.customerID = Lease.customerID LEFT JOIN Payment ON Lease.leaseID = Payment.leaseIDGROUP BY c.customerID, c.firstName, c.lastName, c.email, c.phoneNumber;--Q15.List Car Details for Each Lease.Select VEHICLE.*, Lease.* FROM Lease INNER JOIN VEHICLE ON VEHICLE.vehicleID = Lease.vehicleID;--Q16.Retrieve Details of Active Leases with Customer and Car Information.SELECT Lease.*, Customer.*, VEHICLE.* FROM Lease INNER JOIN Customer ON Lease.customerID = Customer.customerIDINNER JOIN VEHICLE ON Lease.vehicleID = VEHICLE.vehicleID WHERE Lease.endDate >= GETDATE(); 
--Q17.Find the Customer Who Has Spent the Most on Leases.SELECT TOP 1 C.*, ([amount]) AS TotalPayment
FROM Customer C LEFT JOIN Lease ON C.customerID = Lease.customerID LEFT JOIN Payment
ON Lease.leaseID = Payment.leaseID GROUP BY C.customerID, C.firstName, C.lastName, C.email, C.phoneNumber 
ORDER BY TotalPayment DESC;

--Q18.List All Cars with Their Current Lease Information.
SELECT VEHICLE.*, Lease.* FROM Vehicle LEFT JOIN Lease ON 
VEHICLE.vehicleID = Lease.vehicleID AND Lease.endDate >= GETDATE();
