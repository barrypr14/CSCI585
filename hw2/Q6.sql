-- Oracle Live SQL
CREATE TABLE Users( 
  id INTEGER NOT NULL, 
  name VARCHAR(20) NOT NULL, 
  address VARCHAR(50), 
  PRIMARY KEY (id) 
);

CREATE TABLE Creators( 
  id INTEGER NOT NULL, 
  subscriber_count INTEGER NOT NULL, 
  PRIMARY KEY (id), 
  FOREIGN KEY (id) REFERENCES Users(id) 
);

CREATE TABLE Channels( 
  id INTEGER  NOT NULL, 
  owner INTEGER NOT NULL, 
  name VARCHAR(50) NOT NULL, 
  PRIMARY KEY (id), 
  FOREIGN KEY (owner) REFERENCES Creators (id) 
);

CREATE TABLE Videos( 
  id INTEGER NOT NULL, 
  uploader_id INTEGER NOT NULL, 
  upload_date DATE NOT NULL, 
  PRIMARY KEY (id),  
  FOREIGN KEY (uploader_id) REFERENCES Channels(id) 
);

INSERT INTO Users VALUES (1, 'John', '1432 W 37 St. LA, CA, US');
INSERT INTO Users VALUES (2, 'Sherry', '1232 W 28 St. LA, CA, US');
INSERT INTO Users VALUES (3, 'Barry', '12 13F, Jeifeng S Rd. Hinchu City, ROC');

INSERT INTO Creators VALUES (1,500);
INSERT INTO Creators VALUES (2,900);
INSERT INTO Creators VALUES (3,700);

INSERT INTO Channels VALUES (1, 1, 'database');
INSERT INTO Channels VALUES (2, 1, 'music');
INSERT INTO Channels VALUES (3, 2, 'USC');
INSERT INTO Channels VALUES (4, 3, 'basketball');

INSERT INTO Videos VALUES (1, 1, TO_DATE('2022-01-03', 'YYYY-MM-DD'));
INSERT INTO Videos VALUES (2, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Videos VALUES (3, 1, TO_DATE('2022-01-15', 'YYYY-MM-DD'));
INSERT INTO Videos VALUES (4, 1, TO_DATE('2022-01-24', 'YYYY-MM-DD'));

INSERT INTO Videos VALUES (5, 2, TO_DATE('2022-01-08', 'YYYY-MM-DD'));
INSERT INTO Videos VALUES (6, 2, TO_DATE('2022-01-19', 'YYYY-MM-DD'));

INSERT INTO Videos VALUES (7, 3, TO_DATE('2022-01-11', 'YYYY-MM-DD'));

INSERT INTO Videos VALUES (8, 4, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Videos VALUES (9, 4, TO_DATE('2022-01-08', 'YYYY-MM-DD'));
INSERT INTO Videos VALUES (10, 4, TO_DATE('2022-01-15', 'YYYY-MM-DD'));
INSERT INTO Videos VALUES (11, 4, TO_DATE('2022-01-22', 'YYYY-MM-DD'));
INSERT INTO Videos VALUES (12, 4, TO_DATE('2022-01-29', 'YYYY-MM-DD'));

-- The first thing to do is to filter the channel which has uploaded the video at least every week
-- then using UNION to combine this 5 table. 
-- And then count the channel id in the table. If the value isn't less than 4,
-- it means the channel has uploaded the video at least once every week. 
-- Then return the channel id to filter the target channel name, owner name, and its subscriber_count
SELECT u.name, c.name, cr.subscriber_count   
FROM Channels c, Creators cr, Users u   
WHERE c.owner = cr.id AND cr.id = u.id  AND u.address LIKE '%US%' 
AND c.id IN (SELECT uploader_id   
FROM   
(SELECT v.uploader_id, COUNT (DISTINCT TRUNC(v.upload_date,'IW')) as upload_weeks   
FROM Videos v   
WHERE v.upload_date BETWEEN TO_DATE('2022-01-01','YYYY-MM-DD') AND TO_DATE('2022-01-07','YYYY-MM-DD')   
GROUP BY v.uploader_id   
UNION ALL   
SELECT v.uploader_id, COUNT (DISTINCT TRUNC(v.upload_date,'IW')) as upload_weeks   
FROM Videos v   
WHERE v.upload_date BETWEEN TO_DATE('2022-01-08','YYYY-MM-DD') AND TO_DATE('2022-01-14','YYYY-MM-DD')   
GROUP BY v.uploader_id   
UNION ALL   
SELECT v.uploader_id, COUNT (DISTINCT TRUNC(v.upload_date,'IW')) as upload_weeks   
FROM Videos v   
WHERE v.upload_date BETWEEN TO_DATE('2022-01-15','YYYY-MM-DD') AND TO_DATE('2022-01-21','YYYY-MM-DD')   
GROUP BY v.uploader_id   
UNION ALL   
SELECT v.uploader_id, COUNT (DISTINCT TRUNC(v.upload_date,'IW')) as upload_weeks   
FROM Videos v   
WHERE v.upload_date BETWEEN TO_DATE('2022-01-22','YYYY-MM-DD') AND TO_DATE('2022-01-28','YYYY-MM-DD')   
GROUP BY v.uploader_id   
UNION ALL   
SELECT v.uploader_id, COUNT (DISTINCT TRUNC(v.upload_date,'IW')) as upload_weeks   
FROM Videos v   
WHERE v.upload_date BETWEEN TO_DATE('2022-01-29','YYYY-MM-DD') AND TO_DATE('2022-01-31','YYYY-MM-DD')   
GROUP BY v.uploader_id   
) combine_table   
GROUP BY uploader_id   
HAVING COUNT(*) >= 4);

