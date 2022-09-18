### This database and analysis was created in SQLite Studio to track how each player performs over the season. Points are determined by rules followed by a family competition where a family member picks a player for each series and collects points with the player. Hopefully this will help get me above last place, which is where I ranked last season.

### I have created corresponding Tableau dashboards for this project which can be found at https://public.tableau.com/app/profile/christina.binkowski

#### Creation of data tables
```
CREATE TABLE Players
(ID integer Primary Key,
First_Name text NOT NULL,
Last_Name text NOT NULL);
```
```
CREATE TABLE Games
(Game_ID integer PRIMARY KEY,
Opponent text NOT NULL,
Pitcher_Name text NOT NULL,
Pitcher_Arm text NOT NULL,
Date integer);
```
```
CREATE TABLE Result
(Game_ID integer NOT NULL,
Player_ID integer NOT NULL,
Points integer NOT NULL,
First text,
Second text,
Third text,
Fourth text,
Fifth text) ;
```
First, etc., refer to what was done at each at bat. Columns will often have NULL values due to variation in at bats per game


``ALTER TABLE Results ADD COLUMN RBIs integer DEFAULT 0;``

``ALTER TABLE Results ADD COLUMN Runs integer DEFAULT 0;``

These columns were overlooked when first creating the table so they were just added on afterwards. Setting Default to 0 means there will always be a value. Otherwise when no Runs or RBIs were achieved, setting to 0 might be forgotten.*/

#### Inserting Data
```
INSERT INTO Players (First_Name, Last_Name) 
VALUES 
('Robbie', 'Grossman'),
('Austin', 'Meadows'),
('Javier', 'Baez'),
('Jeimer', 'Candelario'),
('Miguel', 'Cabrera'),
('Johnathan', 'Schoop'),
('Akil', 'Baddoo'),
('Spencer', 'Torkelson');
```

``SELECT * FROM Players;
I wasn't sure if the ID would autoincrement so I checked here before adding the rest of the players
```
INSERT INTO Players (First_Name, Last_Name)
VALUES
('Tucker', 'Barnhart'),
('Eric', 'Haase'),
('Victor', 'Reyes'),
('Harold', 'Castro'),
('Dustin', 'Garneau'),
('Willi', 'Castro'),
('Daz', 'Cameron'),
('Derek', 'Hill');
```
```
INSERT INTO Games (Opponent, Pitcher_Name, Pitcher_arm, date)
VALUES 
('White Sox', 'Graveman', 'R', 0408),
('White Sox','Cease', 'R', 0409),
('White Sox','Kopech', 'R', 0410,
('Red Sox', 'Wacha', 'R', 0411),
('Red Sox', 'Hill', 'L', 0412),
('Red Sox', 'Eovaldi', 'R', 0411),
('Royals', 'Greinke', 'R', 0414),
('Royals', 'Keller', 'R', 0415),
('Royals', 'Bubic', 'L', 0416),
('Yankees', 'Cole', 'R', 0419),
('Yankees', 'Severino', 'R', 0420),
('Yankees', 'Montgomery', 'L', 0421),
('Rockies', 'Senzatela', 'R', 0423),
('Rockies', 'Gomber', 'L', 0423),
('Rockies', 'Kuhl' ,' R', 0424;
```
```
INSERT INTO Results 
VALUES (1, 1, 3, 'BB', 'K', 'HBP', '1B', 'K', 2,0),
(1, 2, 8, 'FO', 'BB', 'BB', 'BB', '3B', 2, 0),
(1, 3, 1, 'K', 'K', 'FO', '1B', '1B', 0,1),
(1, 4, 1, 'FO', 'FO', '1B', '1B',NULL , 0, 1),
(1, 5, 2, 'K', 'GO', '?', '1B',NULL , 0, 2),
(1, 6, 3, '2B', 'FO', 'GO', 'HBP', NULL, 0,0 ),
(1, 7, -1, 'K', 'FO', 'PO', 'GO',NULL,0, 0),
(1, 8, -2, 'PO', 'FO', 'K', 'K' , NULL,0 ,0),
(1, 9, -2, 'K', 'GO', 'K',NULL ,NULL, 0, 0),
(1, 10, 6,NULL ,NULL ,NULL ,'HR',NULL ,1,1);
  ```
