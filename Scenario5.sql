-- 5.1
SELECT o.OrderID,
       o.OrderDate,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       p.Product,
       o.Quantity,
       o.Sales,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       o.ShipAddress
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
WHERE o.OrderStatus = 'Pending'
  AND o.OrderDate <= '2026-11-07'
ORDER BY o.OrderDate ASC;

-- 5.2
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       o.OrderDate,
       p.Product,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
WHERE o.OrderStatus = 'Pending'
  AND o.ShipDate IS NULL
  AND o.OrderDate < '2026-10-31';

-- 5.3
SELECT o.OrderID,
       c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       o.ShipAddress
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
WHERE o.OrderStatus = 'Pending'
  AND o.OrderDate <= '2026-11-07'
  AND (o.ShipAddress IS NULL OR TRIM(o.ShipAddress) = '');

-- 5.4
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       o.ShipAddress,
       o.BillAddress,
       o.OrderStatus
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderStatus <> 'Cancelled'
  AND o.OrderDate <= '2026-11-07'
  AND o.ShipAddress IS NOT NULL AND TRIM(o.ShipAddress) <> ''
  AND o.BillAddress IS NOT NULL AND TRIM(o.BillAddress) <> ''
  AND o.ShipAddress <> o.BillAddress;

-- 5.5
SELECT o.OrderID,
       o.OrderStatus,
       o.OrderDate,
       o.ShipDate,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       e.FirstName || ' ' || e.LastName AS EmployeeName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
WHERE o.OrderDate <= '2026-11-07'
  AND (
      o.ShipDate < o.OrderDate
      OR (o.OrderStatus IN ('Shipped', 'Delivered') AND o.ShipDate IS NULL)
  );

-- 5.6
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       p.Product,
       o.OrderDate,
       o.ShipDate,
       CAST(julianday(o.ShipDate) - julianday(o.OrderDate) AS INTEGER) AS DaysToShip
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.OrderStatus <> 'Cancelled'
  AND o.OrderDate <= '2026-11-07'
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND (julianday(o.ShipDate) - julianday(o.OrderDate)) > 7
ORDER BY DaysToShip DESC, o.OrderID ASC;

-- 5.7
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       COUNT(o.OrderID) AS PendingOrderCount,
       COALESCE(SUM(o.Sales), 0) AS PendingSales
FROM Employees e
LEFT JOIN Orders o
  ON e.EmployeeID = o.SalesPersonID
 AND o.OrderStatus = 'Pending'
 AND o.ShipDate IS NULL
 AND o.OrderDate <= '2026-11-07'
WHERE e.Department = 'Sales'
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

-- 5.8
SELECT c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(o.OrderID) AS PendingOrderCount,
       SUM(o.Sales) AS PendingSales
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Pending'
  AND o.ShipDate IS NULL
  AND o.OrderDate <= '2026-11-07'
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(o.OrderID) >= 2;

-- 5.9
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       p.Product,
       o.Sales,
       o.OrderStatus,
       o.OrderDate,
       o.ShipDate
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.OrderStatus <> 'Cancelled'
  AND o.OrderDate <= '2026-11-07'
  AND c.Country IN ('Germany', 'USA')
  AND o.Sales >= 500
  AND (
      (o.OrderStatus = 'Pending' AND o.ShipDate IS NULL)
      OR (o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND (julianday(o.ShipDate) - julianday(o.OrderDate)) > 7)
  );

-- 5.10
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       p.Product,
       o.Quantity,
       o.ShipAddress,
       e.FirstName || ' ' || e.LastName AS EmployeeName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
WHERE o.OrderStatus = 'Pending'
  AND o.ShipDate IS NULL
  AND o.OrderDate <= '2026-11-07'
  AND o.ShipAddress IS NOT NULL
  AND TRIM(o.ShipAddress) <> ''
ORDER BY c.Country ASC, o.OrderDate ASC, o.OrderID ASC;