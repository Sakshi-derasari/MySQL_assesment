CREATE DATABASE expense_manager;
USE expense_manager;
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    created_at DATE
);
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);
CREATE TABLE expenses (
    expense_id INT PRIMARY KEY,
    user_id INT,
    category_id INT,
    amount DECIMAL(10,2),
    expense_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
INSERT INTO users VALUES
(1, 'Amit', 'amit@gmail.com', '2024-01-01'),
(2, 'Neha', 'neha@gmail.com', '2024-01-02'),
(3, 'Rahul', 'rahul@gmail.com', '2024-01-03'),
(4, 'Sneha', 'sneha@gmail.com', '2024-01-04'),
(5, 'Karan', 'karan@gmail.com', '2024-01-05');

INSERT INTO categories VALUES
(1, 'Food'),
(2, 'Rent'),
(3, 'Entertainment');

INSERT INTO expenses VALUES
(1, 1, 1, 200.50, '2024-02-01'),
(2, 2, 2, 5000.00, '2024-02-02'),
(3, 3, 3, 800.00, '2024-02-03'),
(4, 1, 2, 4500.00, '2024-02-04'),
(5, 4, 1, 300.00, '2024-02-05'),
(6, 5, 3, 1200.00, '2024-02-06'),
(7, 2, 1, 150.00, '2024-02-07'),
(8, 3, 2, 6000.00, '2024-02-08'),
(9, 4, 3, 900.00, '2024-02-09'),
(10, 5, 1, 250.00, '2024-02-10');

UPDATE expenses
SET amount = 1000.00
WHERE expense_id = 3;

DELETE FROM expenses
WHERE amount < 200;

SELECT 
    e.expense_date,
    e.amount,
    u.name,
    c.category_name
FROM expenses e
INNER JOIN users u ON e.user_id = u.user_id
INNER JOIN categories c ON e.category_id = c.category_id;

SELECT 
    c.category_name,
    SUM(e.amount) AS total_expense
FROM expenses e
INNER JOIN categories c ON e.category_id = c.category_id
GROUP BY c.category_name;

SELECT 
    u.name,
    SUM(e.amount) AS total_spent
FROM users u
INNER JOIN expenses e ON u.user_id = e.user_id
GROUP BY u.name
ORDER BY total_spent DESC;

CREATE VIEW ActiveUsersView AS
SELECT 
    u.name,
    u.email
FROM users u
INNER JOIN expenses e ON u.user_id = e.user_id
GROUP BY u.user_id, u.name, u.email
HAVING COUNT(e.expense_id) > 5;

SELECT * FROM ActiveUsersView;


CREATE DATABASE expense_tracker;
USE expense_tracker;

CREATE TABLE users (
user_id INT PRIMARY KEY,
name VARCHAR(50),
email VARCHAR(100),
created_at DATE
);

CREATE TABLE categories (
category_id INT PRIMARY KEY,
category_name VARCHAR(50)
);

CREATE TABLE expenses (
expense_id INT PRIMARY KEY,
user_id INT,
category_id INT,
amount DECIMAL(10,2),
expense_date DATE,
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO users VALUES
(1, 'Amit', 'amit@gmail.com', '2024-01-01'),
(2, 'Neha', 'neha@gmail.com', '2024-01-02');

INSERT INTO categories VALUES
(1, 'Food'),
(2, 'Rent');

INSERT INTO expenses VALUES
(1, 1, 1, 200.00, '2024-02-01'),
(2, 1, 2, 3000.00, '2024-02-02'),
(3, 2, 1, 150.00, '2024-02-03');

INSERT INTO expenses VALUES
(4, 2, 2, 2500.00, '2024-02-05');

SELECT * FROM expenses;

UPDATE expenses
SET amount = 500.00
WHERE expense_id = 3;

DELETE FROM expenses
WHERE expense_id = 1;

DELIMITER //
CREATE PROCEDURE GetMonthlyExpense(
IN uid INT,
IN month_val INT,
IN year_val INT
)
BEGIN
SELECT
u.name,
SUM(e.amount) AS total_monthly_expense
FROM expenses e
JOIN users u ON e.user_id = u.user_id
WHERE e.user_id = uid
AND MONTH(e.expense_date) = month_val
AND YEAR(e.expense_date) = year_val
GROUP BY u.name;
END //
DELIMITER ;
CALL GetMonthlyExpense(1, 2, 2024);

START TRANSACTION;

INSERT INTO expenses VALUES
(5, 1, 1, 999.00, '2024-02-10');

SELECT * FROM expenses;

COMMIT;

START TRANSACTION;

INSERT INTO expenses VALUES
(6, 2, 2, 888.00, '2024-02-11');

SELECT * FROM expenses;

ROLLBACK;

SELECT * FROM expenses;

