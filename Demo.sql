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


--Task 3 --

Select * from client