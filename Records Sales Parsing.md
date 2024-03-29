#### SQLite Studio and a sample database were used in this project. The Database contains 11 tables named (albums, artists, customers, employees, genres, invoice_items, invoices, media_types, playlist_track, playlists, tracks). These tables have many joining fields. The table 'tracks' relates to the most other tables. Its connections are (playlist_track on TrackId, media_types on MediaTypeId, genres on GenreId, albums on AlbumId, invoice_items on TrackId). Below are queries designed to answer questions about the data.

#### Skills Showcased: Operator Use, JOINs, Concatenation, GROUP BYs with aggregate functions, calculations within queries, Aliases, ORDER BYs, data selection to answer specific questions about the data

##### 1.Show Customers (their full names, customer ID, and country) who are not in the US.
 to find how the United States is written in this table
``SELECT Country FROM customers GROUP BY Country ORDER BY Country DESC; ``


 
```
SELECT FirstName, LastName, CustomerID, Country 
FROM customers
WHERE Country <> 'USA';
```

##### 2. Show only the customers from Brazil
```
SELECT * FROM customers 
WHERE Country ='Brazil';
```

##### 3. Find the Invoices of customers who are from Brazil: show the customer's full name, Invoice ID, Date of the invoice, and billing country.
```
SELECT c.Firstname, c.LastName, i.InvoiceId, i.Invoicedate, i.BillingCountry
FROM invoices i
LEFT JOIN customers c
ON i.CustomerId=c.CustomerId
WHERE c.Country='Brazil'; 
```

##### 4. Show the employees who are sales agents
```
SELECT title
FROM employees
GROUP BY title;
```
Showed that Sales agents are referred to as 'Sales Support Agent'

```
SELECT * FROM employees
WHERE title LIKE '%Sales%agent%';
```

##### 5.Find a unique/distinct list of billing countries from the Invoice table.
```
SELECT DISTINCT BillingCountry 
FROM invoices
ORDER BY BillingCountry;
```
##### 6. show the invoices associated, with each sales agent, include the Sales Agent's full name
```
SELECT e.FirstName||' '||e.LastName as Name, i.InvoiceId
FROM Invoices i
  LEFT JOIN customers c
    ON i.CustomerId=c.CustomerId
  LEFT JOIN employees e
    ON c.SupportRepId=e.EmployeeId
ORDER BY e.LastName, InvoiceId;
```
##### 7. Show the Invoice Total, Customer name, Country, and Sales Agent name for all invoices and customers
```
SELECT i.invoiceid,
i.total as InvoiceTotal,
c.FirstName as CustomerFirst,
c.LastName as CustomerLast, c.Country, e.FirstName as SalesAgentFirst, e.LastName as SalesAgentLast
FROM Invoices i
  JOIN customers c
    ON I.CUSTOMERID=C.CUSTOMERID
  LEFT JOIN employees e
    ON c.SupportRepID=e.EmployeeId;
```

##### 8. How many invoices were there in 2009?
```
SELECT COUNT(*) as '2009Invoices'
FROM invoices
WHERE InvoiceDate LIKE '2009%';
```
##### 9. What are the total sales for 2009?
```
SELECT SUM(total) AS TotalSales
FROM invoices
WHERE InvoiceDate LIKE '2009%'; 
```
##### 10. Show the purchased track name with each invoice line item
```
SELECT i.*, t.Name as TrackName                             *
FROM invoice_items i
LEFT JOIN tracks t
ON i.trackId=t.TrackId;
```
##### 11. Show the purchased track name and artist name with each invoice line item
```
SELECT i.*, t.Name as TrackName, aa.Name as ArtistName
FROM invoice_items i
  LEFT JOIN tracks t
    ON i.trackId=t.TrackId
  LEFT JOIN albums a
    ON t.AlbumId=a.AlbumID
  LEFT JOIN artists aa
    ON a.ArtistId=aa.ArtistId;
```
 ** The Artist Names are stored in artists table, which connects only to albums which connects to tracks and not invoices. **   

##### 12. show all the Tracks, and include the Album name, Media type, and Genre
```
SELECT t.Name as Track,
a.title as Album, 
m.Name as MediaType, 
g.Name as Genre
FROM tracks t
  LEFT JOIN albums a
    ON t.AlbumId=a.AlbumId
  LEFT JOIN media_types m
    ON t.MediaTypeId=m.MediaTypeId
  LEFT JOIN genres g
    ON t.GenreId=g.GenreId
ORDER BY t.name;
```
##### 13. Show the total sales made by each sales agent.
```
SELECT e.FirstName,e.LastName,
ROUND(SUM(i.total),2) as TotalSales
FROM invoices i
  LEFT JOIN customers c
    ON i.CustomerId=c.CustomerId
  LEFT JOIN employees e
    ON c.SupportRepId=e.EmployeeId
GROUP BY e.FirstName,e.LastName;
```
##### 14. Which sales agent made the most in sales in 2009?
```
SELECT e.FirstName,e.LastName,
ROUND(SUM(i.total),2) as Sales
FROM Invoices i
  LEFT JOIN customers c
    ON i.CustomerId=c.CustomerId
  LEFT JOIN employees e
    ON c.SupportRepId=e.EmployeeId
WHERE i.InvoiceDate LIKE '2009%'
GROUP BY e.FirstName,e.LastName
ORDER BY Sales DESC
LIMIT 1;
```
##### 15.Show the ten artists with the most tracks purchased
```
SELECT aa.Name AS Artist, SUM(i.quantity) as TracksSold
FROM invoice_items i 
  LEFT JOIN tracks t
    ON i.TrackId=t.TrackId
  LEFT JOIN albums a
    ON t.AlbumId=a.AlbumId
  LEFT JOIN artists aa
    ON a.ArtistId =aa.ArtistId
GROUP BY aa.Name
ORDER BY TracksSold DESC
LIMIT 10;
```
##### 16. Show the number of tracks sold and total sales for each genre
```
SELECT g.name as Genre, 
SUM(i.quantity) as TracksSold, 
Round(SUM (i.unitprice*i.quantity),2) as TotalSales
FROM invoice_items i 
  LEFT JOIN tracks t
    ON i.TrackId=t.TrackId
  LEFT JOIN genres G
    ON t.genreid=g.genreid
GROUP BY g.name
ORDER BY TracksSold DESC, TotalSales DESC;
```
