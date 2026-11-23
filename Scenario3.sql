-- 3.1
SELECT Product, Category, Price
FROM Products
WHERE Price BETWEEN 50 AND 300
ORDER BY Price ASC;

-- 3.2
SELECT ProductID, Product, Category, Price
FROM Products
WHERE Category = 'Electronics'
  AND Price > 500;

-- 3.3
SELECT p.Product, p.Category, o.Quantity, o.Sales
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID;

-- 3.4
SELECT p.ProductID,
       p.Product,
       SUM(o.Quantity) AS TotalQuantity
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Product
ORDER BY TotalQuantity DESC, p.ProductID ASC
LIMIT 5;

-- 3.5
SELECT p.ProductID, p.Product, p.Category, p.Price
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL;

-- 3.6
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       e.Department,
       SUM(o.Sales) AS TotalSales
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.SalesPersonID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.Department;

-- 3.7
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       e.Department,
       SUM(o.Sales) AS TotalSales
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.SalesPersonID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.Department
HAVING SUM(o.Sales) > 5000
ORDER BY TotalSales DESC;


-- 3.8(Ilkin DB-de islet)
INSERT INTO Products (ProductID, Product, Category, Price)
VALUES (501, 'Wireless Keyboard', 'Electronics', 75.00);

-- 3.9(ILkin DB-de islet)
UPDATE Products
SET Price = 90.00
WHERE ProductID = 501;

-- 3.10(Ilkin DB-de islet)
ALTER TABLE Products
ADD COLUMN StockQuantity INTEGER;

-- 3.11
SELECT FirstName, LastName FROM Customers
UNION
SELECT FirstName, LastName FROM Employees;

-- 3.12
SELECT p.Category,
       SUM(o.Quantity) AS TotalQuantity,
       SUM(o.Sales) AS TotalSales
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Category
HAVING SUM(o.Sales) > 2000
ORDER BY TotalSales DESC;