-- 6.1
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       e.Department,
       e.ManagerID,
       m.FirstName || ' ' || m.LastName AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

-- 6.2
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       COUNT(o.OrderID) AS OrderCount,
       COALESCE(SUM(o.Quantity), 0) AS TotalQuantity,
       COALESCE(SUM(o.Sales), 0) AS TotalSales
FROM Employees e
LEFT JOIN Orders o
  ON e.EmployeeID = o.SalesPersonID
 AND o.OrderStatus IN ('Shipped', 'Delivered')
 AND o.ShipDate IS NOT NULL
 AND o.ShipDate >= o.OrderDate
 AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
WHERE e.Department = 'Sales'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales DESC, e.EmployeeID ASC;

-- 6.3
SELECT m.EmployeeID AS ManagerID,
       m.FirstName || ' ' || m.LastName AS ManagerName,
       COUNT(DISTINCT e.EmployeeID) AS DirectSalesStaffCount,
       COUNT(o.OrderID) AS TeamOrderCount,
       COALESCE(SUM(o.Sales), 0) AS TeamSales
FROM Employees m
INNER JOIN Employees e
  ON m.EmployeeID = e.ManagerID
 AND e.Department = 'Sales'
LEFT JOIN Orders o
  ON e.EmployeeID = o.SalesPersonID
 AND o.OrderStatus IN ('Shipped', 'Delivered')
 AND o.ShipDate IS NOT NULL
 AND o.ShipDate >= o.OrderDate
 AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
GROUP BY m.EmployeeID, m.FirstName, m.LastName;

-- 6.4
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       COUNT(o.OrderID) AS OrderCount,
       SUM(o.Sales) AS TotalSales
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.SalesPersonID
WHERE e.Department = 'Sales'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) >= 2
   AND SUM(o.Sales) >= 1000
ORDER BY TotalSales DESC, e.EmployeeID ASC;

-- 6.5
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       COUNT(DISTINCT o.CustomerID) AS DistinctCustomers,
       COUNT(DISTINCT c.Country) AS DistinctCountries
FROM Employees e
LEFT JOIN Orders o
  ON e.EmployeeID = o.SalesPersonID
 AND o.OrderStatus IN ('Shipped', 'Delivered')
 AND o.ShipDate IS NOT NULL
 AND o.ShipDate >= o.OrderDate
 AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE e.Department = 'Sales'
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

-- 6.6
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       e.Department
FROM Employees e
LEFT JOIN Orders o
  ON e.EmployeeID = o.SalesPersonID
 AND o.OrderStatus IN ('Shipped', 'Delivered')
 AND o.ShipDate IS NOT NULL
 AND o.ShipDate >= o.OrderDate
 AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
WHERE e.Department = 'Sales'
  AND o.OrderID IS NULL;

-- 6.7
SELECT CustomerID FROM (
    SELECT CustomerID
    FROM Orders
    WHERE OrderStatus IN ('Shipped', 'Delivered')
      AND ShipDate IS NOT NULL
      AND ShipDate >= OrderDate
      AND OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
    INTERSECT
    SELECT CustomerID
    FROM Orders
    WHERE OrderStatus IN ('Shipped', 'Delivered')
      AND ShipDate IS NOT NULL
      AND ShipDate >= OrderDate
      AND OrderDate BETWEEN '2026-11-01' AND '2026-11-07'
)
ORDER BY CustomerID ASC;

-- 6.8
SELECT CustomerID FROM (
    SELECT CustomerID
    FROM Orders
    WHERE OrderStatus IN ('Shipped', 'Delivered')
      AND ShipDate IS NOT NULL
      AND ShipDate >= OrderDate
      AND OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
    EXCEPT
    SELECT CustomerID
    FROM Orders
    WHERE OrderStatus IN ('Shipped', 'Delivered')
      AND ShipDate IS NOT NULL
      AND ShipDate >= OrderDate
      AND OrderDate BETWEEN '2026-11-01' AND '2026-11-07'
)
ORDER BY CustomerID ASC;

-- 6.9
SELECT CustomerID FROM (
    SELECT CustomerID
    FROM Orders
    WHERE OrderStatus IN ('Shipped', 'Delivered')
      AND ShipDate IS NOT NULL
      AND ShipDate >= OrderDate
      AND OrderDate BETWEEN '2026-11-01' AND '2026-11-07'
    EXCEPT
    SELECT CustomerID
    FROM Orders
    WHERE OrderStatus IN ('Shipped', 'Delivered')
      AND ShipDate IS NOT NULL
      AND ShipDate >= OrderDate
      AND OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
)
ORDER BY CustomerID ASC;

-- 6.10
SELECT 'October 2026' AS PeriodLabel,
       o.OrderID,
       o.OrderDate,
       c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
WHERE o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'

UNION ALL

SELECT 'November 01-07' AS PeriodLabel,
       o.OrderID,
       o.OrderDate,
       c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
WHERE o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL
  AND o.ShipDate >= o.OrderDate
  AND o.OrderDate BETWEEN '2026-11-01' AND '2026-11-07'

ORDER BY OrderDate ASC, OrderID ASC;