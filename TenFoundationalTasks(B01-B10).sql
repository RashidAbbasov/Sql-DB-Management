-- B01
SELECT * FROM Customers;

SELECT FirstName, LastName, Country
FROM Customers;

-- B02
SELECT CustomerID, FirstName, LastName, Country
FROM Customers
WHERE Country = 'Germany';

-- B03
SELECT CustomerID, FirstName, LastName, Country, Score
FROM Customers
WHERE Score >= 300
  AND Country IN ('Germany', 'France');

-- B04
SELECT ProductID, Product, Category, Price
FROM Products
ORDER BY Price DESC;

-- B05
SELECT Product, Price
FROM Products
WHERE Price BETWEEN 50 AND 300;

-- B06
SELECT Product, Category
FROM Products
WHERE Product LIKE '%Phone%';

-- B07
SELECT DISTINCT Category
FROM Products
ORDER BY Category ASC;

-- B08
SELECT o.OrderID, c.FirstName, c.LastName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;

-- B09
SELECT OrderStatus,
       COUNT(OrderID) AS OrderCount,
       SUM(Sales) AS TotalSales
FROM Orders
GROUP BY OrderStatus
ORDER BY TotalSales DESC;

-- B10
INSERT INTO Products (ProductID, Product, Category, Price)
VALUES (901, 'Webcam HD', 'Electronics', 80.00);

UPDATE Products
SET Price = 85.00
WHERE ProductID = 901;

SELECT * FROM Products WHERE ProductID = 901;

DELETE FROM Products
WHERE ProductID = 901;