-- 1. create customer table
create table customer(
	customer_id SERIAL PRIMARY KEY,
	f_name VARCHAR(50) NOT NULL,
	l_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	created_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ
);

-- 2. select all customers
SELECT * FROM customer;

-- 3. Drop the customer table if exists
DROP TABLE IF EXISTS customer;

--4. add a column in table 
ALTER TABLE customer ADD COLUMN active BOOLEAN;

--5. remove column from table
ALTER TABLE customer DROP COLUMN active;

--6. rename columns
ALTER TABLE customer RENAME COLUMN email TO email_address;
ALTER TABLE customer RENAME COLUMN email_address TO email;

--7.rename tables
ALTER TABLE customer RENAME TO users;
ALTER TABLE users RENAME TO customer;

--8. create orders table
CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
	customer_id INTEGER NOT NULL REFERENCES  customer(customer_id),
	order_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    order_number VARCHAR(50) NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL
)

--9. insert a singl record in the customer table
INSERT INTO customer(f_name, l_name, email, created_date, updated_date, active)
VALUES ('Bansi', 'Sachade', '.bansi.sachade@tatvasoft.com', NOW(), NULL, true);

--10. insert multiple table records
INSERT INTO customer (f_name, l_name, email, created_date, updated_date, active) VALUES
  ('John', 'Doe', 'johndoe@example.com', NOW(), NULL, true),
  ('Alice', 'Smith', 'alicesmith@example.com', NOW(), NULL, true),
  ('Bob', 'Johnson', 'bjohnson@example.com', NOW(), NULL, true),
  ('Emma', 'Brown', 'emmabrown@example.com', NOW(), NULL, true),
  ('Michael', 'Lee', 'michaellee@example.com', NOW(), NULL, false),
  ('Sarah', 'Wilson', 'sarahwilson@example.com', NOW(), NULL, true),
  ('David', 'Clark', 'davidclark@example.com', NOW(), NULL, true),
  ('Olivia', 'Martinez', 'oliviamartinez@example.com', NOW(), NULL, true),
  ('James', 'Garcia', 'jamesgarcia@example.com', NOW(), NULL, false),
  ('Sophia', 'Lopez', 'sophialopez@example.com', NOW(), NULL, false),
  ('Jennifer', 'Davis', 'jennifer.davis@example.com', NOW(), NULL, true),
  ('Jennie', 'Terry', 'jennie.terry@example.com', NOW(), NULL, true),
  ('JENNY', 'SMITH', 'jenny.smith@example.com', NOW(), NULL, false),
  ('Hiren', 'Patel', 'hirenpatel@example.com', NOW(), NULL, false);

--11. insert records in orders
INSERT INTO orders (customer_id, order_date, order_number, order_amount) VALUES
  (1, '2024-01-01', 'ORD001', 50.00),
  (2, '2024-01-01', 'ORD002', 35.75),
  (3, '2024-01-01', 'ORD003', 100.00),
  (4, '2024-01-01', 'ORD004', 30.25),
  (5, '2024-01-01', 'ORD005', 90.75),
  (6, '2024-01-01', 'ORD006', 25.50),
  (7, '2024-01-01', 'ORD007', 60.00),
  (8, '2024-01-01', 'ORD008', 42.00),
  (9, '2024-01-01', 'ORD009', 120.25),
  (10,'2024-01-01', 'ORD010', 85.00),
  (1, '2024-01-02', 'ORD011', 55.00),
  (1, '2024-01-03', 'ORD012', 80.25),
  (2, '2024-01-03', 'ORD013', 70.00),
  (3, '2024-01-04', 'ORD014', 45.00),
  (1, '2024-01-05', 'ORD015', 95.50),
  (2, '2024-01-05', 'ORD016', 27.50),
  (2, '2024-01-07', 'ORD017', 65.75),
  (2, '2024-01-10', 'ORD018', 75.50);

--12. basic select queries
--fetching single column
SELECT f_name FROM customer;

--fetching multiplr columns
SELECT f_name, l_name FROM customer;

--13. order by queries
SELECT f_name, l_name FROM customer ORDER BY f_name ASC;

SELECT f_name, l_name FROM customer ORDER BY l_name DESC;

SELECT customer_id, f_name, l_name FROM customer ORDER BY f_name ASC, l_name DESC;

--14. where clause examples
SELECT f_name, l_name FROM customer WHERE f_name = 'Hiren';

SELECT customer_id, f_name, l_name FROM customer WHERE f_name = 'Hiren' AND l_name = 'Parejiya';

SELECT customer_id, f_name, l_name FROM customer WHERE f_name IN ('John', 'David', 'James');

SELECT customer_id, f_name, l_name FROM customer WHERE f_name LIKE '%EN%';

SELECT customer_id, f_name, l_name FROM customer WHERE f_name ILIKE '%EN%';

--15.join examples
SELECT * FROM orders AS o INNER JOIN customer AS c ON o.customer_id = c.customer_id;

SELECT * FROM customer AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id;

--16. aggregation with group by
SELECT c.customer_id, c.f_name, c.l_name, c.email,
COUNT(o.order_id) AS NoOrders,
SUM(o.order_amount) AS Total
FROM customer AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id;

--17. group by with having
SELECT c.customer_id, c.f_name, c.l_name, c.email,
COUNT(o.order_id) AS NoOrders,
SUM(o.order_amount) AS Total
FROM customer AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 1;

--18. sub-queries
-- IN operator
SELECT * FROM customer WHERE customer_id IN (
	SELECT customer_id FROM customer WHERE active = true
)
-- EXISTS operator
SELECT customer_id, f_name, l_name, email FROM customer
WHERE EXISTS (
	SELECT 1 FROM orders WHERE customer.customer_id = orders.order_id
)

--19. update query
UPDATE customer 
SET f_name = 'Bansi', l_name = 'Shah' , email = 'bansi@shah.com' WHERE customer_id = 1;

-- 20. delete query
DELETE FROM customer WHERE customer_id = 11;

