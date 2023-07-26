REM   Script: CSCI 585 hw2-3 (1)
REM   Q3. Find unique user/s with the total number of paid subscribers greater than 100 for their channel/s created on 01.01.2023. Display the username, email, channel name and the subscriber count.
-- Oracle Live SQL
CREATE TABLE Users( 
  id INTEGER NOT NULL, 
  name VARCHAR(30) NOT NULL, 
  email VARCHAR(30) NOT NULL, 
  PRIMARY KEY (id) 
);

CREATE TABLE Consumer( 
  id INTEGER NOT NULL, 
  subscription_count INTEGER NOT NULL, 
  PRIMARY KEY (id), 
  FOREIGN KEY (id) REFERENCES Users(id) 
);

CREATE TABLE Creator( 
  id INTEGER NOT NULL, 
  subscriber_count INTEGER NOT NULL, 
  PRIMARY KEY (id), 
  FOREIGN KEY (id) REFERENCES Users(id) 
);

CREATE TABLE Channels( 
  id INTEGER NOT NULL, 
  owner INTEGER NOT NULL, 
  name VARCHAR(30) NOT NULL, 
  subscriber_count INTEGER NOT NULL, 
  created_date CHAR(10) NOT NULL, 
  PRIMARY KEY (id), 
  FOREIGN KEY (owner) REFERENCES Creator(id) 
);

CREATE TABLE Subscription( 
  id INTEGER NOT NULL, 
  channel_id INTEGER NOT NULL, 
  subscription_type CHAR(4) NOT NULL, 
  PRIMARY KEY (id,channel_id), 
  FOREIGN KEY (id) REFERENCES Consumer(id), 
  FOREIGN KEY (channel_id) REFERENCES Channels(id) 
);

INSERT INTO Users VALUES (1,'John','john@usc.edu');

INSERT INTO Users VALUES (2, 'Sherry','sherry@usc.edu');

INSERT INTO Creator VALUES (1, 1500);

INSERT INTO Creator VALUES (2, 300);

INSERT INTO Channels VALUES (1, 1, 'database', 500, '01.01.2023');

INSERT INTO Channels VALUES (2, 1, 'sql', 1000, '03.16.2022');

INSERT INTO Channels VALUES (3, 2, 'oracle', 300, '01.01.2023');

DECLARE 
  id INTEGER := 3; 
  channel_id INTEGER := 1; 
  subscribe CHAR (4); 
BEGIN 
  FOR k IN 1..3 
  LOOP 
    FOR i IN 1.. 200 
    LOOP 
      IF i <= 110 THEN 
        subscribe := 'paid'; 
      ELSE 
        subscribe := 'free'; 
      END IF; 
 
      INSERT INTO Users VALUES (id,'TEST', 'test@usc.edu'); 
      INSERT INTO Consumer VALUES (id, 1); 
      INSERT INTO Subscription VALUES (id, k, subscribe); 
      id := id + 1; 
    END LOOP; 
  END LOOP; 
END; 
/
-- First in Subscription table, group by channel id, and then count that in each channel, how many paid subscription
-- This will be a new table with column ['channel id', 'number of paid subscription']
-- Then JOIN users, creators, channels and above new table, so it can know who has the channel which subscriber is more than 100
-- and then filter the table by checking the channel is created on 01-01-2023
SELECT u.name, u.email, c.id, cr.subscriber_count
FROM Users u
INNER JOIN Creator cr ON u.id = cr.id
INNER JOIN Channels c ON c.owner = cr.id
INNER JOIN (
SELECT channel_id, COUNT(CASE WHEN subscription_type = 'paid' THEN 1 ELSE NULL END)
FROM Subscription
GROUP BY channel_id) ON c.id = channel_id
WHERE c.created_date = '01.01.2023';

