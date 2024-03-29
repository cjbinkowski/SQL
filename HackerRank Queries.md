### Included are a collection of challenges from HackerRank and the queries I created to solve them.
#### Skills Showcased: LIKE with brackets, String functions, answering mathematical questions, CAST, SQRT, POWER, String Query Outputs, CASE to make categories
### ~Easier Prompts
**Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates**
```
SELECT DISTINCT CITY 
  FROM STATION
  WHERE CITY LIKE '[AEIOU]%';
```  
**Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates**
```
SELECT DISTINCT CITY 
  FROM STATION
  WHERE CITY LIKE '%[AEIOU]';
```
**Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.**
```
SELECT DISTINCT CITY 
  FROM STATION 
  WHERE CITY LIKE '[AEIOU]%[AEIOU]'
```  
**Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.**
```
SELECT DISTINCT CITY 
  FROM STATION
  WHERE CITY LIKE '[^AEIOU]%';
```  
### ~More Complex Prompts 
 **Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.**
```
SELECT NAME 
  FROM STUDENTS
  WHERE MARKS > 75 
  ORDER BY RIGHT(NAME,3), ID ASC;
```  
**Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.**
 
 a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 
 b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 
 c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 
 d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
 
 **Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places.**
```
SELECT 
  ABS(
    ROUND(
      MIN(LAT_N)-MAX(LAT_N)+(MIN(LONG_W)-MAX(LONG_W))
      ,4)
      )
      FROM STATION;
```      
**Consider P1(a,c) and P2(b,d) to be two points on a 2D plane where a and b are the respective minimum and maximum values of Northern Latitude (LAT_N) and c and d are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.**

Query the Euclidean Distance between points P1 and P2 and format your answer to display 4 decimal digits.
```
SELECT 
CAST(
  ROUND(
    SQRT(
      POWER(MAX(LAT_N)-MIN(LAT_N),2) + POWER(MAX(LONG_W)-MIN(LONG_W),2)
      )
    ,4) 
  AS DECIMAL (8,4)
  )  
  FROM STATION;
```  
**Generate the following two result sets:**

1.Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).

2.Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
                    There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically. 

```
SELECT CONCAT (Name,'(',LEFT(Occupation,1),')') AS List
FROM OCCUPATIONS 
ORDER BY LIST; 
```
```
SELECT CONCAT
  ('There are a total of ',
  COUNT(Occupation),
  ' ',
  LOWER(Occupation), 
  's',
  '.')
FROM Occupations 
GROUP BY Occupation
ORDER BY COUNT(Occupation), Occupation;
```
**You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.**

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.

Leaf: If node is leaf node.

Inner: If node is neither root nor leaf node.
```
SELECT N, CASE
  WHEN P IS NULL THEN 'Root' 
  WHEN N IN SELECT P FROM BST) THEN 'Inner' 
  ELSE 'Leaf' 
  END
FROM BST
ORDER BY N;
```
