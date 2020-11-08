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
 */