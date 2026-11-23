-- 4.1
SELECT o.OrderID,
       o.OrderDate,
       c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       p.Product,
       p.Category,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       o.Quantity,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
WHERE o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND c.Country IN ('Germany', 'France', 'USA')
ORDER BY c.Country ASC, o.OrderDate ASC, o.OrderID ASC;

-- 4.2
SELECT o.OrderID,
       c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       c.Score,
       p.Product,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND c.Country IN ('Germany', 'France', 'USA')
  AND p.Category = 'Electronics'
  AND (c.Score >= 500 OR o.Sales >= 1000);

-- 4.3
SELECT ProductID,
       Product,
       Category,
       Price
FROM Products
WHERE Category = 'Electronics'
  AND Price BETWEEN 40 AND 100
  AND (Product LIKE '%Wireless%' OR Product LIKE '%USB%')
ORDER BY Price ASC, ProductID ASC;

-- 4.4
SELECT DISTINCT c.CustomerID,
                c.FirstName,
                c.LastName,
                c.Country,
                c.Score
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND c.Country IN ('Germany', 'France', 'USA')
  AND c.Score >= 500
  AND p.Category = 'Electronics';

-- 4.5
SELECT c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(o.OrderID) AS OrderCount,
       SUM(o.Quantity) AS TotalQuantity,
       SUM(o.Sales) AS TotalSales
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND c.Country IN ('Germany', 'France', 'USA')
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(o.OrderID) >= 2
   AND SUM(o.Sales) >= 1000
ORDER BY TotalSales DESC, c.CustomerID ASC;

-- 4.6
SELECT c.Country,
       p.Category,
       COUNT(o.OrderID) AS OrderCount,
       SUM(o.Quantity) AS TotalQuantity,
       SUM(o.Sales) AS TotalSales
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND c.Country IN ('Germany', 'France', 'USA')
GROUP BY c.Country, p.Category
HAVING SUM(o.Sales) > 500;

-- 4.7
SELECT c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       c.Score
FROM Customers c
LEFT JOIN Orders o
  ON c.CustomerID = o.CustomerID
 AND o.OrderStatus IN ('Shipped', 'Delivered')
 AND o.ShipDate IS NOT NULL
 AND o.ShipDate >= o.OrderDate
 AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND o.OrderID IS NULL;

-- 4.8
SELECT o.CustomerID
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND c.Country IN ('Germany', 'France', 'USA')
  AND p.Category = 'Electronics'
INTERSECT
SELECT o.CustomerID
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND c.Country IN ('Germany', 'France', 'USA')
  AND p.Category = 'Furniture';

-- 4.9
SELECT CustomerID FROM (
    SELECT o.CustomerID
    FROM Orders o
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    INNER JOIN Products p ON o.ProductID = p.ProductID
    WHERE o.OrderStatus IN ('Shipped', 'Delivered')
      AND o.ShipDate IS NOT NULL
      AND o.ShipDate >= o.OrderDate
      AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
      AND c.Country IN ('Germany', 'France', 'USA')
      AND p.Category = 'Electronics'
    UNION
    SELECT o.CustomerID
    FROM Orders o
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    INNER JOIN Products p ON o.ProductID = p.ProductID
    WHERE o.OrderStatus IN ('Shipped', 'Delivered')
      AND o.ShipDate IS NOT NULL
      AND o.ShipDate >= o.OrderDate
      AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
      AND c.Country IN ('Germany', 'France', 'USA')
      AND p.Category = 'Furniture'
)
ORDER BY CustomerID ASC;

-- 4.10
SELECT CustomerID FROM (
    SELECT o.CustomerID
    FROM Orders o
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    INNER JOIN Products p ON o.ProductID = p.ProductID
    WHERE o.OrderStatus IN ('Shipped', 'Delivered')
      AND o.ShipDate IS NOT NULL
      AND o.ShipDate >= o.OrderDate
      AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
      AND c.Country IN ('Germany', 'France', 'USA')
      AND p.Category = 'Electronics'
    EXCEPT
    SELECT o.CustomerID
    FROM Orders o
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    INNER JOIN Products p ON o.ProductID = p.ProductID
    WHERE o.OrderStatus IN ('Shipped', 'Delivered')
      AND o.ShipDate IS NOT NULL
      AND o.ShipDate >= o.OrderDate
      AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
      AND c.Country IN ('Germany', 'France', 'USA')
      AND p.Category = 'Furniture'
)
ORDER BY CustomerID ASC;