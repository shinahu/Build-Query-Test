CREATE DATABASE demo;
USE demo;

/* RELATIONAL SCHEMA
Abdulla shinah 103219744

Task



Tour (TourName, Description)
PRIMARY KEY (TourName)

Client (ClientID, Surname, GivenName, Gender)
PRIMARY KEY (ClientID)

Event (TourName, EventYear, EventMonth, EventDay, Fee)
PRIMARY KEY (TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY (TourName) references Tour

Booking (ClientID, TourName, EventYear, EventMonth, EventDay DateBooked, Payment)
PRIMARY KEY (ClientID, TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY (TourName, EventYear, EventMonth, EventDay) References Event
FOREIGN KEY (ClientID) References Client
 
 
 
  Task 2
 */

IF OBJECT_ID('TOUR') IS NOT NULL
	DROP TABLE TOUR;
IF OBJECT_ID('CLIENT') IS NOT NULL
	DROP TABLE CLIENT;
IF OBJECT_ID('EVENT') IS NOT NULL
	DROP TABLE EVENT;
IF OBJECT_ID('BOOKING') IS NOT NULL
	DROP TABLE BOOKING;

GO

CREATE TABLE Tour
(
    TourName    NVARCHAR(100),
    Description NVARCHAR(500),
    PRIMARY KEY (TourName)
);

CREATE TABLE Client
(
    ClientID    INT,
    Surname     NVARCHAR(100) NOT NULL,
    GivenName   NVARCHAR(100) NOT NULL,
    Gender      NVARCHAR(1) CHECK (Gender in ('M', 'F', 'I')),
    PRIMARY KEY (ClientID)
);

