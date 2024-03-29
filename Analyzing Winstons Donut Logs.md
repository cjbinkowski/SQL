### This document includes a table name winstons_donut_logs which was created by another individual. I used this data to create queries that show significant details about that data while practicing SQL skills
#### Skills Showcased: Table creation, data insertion, GROUP BYs, multiple aggregate functions, CASE queries nested SELECTs, ORDER BYs

#### ~Table creation 
```
CREATE TABLE winstons_donut_logs (
    id TEXT PRIMARY KEY,
    status TEXT,
    years_old INTEGER,
    donuts_eaten INTEGER,
    reason TEXT
    );
INSERT INTO winstons_donut_logs VALUES (0, "new born winston lvl 0", 0, 0, "");
INSERT INTO winstons_donut_logs VALUES (1, "baby winston lvl1", 1, 10, "(Gummed)");
INSERT INTO winstons_donut_logs VALUES (2, "baby winston lvl2", 2, 40, "(Gummed)");
INSERT INTO winstons_donut_logs VALUES (3, "baby winston lvl3", 3, 50, "(Gummed)");
INSERT INTO winstons_donut_logs VALUES (4, "toddler winston lvl1", 4, 300, "");
INSERT INTO winstons_donut_logs VALUES (5, "toddler winston lvl2", 5, 400, "");
INSERT INTO winstons_donut_logs VALUES (6, "kid winston lvl1", 6, 1200, "");
INSERT INTO winstons_donut_logs VALUES (7, "kid winston lvl2", 7, 1000, "");
INSERT INTO winstons_donut_logs VALUES (8, "kid winston lvl3", 8, 1000, "");
INSERT INTO winstons_donut_logs VALUES (9, "kid winston lvl4", 9, 1000, "");
INSERT INTO winstons_donut_logs VALUES (10, "winstween lvl1", 10, 1500, "");/** tween means someone between 10 and 12 so I did winstween- tween not teen**/
INSERT INTO winstons_donut_logs VALUES (11, "winstween lvl2", 11, 500, "Braces");
INSERT INTO winstons_donut_logs VALUES (12, "winstween lvl3", 12, 300, "Braces");
INSERT INTO winstons_donut_logs VALUES (13, "winsteen lvl1", 13, 400, "Braces");
INSERT INTO winstons_donut_logs VALUES (14, "winsteen lvl2", 14, 1300, "No Braces");
INSERT INTO winstons_donut_logs VALUES (15, "winsteen lvl3", 15, 2000, "");
INSERT INTO winstons_donut_logs VALUES (16, "winsteen lvl4", 16, 2000, "");
INSERT INTO winstons_donut_logs VALUES (17, "winsteen lvl5", 17, 2000, "");
INSERT INTO winstons_donut_logs VALUES (18, "winsteen lvl6", 18, 2000, "");
INSERT INTO winstons_donut_logs VALUES (19, "winsteen lvl7", 19, 2000, "");
INSERT INTO winstons_donut_logs VALUES (20, "young adult winston lvl1", 20, 2000, "");
INSERT INTO winstons_donut_logs VALUES (21, "young adult winston lvl2", 21, 2500, "");
INSERT INTO winstons_donut_logs VALUES (22, "young adult winston lvl3", 22, 2500, "");
INSERT INTO winstons_donut_logs VALUES (23, "young adult winston lvl4", 23, 2500, "");
INSERT INTO winstons_donut_logs VALUES (24, "young adult winston lvl5", 24, 2500, "");
INSERT INTO winstons_donut_logs VALUES (25, "young adult winston lvl6", 25, 2500, "");
INSERT INTO winstons_donut_logs VALUES (26, "young adult winston lvl7", 26, 2500, "");
INSERT INTO winstons_donut_logs VALUES (27, "young adult winston lvl8", 27, 2500, "");
INSERT INTO winstons_donut_logs VALUES (28, "young adult winston lvl9", 28, 2500, "");
INSERT INTO winstons_donut_logs VALUES (29, "young adult winston lvl10", 29, 2500, "");
INSERT INTO winstons_donut_logs VALUES (30, "mature adult winston lvl1", 30, 2500, "");
INSERT INTO winstons_donut_logs VALUES (31, "mature adult winston lvl2", 31, 2500, "");
INSERT INTO winstons_donut_logs VALUES (32, "mature adult winston lvl3", 32, 2500, "");
INSERT INTO winstons_donut_logs VALUES (33, "mature adult winston lvl4", 33, 2500, "");
INSERT INTO winstons_donut_logs VALUES (34, "mature adult winston lvl5", 34, 2500, "");
INSERT INTO winstons_donut_logs VALUES (35, "mature adult winston lvl6", 35, 1500, "Healthier Eating");
INSERT INTO winstons_donut_logs VALUES (36, "mature adult winston lvl7", 36, 1500, "Healthier Eating");
INSERT INTO winstons_donut_logs VALUES (37, "mature adult winston lvl8", 37, 1500, "Healthier Eating");
INSERT INTO winstons_donut_logs VALUES (38, "mature adult winston lvl9", 38, 1500, "Healthier Eating");
INSERT INTO winstons_donut_logs VALUES (39, "mature adult winston lvl10", 39, 1500, "Healthier Eating");
INSERT INTO winstons_donut_logs VALUES (40, "middle-aged adult winston lvl1", 40, 2500, "Non-healthy eating");
INSERT INTO winstons_donut_logs VALUES (41, "middle-aged adult winston lvl2", 41, 2500, "");
INSERT INTO winstons_donut_logs VALUES (42, "middle-aged adult winston lvl3", 42, 2500, "");
INSERT INTO winstons_donut_logs VALUES (43, "middle-aged adult winston lvl4", 43, 2500, "");
INSERT INTO winstons_donut_logs VALUES (44, "middle-aged adult winston lvl5", 44, 300, "Diet");
INSERT INTO winstons_donut_logs VALUES (45, "middle-aged adult winston lvl6", 45, 200, "Diet");
INSERT INTO winstons_donut_logs VALUES (46, "middle-aged adult winston lvl7", 46, 150, "Diet");
INSERT INTO winstons_donut_logs VALUES (47, "middle-aged adult winston lvl8", 47, 150, "Diet");
INSERT INTO winstons_donut_logs VALUES (48, "middle-aged adult winston lvl9", 48, 150, "Diet");
INSERT INTO winstons_donut_logs VALUES (49, "middle-aged adult winston lvl10", 49, 150, "Diet");
INSERT INTO winstons_donut_logs VALUES (50, "old-ish adult winston lvl1", 50, 2500, "No diet");
INSERT INTO winstons_donut_logs VALUES (51, "old-ish adult winston lvl2", 51, 2500, "");
INSERT INTO winstons_donut_logs VALUES (52, "old-ish adult winston lvl3", 52, 2500, "");
INSERT INTO winstons_donut_logs VALUES (53, "old-ish adult winston lvl4", 53, 1436, "Current age");
```
#### ~Creating a list of reasons and the average of donuts eaten in the corresponding years
```
SELECT reason from winstons_donut_logs GROUP BY reason;
```
  used to find all reasons listed

