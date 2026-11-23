-- 1.1
SELECT FirstName, LastName, Country, Score
FROM Customers
WHERE Score > 500
ORDER BY Score DESC;

-- 1.2
SELECT FirstName, LastName, Country, Score
FROM Customers
WHERE Country IN ('Germany', 'France', 'USA')
  AND Score >= 300;

-- 1.3
SELECT c.FirstName || ' ' || c.LastName AS CustomerName,
       o.OrderID,
       o.OrderDate,
       o.Sales
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 1.4r
SELECT c.CustomerID, c.FirstName, c.LastName, c.Country
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- 1.5
SELECT c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       SUM(o.Sales) AS TotalSales
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Country
ORDER BY TotalSales DESC;

-- 1.6
SELECT c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       SUM(o.Sales) AS TotalSales
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Country
HAVING SUM(o.Sales) > 1000
ORDER BY TotalSales DESC;

-- 1.7
SELECT c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       SUM(o.Sales) AS TotalSales
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Country
ORDER BY TotalSales DESC, c.CustomerID ASC
LIMIT 5;