**I input each games data into the Results table with the same formatting**

##### One game I incorrectly Game 8 data with a Game 5 ID (before actually inputting Game 5 data) so I used the following to fix the mistake
```
UPDATE Results
  SET Game_ID = '8'
  WHERE Game_ID=5;
  ```
#### Analyzing Stats
Joining all three tables and showing point totals for each player against a left-handed pitcher when the player is in the starting line-up
```
SELECT First_Name, Last_Name, Sum(Points) 
FROM
  Results R
  JOIN
    Players P
    ON R.Player_ID=P.ID
  JOIN
    Games G
    ON R.Game_ID=G.Game_ID
WHERE R.First NOT NULL
  AND Pitcher_Arm LIKE '%L%'
Group BY P.ID;
```
For each game, I add a WHERE statement that shows only players that are in the lineup:
`` WHERE/AND Player_ID IN (1,2,3,4) ``

I have utilized other WHERE statements in place of pitcher arm when analyzing player performance, which include
`` WHERE/AND Opponent = 'White Sox' ``
`` WHERE/AND Date > 0800 ``

(Use of WHERE or AND depending on if it is the sole WHERE statement or not)

##### Outputting the total strikeout count for each player over all games
```
SELECT P.Last_Name, 
COUNT(K1) + COUNT(K2) + COUNT(K3) + COUNT(K4) + COUNT(K5) AS K 
FROM 
  (SELECT P.Last_Name, 
  CASE
    WHEN R.First='K' THEN 'K'
    END AS K1,
  CASE   
    WHEN R.Second='K' THEN 'K' 
    END AS K2,
  CASE   
    WHEN R.Third='K' THEN 'K' 
    END AS K3,
  CASE 
    WHEN R.Fourth='K' THEN 'K' 
    END AS K4,
  CASE 
    WHEN R.Fifth='K' THEN 'K'
    END AS K5
  FROM Results R 
   JOIN Players P 
   ON P.ID=R.PLAYER_ID)
GROUP BY LAST_NAME
ORDER BY K;
```
Adding to the previous query, I introduced a game count (of games each player actually played in) by adding a select of game_id in the innermost select, added a game_id count, then introduced a new select for the calculation. This way, I could determine strikeout per game ratio. Since the numbers are categorized as integers, 'cast as float' was needed to return a decimal rather than an integer.
```
SELECT LAST_NAME, ROUND(CAST(K as FLOAT) / CAST(GAMES as FLOAT),3) as K_ratio 
 FROM (SELECT LAST_NAME, (COUNT(K1)+COUNT(K2)+COUNT(K3)+COUNT(K4)+COUNT(K5)) AS K, COUNT(GAME_ID) AS GAMES 
  FROM 
   (SELECT LAST_NAME, GAME_ID, 
   CASE
    WHEN First='K' THEN 'K' END AS K1,
   CASE    
    WHEN Second='K' THEN 'K' END AS K2,
   CASE
    WHEN Third='K' THEN 'K' END AS K3,
   CASE 
    WHEN Fourth='K' THEN 'K' END AS K4,
   CASE
    WHEN Fifth='K' THEN 'K' END AS K5
  FROM RESULTS R JOIN PLAYERS P ON P.ID=R.PLAYER_ID)
 GROUP BY LAST_NAME)
ORDER BY K_ratio;
   ```
Outputting the Average Points Per Game versus a Left handed pitcher or a Right handed pitcher. I used a CTE here in order to have two queries for calling on points, one for each pitching type. 
```
WITH Right AS
(SELECT pp.first_name, avg(points) as RPoint 
  FROM Results rr 
  JOIN 
    Games gg ON rr.game_id=gg.game_id 
  JOIN 
    Players pp ON pp.id=rr.player_id
  WHERE Pitcher_Arm='R'
  GROUP BY pp.first_name)

SELECT p.First_Name, p.Last_Name, ROUND(AVG(Points),3) AS PPG_vs_L, ROUND(RPoint,3) AS PPG_vs_R
FROM Right
JOIN
  Results r ON Right.First_Name=p.First_Name
JOIN
  Players p ON r.Player_ID=p.ID
JOIN 
  Games g ON r.Game_ID=g.Game_ID
WHERE Pitcher_Arm ='L'
GROUP BY p.First_Name;
```
