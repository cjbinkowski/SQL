#### This document contains SQL commands written by me to create a table for a hypothetical clothing store and to show requested details about the store
##### Table creation
``` 
CREATE TABLE merchandise
(ID integer primary key, 
item text,
clothing_type text,
price integer,
profit integer);
```
```
INSERT INTO merchandise VALUES
(1, "long sleeve", "top", 10, 5),
(2, "turtle neck", "top", 15, 7),
(3, "crop top", "top", 8, 4),
(4, "jeans", "bottom", 20, 12),
(5, "leggings", "bottom", 12, 6),
(6, "a-line skirt", "bottom", 15, 5),
(7, "midi skirt", "bottom", 18, 8),
(8, "sundress", "full", 22, 10),
(9, "jumpsuit", "full", 24, 13),
(10, "khakis", "bottom", 20, 10),
(11, "basketball shorts", "bottom", 12, 8),
(12, "jean shorts", "bottom", 15, 5),
(13, "formal dress", "full", 30, 15),
(14, "circle skirt", "bottom", 15, 8),
(15, "t shirt", "top", 10, 5);
```
#####  Show all items in the table organized by price
``SELECT * FROM merchandise ORDER BY price;``
##### Show the item with the largest profit 
``SELECT item, MAX(profit) FROM merchandise;``
##### Find the number of clothing items with type 'top' 
``SELECT COUNT (clothing_type) AS top_number FROM merchandise WHERE clothing_type= 'top' ;``



