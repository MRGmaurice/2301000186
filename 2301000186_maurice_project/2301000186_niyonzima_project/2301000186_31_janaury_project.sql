-- NIYONZIMA Maurice 2301000186
-- Create the Passenger Table
create database ticket_management_system;
use ticket_management_system;
CREATE TABLE Passenger (
    Passenger_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Gender VARCHAR(10),
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone_Number VARCHAR(15)
);

-- Create the Trip Table
CREATE TABLE Trip (
    Trip_ID INT AUTO_INCREMENT PRIMARY KEY,
    Departure_City VARCHAR(100) NOT NULL,
    Arrival_City VARCHAR(100) NOT NULL,
    Departure_Date DATETIME NOT NULL,
    Arrival_Date DATETIME NOT NULL,
    Train_Bus_Flight VARCHAR(50) NOT NULL,
    Price_Per_Seat DECIMAL(10, 2) NOT NULL
);

-- Create the Ticket Table
CREATE TABLE Ticket (
    Ticket_ID INT AUTO_INCREMENT PRIMARY KEY,
    Passenger_ID INT,
    Trip_ID INT,
    Issue_Date DATETIME NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Seat_Number VARCHAR(10),
    Status VARCHAR(50),
    FOREIGN KEY (Passenger_ID) REFERENCES Passenger(Passenger_ID) ON DELETE CASCADE,
    FOREIGN KEY (Trip_ID) REFERENCES Trip(Trip_ID) ON DELETE CASCADE
);
INSERT INTO Passenger (Name, Date_of_Birth, Gender, Email, Phone_Number)
VALUES
('Alice Johnson', '1985-06-15', 'Female', 'alice.johnson@email.com', '555-1234'),
('Bob Smith', '1990-09-10', 'Male', 'bob.smith@email.com', '555-5678'),
('Charlie Brown', '1995-01-25', 'Male', 'charlie.brown@email.com', '555-8765'),
('Diana Ross', '1980-03-02', 'Female', 'diana.ross@email.com', '555-2345'),
('Eva Green', '1992-11-30', 'Female', 'eva.green@email.com', '555-3456');

INSERT INTO Trip (Departure_City, Arrival_City, Departure_Date, Arrival_Date, Train_Bus_Flight, Price_Per_Seat)
VALUES
('New York', 'Los Angeles', '2025-03-01 08:00:00', '2025-03-01 14:00:00', 'Flight', 300.00),
('London', 'Paris', '2025-03-05 09:00:00', '2025-03-05 11:00:00', 'Train', 150.00),
('Berlin', 'Amsterdam', '2025-03-10 10:00:00', '2025-03-10 12:00:00', 'Bus', 50.00),
('Tokyo', 'Osaka', '2025-03-15 06:00:00', '2025-03-15 08:00:00', 'Flight', 250.00),
('Sydney', 'Melbourne', '2025-03-20 07:00:00', '2025-03-20 09:00:00', 'Flight', 200.00);

INSERT INTO Ticket (Passenger_ID, Trip_ID, Issue_Date, Price, Seat_Number, Status)
VALUES
(1, 1, '2025-02-01 10:00:00', 300.00, 'A1', 'Booked'),
(2, 2, '2025-02-02 12:00:00', 150.00, 'B3', 'Booked'),
(3, 3, '2025-02-03 14:00:00', 50.00, 'C5', 'Cancelled'),
(4, 4, '2025-02-04 16:00:00', 250.00, 'D2', 'Booked'),
(5, 5, '2025-02-05 18:00:00', 200.00, 'E4', 'Booked');

-- niyonzima maurice 2301000186
-- let do sum,count,and average

show tables;
-- count of passenger
select*from passenger;
 SELECT COUNT(*) AS Total_Passengers FROM Passenger;
 SELECT COUNT(*) AS Total_Trips FROM Trip;
SELECT COUNT(*) AS Total_Tickets FROM Ticket;

-- adding the average of this database
SELECT AVG(Price) AS Avg_Ticket_Price FROM Ticket;
SELECT AVG(Price_Per_Seat) AS Avg_Price_Per_Seat FROM Trip;
SELECT AVG(price_per_passenger) AS Avg_Ticket_Price FROM Ticket;
-- sum of tick and trip

