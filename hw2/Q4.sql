--REM   Script: CSCI 585 hw2-4
--REM   Find the average sentiment score for each keyword category. Display the keyword name along with average score such that the highest score is displayed first.
-- Oracle Live SQL
CREATE TABLE Videos( 
  URL VARCHAR(50) NOT NULL, 
  category VARCHAR(10) NOT NULL, 
  PRIMARY KEY (URL) 
);

CREATE TABLE InfoVideos( 
  URL VARCHAR(50) NOT NULL, 
  keyword VARCHAR(20) NOT NULL, 
  PRIMARY KEY (URL), 
  FOREIGN KEY (URL) REFERENCES Videos(URL) 
);

CREATE TABLE Comments( 
  URL VARCHAR(50) NOT NULL, 
  comment_id INTEGER NOT NULL, 
  sentiment INTEGER NOT NULL, 
  PRIMARY KEY (URL,comment_id), 
  FOREIGN KEY (URL) REFERENCES Videos(URL) 
);

INSERT INTO Videos VALUES ('https://www.youtube.com/basketballLife', 'INFO');
INSERT INTO Videos VALUES ('https://www.youtube.com/database','INFO');
INSERT INTO Videos VALUES ('https://www.youtube.com/guitarPlaying','INFO');
INSERT INTO Videos VALUES ('https://www.youtube.com/SQL','INFO');
INSERT INTO Videos VALUES ('https://www.youtube.com/baseball','INFO');
INSERT INTO Videos VALUES ('https://www.youtube.com/sing','INFO');

INSERT INTO InfoVideos VALUES ('https://www.youtube.com/basketballLife', 'sports');
INSERT INTO InfoVideos VALUES ('https://www.youtube.com/database','database');
INSERT INTO InfoVideos VALUES ('https://www.youtube.com/guitarPlaying','music');
INSERT INTO InfoVideos VALUES ('https://www.youtube.com/SQL','database');
INSERT INTO InfoVideos VALUES ('https://www.youtube.com/baseball','sports');
INSERT INTO InfoVideos VALUES ('https://www.youtube.com/sing','music');

INSERT INTO Comments VALUES ('https://www.youtube.com/basketballLife', 1, 85);
INSERT INTO Comments VALUES ('https://www.youtube.com/database', 1, 100);
INSERT INTO Comments VALUES ('https://www.youtube.com/guitarPlaying', 1, 80);
INSERT INTO Comments VALUES ('https://www.youtube.com/SQL', 2, 90);
INSERT INTO Comments VALUES ('https://www.youtube.com/baseball', 2, 70);
INSERT INTO Comments VALUES ('https://www.youtube.com/sing', 2, 60);

-- JOIN comments table and infoVideos and Videos
-- filter the table that the video is a information video
-- group the table with the keyword, and then can calculate the average of sentiment of each video
-- and finally print the ans in descent order
SELECT keyword, AVG(sentiment) as avg_sent
FROM InfoVideos i 
JOIN Comments c ON i.URL = c.URL 
JOIN Videos v ON v.URL = i.URL
WHERE v.category = 'INFO'
GROUP BY keyword
ORDER BY avg_sent DESC;
