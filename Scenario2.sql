-- 2.1
SELECT OrderID, CustomerID, OrderDate, ShipDate, OrderStatus
FROM Orders
WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31';

-- 2.2
SELECT OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       o.OrderDate,
       o.ShipDate,
       o.OrderStatus
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderStatus = 'Pending'
ORDER BY o.OrderDate ASC;

-- 2.3
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       o.OrderDate,
       o.ShipDate
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.ShipDate IS NOT NULL
  AND (julianday(o.ShipDate) - julianday(o.OrderDate)) > 7;

-- 2.4
SELECT DISTINCT c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.ShipDate IS NOT NULL
  AND (julianday(o.ShipDate) - julianday(o.OrderDate)) > 7;


-- 2.5(Ilkin DB - de istifade et)
INSERT OR IGNORE INTO Orders (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES (105, 101, 1, 11, '2026-11-01', NULL, 'Pending', '10 Nizami St, Baku', '10 Nizami St, Baku', 1, 55.00, '2026-11-01 10:00:00');

SELECT * FROM Orders WHERE OrderID = 105; -- Preview before update

UPDATE Orders
SET OrderStatus = 'Shipped',
    ShipDate = '2026-11-05'
WHERE OrderID = 105;

-- 2.6(Ilkin DB - de istifade et)
INSERT OR IGNORE INTO Orders (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES (110, 102, 1, 11, '2026-11-02', NULL, 'Pending', NULL, '10 Nizami St, Baku', 1, 230.00, '2026-11-02 10:00:00');

SELECT * FROM Orders WHERE OrderID = 110; -- Preview before update

UPDATE Orders
SET ShipAddress = '45 Main Street, Baku'
WHERE OrderID = 110;

-- 2.7(Ilkin DB - de istifade et)
INSERT OR IGNORE INTO Orders (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES (999, 104, 2, 11, '2026-11-05', NULL, 'Pending', '45 Main St, New York', '45 Main St, New York', 1, 12.00, '2026-11-05 10:00:00');

SELECT * FROM Orders WHERE OrderID = 999; -- Preview before delete

DELETE FROM Orders
WHERE OrderID = 999;

-- 2.8
SELECT OrderStatus,
       COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY OrderStatus;

-- 2.9
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       o.OrderDate,
       o.ShipDate,
       o.OrderStatus
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.ShipDate IS NULL;