```
select count(*),
ROUND( AVG (donuts_eaten)) AS AVG_donuts_eaten, reason 
FROM winstons_donut_logs 
WHERE reason LIKE "%eating%" 
    OR reason LIKE "%diet%"
    OR reason LIKE "%gum%" 
    OR reason like ""
    OR reason LIKE "%age%"
    OR reason LIKE "%braces%"
GROUP BY reason
ORDER BY AVG_donuts_eaten DESC;
```
#### ~Showing donuts eaten in the years of an age range and the average donuts eaten per year in that age range
```
SELECT  SUM(donuts_eaten) AS donuts_eaten_by_agegroup, ROUND(AVG (donuts_eaten)) AS avg_eaten_yearly ,
CASE
    WHEN years_old <11 THEN "10 and under"
    WHEN years_old <21 THEN "10 to 20"
    WHEN years_old < 31 THEN "21 to 30"
    WHEN years_old <41 THEN "31 to 40"
    WHEN years_old <51 THEN "41 to 50"
    ELSE "over 50"
    END AS Age_group
FROM winstons_donut_logs
GROUP BY Age_group
ORDER BY donuts_eaten_by_agegroup DESC;
```
#### ~Finding total number of donuts eaten over all years
```
SELECT SUM(donuts_eaten) AS Total_donuts_eaten 
FROM winstons_donut_logs;
```

#### ~Finding ages when the max amount of donuts were eaten
```
SELECT years_old AS Years_when_ate_max, reason 
FROM winstons_donut_logs
WHERE donuts_eaten=(SELECT MAX(donuts_eaten) FROM winstons_donut_logs);
```
#### ~Showing ages when fewer donuts were eaten than the average, the donuts eaten in those years, and reasons given
```
SELECT years_old AS below_avg_years, donuts_eaten, reason 
FROM winstons_donut_logs 
WHERE donuts_eaten < (SELECT ROUND(AVG(donuts_eaten)) FROM winstons_donut_logs)
ORDER BY donuts_eaten;
```
#### ~Finding ages when a reason stating healthy eating/diet concerns resulted in eating fewer donuts than average
```
SELECT years_old AS Years_diet_helped
FROM winstons_donut_logs
WHERE (donuts_eaten < (SELECT ROUND(AVG(donuts_eaten)) FROM  winstons_donut_logs)) 
AND (reason LIKE "diet" OR reason LIKE "healthier%") ;
```
