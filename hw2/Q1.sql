REM   Script: CSCI 585 hw2-1
REM   Find the sponsor who has sponsored the highest amount in YouTube. Display the sponsors name, phone number and the total sponsored
-- Oracle Live SQL
CREATE TABLE Sponsor 
( SponsorId CHAR(10) NOT NULL, 
  Name VARCHAR(20) NOT NULL, 
  Phone CHAR(10), 
  Address VARCHAR(100), 
  Amount_sponsored INTEGER NOT NULL, 
  PRIMARY KEY (SponsorId) 
);

INSERT INTO Sponsor VALUES ('1921352348', 'Tony', '3049234919', '1492 W 28 St. Los Angeles, California', 10000);
INSERT INTO Sponsor VALUES ('1931352234', 'John', '3069394116', '1492 E 39 St. Los Angeles, California', 2000);
INSERT INTO Sponsor VALUES ('1453353248', 'Cherry', '1059224932', '1492 N 21 St. Los Angeles, California', 1000);

-- First find the max sponsor in the table and return the value
-- then filter the table by determining that the sponsor amount is same to the return value
-- print the name, the phone number and the amount sponsor
SELECT Name,Phone, Amount_sponsored 
FROM Sponsor 
WHERE Amount_sponsored = ( SELECT Max(Amount_sponsored) 
                           FROM Sponsor);