SELECT SUM(Price) AS Total_Ticket_Price FROM Ticket;
SELECT SUM(Price_Per_Seat) AS Total_Trip_Price_Per_Seat FROM Trip;
-- 2301000186 niyonzima maurice
-- create view of all tables and inserted data in the database
-- view of passenger
CREATE VIEW View_Passenger AS
SELECT Passenger_ID, Name, Date_of_Birth, Gender, Email, Phone_Number
FROM Passenger;
-- view of ticket
CREATE VIEW View_Ticket AS
SELECT Ticket_ID, Passenger_ID, Trip_ID, Issue_Date, Price, Seat_Number, Status
FROM Ticket;

-- 2301000186 niyonzima maurice
-- view of trip
CREATE VIEW View_Trip AS
SELECT Trip_ID, Departure_City, Arrival_City, Departure_Date, Arrival_Date, Train_Bus_Flight, Price_Per_Seat
FROM Trip;

-- create a procedure of passenger and trip
-- let start with  passenger
DELIMITER $$

CREATE PROCEDURE AddPassenger (
    IN p_Name VARCHAR(255),
    IN p_Date_of_Birth DATE,
    IN p_Gender VARCHAR(10),
    IN p_Email VARCHAR(100),
    IN p_Phone_Number VARCHAR(15)
)
BEGIN
    INSERT INTO Passenger (Name, Date_of_Birth, Gender, Email, Phone_Number)
    VALUES (p_Name, p_Date_of_Birth, p_Gender, p_Email, p_Phone_Number);
END $$

DELIMITER ;
 -- niyonzima maurice 2301000186
 -- create procedure of ticket
 DELIMITER $$

CREATE PROCEDURE BookTicket (
    IN p_Passenger_ID INT,
    IN p_Trip_ID INT,
    IN p_Seat_Number VARCHAR(10),
    IN p_Price DECIMAL(10, 2),
    IN p_Status VARCHAR(50)
)
BEGIN
    INSERT INTO Ticket (Passenger_ID, Trip_ID, Issue_Date, Price, Seat_Number, Status)
    VALUES (p_Passenger_ID, p_Trip_ID, NOW(), p_Price, p_Seat_Number, p_Status);
END $$

DELIMITER ;

-- 2301000186 niyonzima maurice
-- create procedure of trip
DELIMITER $$

CREATE PROCEDURE AddTrip (
    IN p_Departure_City VARCHAR(100),
    IN p_Arrival_City VARCHAR(100),
    IN p_Departure_Date DATETIME,
    IN p_Arrival_Date DATETIME,
    IN p_Train_Bus_Flight VARCHAR(50),
    IN p_Price_Per_Seat DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Trip (Departure_City, Arrival_City, Departure_Date, Arrival_Date, Train_Bus_Flight, Price_Per_Seat)
    VALUES (p_Departure_City, p_Arrival_City, p_Departure_Date, p_Arrival_Date, p_Train_Bus_Flight, p_Price_Per_Seat);
END $$

DELIMITER ;

-- 2301000186  niyonzima maurice
-- create trigger after UID for each table this is passenger
DELIMITER $$

CREATE TRIGGER AfterInsertPassenger
AFTER INSERT ON Passenger
FOR EACH ROW
BEGIN
    -- Example: Log the insertion of a new passenger
    INSERT INTO LogTable (LogMessage, CreatedAt) 
    VALUES (CONCAT('New passenger added: ', NEW.Name), NOW());
END $$

DELIMITER ;
-- 2301000186 niyonzima maurice
-- create trigger  for  this is ticket
DELIMITER $$

CREATE TRIGGER AfterInsertTrip
AFTER INSERT ON Trip
FOR EACH ROW
BEGIN
    -- Example: Log the insertion of a new trip
    INSERT INTO LogTable (LogMessage, CreatedAt) 
    VALUES (CONCAT('New trip added from ', NEW.Departure_City, ' to ', NEW.Arrival_City), NOW());
END $$

DELIMITER ;
-- 2301000186 niyonzima maurice
-- create trigger  for  this is trip

DELIMITER $$

CREATE TRIGGER AfterInsertTrip
AFTER INSERT ON Trip
FOR EACH ROW
BEGIN
    -- Example: Log the insertion of a new trip
    INSERT INTO LogTable (LogMessage, CreatedAt) 
    VALUES (CONCAT('New trip added from ', NEW.Departure_City, ' to ', NEW.Arrival_City), NOW());
END $$

DELIMITER ;

-- niyonzima maurice 2301000186
-- this is the end of my project




 
