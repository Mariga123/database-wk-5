```sql
USE salesdb;
-- Staff table
CREATE TABLE staff (
  staffId INT PRIMARY KEY,
  FullName VARCHAR(100) NOT NULL
);

-- IDCard table (1:1 with Staff)
CREATE TABLE IDCard (
  CardId INT PRIMARY KEY,
  staffId INT UNIQUE, -- ensures only one card per employee
  IssueDate DATE,
  FOREIGN KEY (staffId) REFERENCES staff(staffId)
);

-- Insert sample data
INSERT INTO staff VALUES (1, 'Brian Otieno'), (2, 'Faith Wanjiru');
INSERT INTO IDCard VALUES (101, 1, '2025-01-01'), (102, 2, '2025-01-10');

SELECT S.FullName, C.CardId, C.IssueDate
FROM staff S
INNER JOIN IDCard C ON S.staffId = C.staffId;


CREATE TABLE Department (
  deptId INT PRIMARY KEY,
  deptName VARCHAR(100) NOT NULL
);
-- Employee table (Many employees can belong to one department)
CREATE TABLE Employee (
  empId INT PRIMARY KEY,
  empName VARCHAR(100) NOT NULL,
  deptId INT,
  FOREIGN KEY (deptId) REFERENCES Department(deptId)
);
-- Insert sample data
INSERT INTO Department(deptId,deptName) VALUES (1, 'Finance'), (2, 'IT'),(3,'Marketing');

INSERT INTO Employee(empId,empName,deptid) VALUES 
(101, 'Alice Akinyi', 1),
(102, 'James Kariuki', 1),
(103, 'Kevin Mwangi', 2),
(104,' Mercy James', NULL),
(105, 'Alice sanele', NULL);

SELECT D.deptName, E.empName
FROM Department D
INNER JOIN Employee E ON D.deptId = E.deptId;
-- Left Join
SELECT E.empName, D.deptName
FROM Employee E
LEFT JOIN Department D ON E.deptId = D.deptId;
-- Right join
SELECT D.deptName, E.empName
FROM Employee E
RIGHT JOIN Department D ON E.deptId = D.deptId;
```

One row in Table A can be linked to many rows in Table B, and vice versa.

Example: A book can have many authors, and an author can write many books.

_To implement this, we use a junction table (also called a bridge or linking table)._
```sql
-- Author table
CREATE TABLE Author (
  authorId INT PRIMARY KEY,
  authorName VARCHAR(100) NOT NULL
);

