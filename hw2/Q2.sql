REM   Script: CSCI 585 hw2-2
REM   find the ratio of likes to views of each video belonging to any of the channels owned by users having the word "Marvel Entertainment" in them. Display the Video Title, channel name and the ration in the ascending order of the title
-- Oracle Live SQL
CREATE TABLE Channels ( 
  id INTEGER NOT NULL, 
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Videos ( 
  id INTEGER NOT NULL, 
  title VARCHAR(30) NOT NULL, 
  channel_id INTEGER NOT NULL, 
  PRIMARY KEY (id),
  FOREIGN KEY (channel_id) REFERENCES Channels(id) 
);

CREATE TABLE Statistics(
  video_id INTEGER NOT NULL, 
  likes INTEGER NOT NULL,
  views INTEGER NOT NULL,
  PRIMARY KEY (video_id),
  FOREIGN KEY (video_id) REFERENCES Videos(id)
);
  
INSERT INTO Channels VALUES (1, 'Marvel Entertainment interesting');
INSERT INTO Channels VALUES (2, 'Hi! Marvel Entertainment');

INSERT INTO Videos VALUES (1, 'Video 1', 1);
INSERT INTO Videos VALUES (2, 'Video 2', 1);
INSERT INTO Videos VALUES (3, 'Video 3', 2);

INSERT INTO Statistics VALUES (1, 100, 10000);
INSERT INTO Statistics VALUES (2, 500, 10000);
INSERT INTO Statistics VALUES (3, 300, 20000);

-- First, JOIN the channels, videos table and statistics table
-- then filter the table by channel names containing the 'Marvel Entertainment'
-- the calculate the ration of likes to views of each video
-- print in the ascending order
SELECT v.title, c.name AS channel_name, CAST(s.likes AS FLOAT) / s.views AS ratio 
FROM Videos v
JOIN Channels c ON v.channel_id = c.id 
JOIN Statistics s ON v.id = s.video_id
WHERE c.name LIKE '%Marvel Entertainment%'
ORDER BY ratio ASC;