CREATE TABLE Event
(
    TourName    NVARCHAR (100),
    EventYear   INT CHECK (EventYear between 0 and 9999),
    EventMonth  NVARCHAR(3) CHECK (EventMonth in ('Jan','Feb','Mar','Apr','May', 'Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
    EventDay    INT CHECK (EventDay between 1 and 31),
    EventFee    MONEY CHECK (EventFee > 0) NOT NULL,
    PRIMARY KEY (TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY (TourName) References Tour
);

CREATE TABLE Booking
(
    ClientID    INT,
    TourName    NVARCHAR (100),
    EventYear   INT CHECK (EventYear between 0 and 9999),
    EventMonth  NVARCHAR(3) CHECK (EventMonth in ('Jan','Feb','Mar','Apr','May', 'Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
    EventDay    INT CHECK (EventDay between 1 and 31),
    DateBooked  DATE NOT NULL,
    Payment     MONEY CHECK (Payment > 0),
    PRIMARY KEY (ClientID, TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY (TourName, EventYear, EventMonth, EventDay) References Event,
    FOREIGN KEY (ClientID) References Client,
);

INSERT INTO TOUR
    (TourName, Description)
VALUES
    ('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region'),
    ('South', 'Tour of wineries and outlets of Mornington Penisula'),
    ('West', 'Tour of wineries and outlets of the Geelong and Otways region');

INSERT INTO CLIENT 
    (ClientID, Surname, GivenName, Gender)
VALUES
    (1, 'Price', 'Taylor', 'M'),
    (2, 'Gamble', 'Ellyse', 'F'),
    (3, 'Tan', 'Tilly', 'F'),
    (103219744, 'Abdulla', 'Shinah', 'M');


INSERT INTO EVENT
    (TourName, EventYear, EventMonth, EventDay, EventFee)
VALUES
    ('North', 2016, 'Jan', 9, 200),
    ('North', 2016, 'Feb', 13, 225),
    ('South', 2016, 'Jan', 9, 200),
    ('South', 2016, 'Jan', 16, 200),
    ('West', 2016,'Jan', 29, 225);

   
INSERT INTO BOOKING 
    (ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
VALUES
    ( 1, 'North', 2016, 'Jan', 9, '2015-12-10', 200),
    ( 2, 'North', 2016, 'Jan', 9, '2015-12-16', 200),
    ( 1, 'North', 2016, 'Feb', 13, '2016-01-08', 225),
    ( 2, 'North', 2016, 'Feb', 13, '2016-01-14', 125),
    ( 3, 'North', 2016, 'Feb', 13, '2016-02-03', 225),
    ( 1, 'South', 2016, 'Jan', 9, '2015-12-10', 200), 
    ( 2, 'South', 2016, 'Jan', 16, '2015-12-18', 200),
    ( 3, 'South', 2016, 'Jan', 16, '2016-01-09', 200),
    ( 2, 'West',  2016, 'Jan', 29, '2015-12-17', 225),
    ( 3, 'West',  2016, 'Jan', 29, '2015-12-18', 200),
    ( 103219744, 'South', 2016, 'Jan', 16, '2015-12-16', 200),
    ( 103219744, 'West', 2016, 'Jan', 29, '2015-12-16', 255),
    ( 103219744, 'North', 2016, 'Jan', 9, '2015-12-16', 200);

--Task 2--
Select * from client
Select * from Tour
Select * from Event
Select * from Booking 


--Task 3 --

Select * from client


--Task 4 Query 1 Write a query that shows the client first name and surname, 
--the tour name and description,the tour event year, month, day and fee, the booking date and the fee paid for the booking--

SELECT Client.GivenName , CLIENT.Surname , TOUR.TourName , TOUR.Description , EVENT.EventDay , EVENT.EventYear , EVENT.EventMonth ,  EVENT.EventFee , BOOKING.Payment ,  BOOKING.DateBooked
FROM TOUR
INNER JOIN EVENT
ON TOUR.TourName = EVENT.TourName
INNER JOIN BOOKING
ON (EVENT.EventYear = BOOKING.EventYear AND EVENT.EventMonth = BOOKING.EventMonth AND  EVENT.EventDay = BOOKING.EventDay AND EVENT.TourName = BOOKING.TourName)
INNER JOIN CLIENT
ON BOOKING.ClientID = CLIENT.ClientID; 


--Task 4 Query 2 -- Write a query which shows the number of bookings for each (tour event) month, for each
--tour in the following example format

SELECT EVENT.EventMonth , TOUR.TourName , COUNT(*) AS [Num Booking] 
FROM TOUR
INNER JOIN EVENT
ON TOUR.TourName = EVENT.TourName
GROUP BY EVENT.EventMonth , TOUR.TourName
ORDER BY EVENT.EventMonth , TOUR.TourName;


--Task 4 Query 3:Write a query which lists all bookings which have a payment amount greater than the average payment amount. (This query must use a sub-query.)

SELECT *
FROM BOOKING
WHERE Payment > ( SELECT AVG( Payment ) FROM BOOKING );






--Task 5 Create a View based on Query 1 from Task 4--

CREATE VIEW TASK5 AS SELECT C.GivenName, C.Surname, T.TourName, T.DESCRIPTION, E.EventYear, 
E.EventMonth,E.EventDay,E.EventFee, B.DateBooked, B.Payment
FROM Booking B 
​
INNER JOIN Client C
ON B.ClientID = C.ClientID
​
INNER JOIN Event E 
ON B.TourName = E.TourName AND B.EventYear = E.EventYear AND B.EventMonth = E.EventMonth 
AND B.EventDay = E.EventDay
​
INNER JOIN Tour T 
ON E.TourName = T.TourName;


--Task 6 --

​
---Testing Query 1 From Task 4----
​
--- Return same 13 rows of data as per the orginal query task 4 - Query 1
SELECT *
FROM Booking;
​
​
-- Returns Count of rows as 13 - same number of rows in the task 4 - Query 1
SELECT COUNT(*)
FROM Booking;
​
---- Can confirm the query result is correct which is showing 13 rows of data----
​
​
---Testing Query 2 From Task 4----
​
--- Both these test qureies provide 13 results (Rows of data) ---
SELECT * 
FROM Booking;
​
SELECT COUNT(*)
FROM Booking;

--- The result from the query is ---
​
Feb	North	3
Jan	North	3
Jan	South	4
Jan	West	3
​
Total = 3+3+4+3 = 13
​
-- The output of the queries is 13 or 13 rows of data--

--Test Query 3 From Task 4--
​
--The test queries returns count of 4 Rows, which is as the original query Task 4 Query 3 --
SELECT COUNT(Payment)
FROM Booking
WHERE Payment > (SELECT AVG(Payment) FROM Booking);
​
--- calculated the average as 200 from all the data and the result is the same as Task 4 Query No 3--
SELECT *
FROM Booking
WHERE Payment > 200;






