CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name TEXT,
    City TEXT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Amount DECIMAL(10,2),
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers VALUES
(1, 'Amit', 'Delhi'),
(2, 'Riya', 'Mumbai'),
(3, 'Karan', 'Delhi'),
(4, 'Neha', 'Bangalore');

INSERT INTO Orders VALUES
(101, 1, 5000, '2025-08-01'),
(102, 2, 2000, '2025-08-03'),
(103, 1, 1500, '2025-08-05'),
(104, 3, 8000, '2025-08-06');


SELECT 
    Name,
    (SELECT SUM(Amount) 
     FROM Orders 
     WHERE Orders.CustomerID = Customers.CustomerID) AS TotalAmount
FROM Customers;
SELECT Name
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders);
SELECT Name
FROM Customers
WHERE CustomerID = (
    SELECT CustomerID
    FROM Orders
    ORDER BY Amount DESC
    LIMIT 1
);
SELECT C.Name, T.TotalAmount
FROM Customers C
JOIN (
    SELECT CustomerID, SUM(Amount) AS TotalAmount
    FROM Orders
    GROUP BY CustomerID
) T ON C.CustomerID = T.CustomerID;
SELECT Name
FROM Customers
WHERE (SELECT SUM(Amount) 
       FROM Orders 
       WHERE Orders.CustomerID = Customers.CustomerID) >
      (SELECT AVG(Amount) FROM Orders);
SELECT Name
FROM Customers C
WHERE EXISTS (
    SELECT 1
    FROM Orders O
    WHERE O.CustomerID = C.CustomerID
);

