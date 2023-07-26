--REM   Script: CSCI 585 hw2-5
--REM   Find the minimum and maximum age of viewers who watched the most commented on video on Taylor Swift channel. Display the video title, minimum age and the maximum age
-- Oracle Live SQL

CREATE TABLE Users( 
  id INTEGER NOT NULL, 
  age INTEGER, 
  PRIMARY KEY (id) 
);

CREATE TABLE Channels( 
  id INTEGER NOT NULL, 
  name VARCHAR(20) NOT NULL, 
  PRIMARY KEY (id) 
);

CREATE TABLE Videos( 
  URL VARCHAR(50) NOT NULL, 
  uploader_id INTEGER NOT NULL, 
  title VARCHAR(30) NOT NULL, 
  PRIMARY KEY (URL), 
  FOREIGN KEY (uploader_id) REFERENCES Channels(id) 
);

CREATE TABLE Comments( 
  id INTEGER NOT NULL, 
  URL VARCHAR(50) NOT NULL, 
  commenter_id INTEGER NOT NULL, 
  PRIMARY KEY (id,URL), 
  FOREIGN KEY (URL) REFERENCES Videos(URL), 
  FOREIGN KEY (commenter_id) REFERENCES Users(id) 
);
--insert two channels created by different people
INSERT INTO Channels VALUES (1,'Taylor Swift');
INSERT INTO Channels VALUES (2,'Justin Bieber');

INSERT INTO Videos VALUES ('https://www.youtube.com/Shake_it_off',1,'Shake It Off');
INSERT INTO Videos VALUES ('https://www.youtube.com/Anti_Hero',1,'Anti-Hero');
INSERT INTO Videos VALUES ('https://www.youtube.com/love_story',1,'Love Story');
INSERT INTO Videos VALUES ('https://www.youtube.com/22',1,'22');
INSERT INTO Videos VALUES ('https://www.youtube.com/baby',2,'Baby');

DECLARE 
  URL VARCHAR(50); 
BEGIN  
  FOR i IN 1..120 LOOP 
    IF i <= 20 THEN 
      URL := 'https://www.youtube.com/Shake_it_off'; 
    ELSIF i <= 70 THEN 
      URL := 'https://www.youtube.com/Anti_Hero'; 
    ELSIF i <= 80 THEN 
      URL := 'https://www.youtube.com/love_story'; 
    ELSIF i <= 100 THEN 
      URL := 'https://www.youtube.com/22'; 
    ELSE  
      URL := 'https://www.youtube.com/baby'; 
    END IF; 
    INSERT INTO Users VALUES (i,i); 
    INSERT INTO Comments VALUES (i,URL,i); 
  END LOOP; 
END; 
/

INSERT INTO Comments VALUES (1,'https://www.youtube.com/Anti_Hero',5);
INSERT INTO Comments VALUES (2,'https://www.youtube.com/Anti_Hero',90);

-- First, in comments table, group it by videoURL to count the comments in each video
-- Return the max value 
-- Join the Comments, Videos, Users, Channels, then group, so every row contain the 
-- every comments in which video and commented by who and this video is owned by which channel
-- then group by the video, and Count the number of comment
-- if the number of comment is same to the first step I return
-- then this video is what I want to find
-- so print the videl title, and it max age and min age of viewers.

SELECT title, MAX(age), MIN(age) 
FROM Comments c 
LEFT JOIN Videos v ON c.URL = v.URL 
LEFT JOIN Users u ON c.commenter_id = u.id 
LEFT JOIN Channels ch ON ch.id = v.uploader_id
WHERE ch.name = 'Taylor Swift'
GROUP BY v.title 
HAVING COUNT(*) = (
SELECT MAX(numberOFcount)
FROM
(SELECT URL, COUNT(*) AS numberOFcount
FROM Comments c
GROUP BY URL));

