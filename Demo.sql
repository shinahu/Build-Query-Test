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
