--Create Table
CREATE TABLE HW3 (Depart varchar, Geom geometry);
INSERT INTO HW3 VALUES
	('CS','POINT(-118.28921339975,34.01944301681967)'),
	('BE', 'POINT(-118.28990130059734,34.02032470925064)'),
	('EDUE', 'POINT(-118.28648992045635,34.01860763980641)'),
	('EDUC', 'POINT(-118.28405543699478,34.02202048334887)'),
	('COMM', 'POINT(-118.28663847397765,34.02213612240766)'),
	('JOUR', 'POINT(-118.28721962650663,34.02097098546533)'),
	('SWKC1', 'POINT(-118.28227290847072,34.02228708229806)'),
	('SWKC2', 'POINT(-118.28278657489861,34.02210761530251)'),
	('MBA', 'POINT(-118.2828744990126,34.019289847056626)'),
	('MOR', 'POINT(-118.2853250023115,34.0186049110855)'),
	('ART', 'POINT(-118.28820564326102,34.01946899006574)'),
	('DES', 'POINT(-118.28713530912006,34.0191114793395396)'),
	('HOME', 'POINT(-118.29319464953164,34.02937165442759)');


SELECT Depart, ST_AsText(Geom) FROM HW3;

--Convex Hull
SELECT ST_AsText(ST_ConvexHull(ST_Collect(Geom))) FROM HW3;

--Nearest neighbor from my home
SELECT Depart, ST_Astext(Geom)
FROM HW3
WHERE Depart<>'HOME' 
ORDER BY ST_Distance(Geom,'POINT(-118.29319464953164 34.02937165442759)') 
limit 4;