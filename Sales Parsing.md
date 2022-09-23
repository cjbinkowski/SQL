### This file analyzes data from a database of sales over several months. The database has a table of customer information, and several tables for product sale details for specified months. I have written queries to find out certain answers to questions about the data
#### Skills Showcased: COUNT, DISTINCT, LIKE, IN, JOIN, GROUP BY, MIN, AVG, data selection to answer specific question about the data
#### How many iPhones were sold in January?
```
SELECT COUNT(*) FROM JanSales
WHERE Product LIKE "%iphone%";
```
#### List the account numbers for each order in February
```
SELECT acctnum 
FROM FebSales s
LEFT JOIN customers c
ON s.orderID=c.order_id;
```
#### What product sold in January had the lowest price
```
SELECT DISTINCT product, price
FROM JanSales
WHERE price IN (SELECT MIN (price) from JanSales);
```
#### What is the revenue for each product sold in January
```
SELECT Product, (price)*sum(Quantity) as Revenue
FROM JanSales
GROUP BY Product;
```
#### Which products were sold in February at 548 Lincoln St., how many were sold, and what was the revenue 
```
SELECT location, Product, sum(quantity) as Number_sold, sum(quantity)*price as revenue
FROM FebSales
WHERE location LIKE "%548 Lincoln%"
GROUP BY product;
```
#### How many accounts bought more than 2 items in an order in February and what was the average amount spent
```
SELECT COUNT (acctnum) , AVG(price*quantity)
FROM FebSales f
LEFT JOIN customers c
ON f.orderID = c.order_id
WHERE Quantity >2;
```
#### What products were sold in Los Angeles and how many of each were sold
``` SELECT product, SUM(quantity)
FROM FebSales
WHERE location LIKE "%Los Angeles%"
GROUP BY product;
```
