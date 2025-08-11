-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database
\c OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
-- now imporat data from Computer directly 


select * from BOOKS;
select * from customers;
select * from orders;


-- 1) Retrieve all books in the "Fiction" genre:


select * from books
where genre = 'Fiction';



-- 2) Find books published after the year 1950:

select * from books 
where published_year > 1950 ;



-- 3) List all customers from the Canada:
 select * from Customers
 where country= 'Canada';

 -- 4) Show orders placed in November 2023:

select * from orders 
where order_date between '2023-11-01' AND '2023-11-30';




-- 5) Retrieve the total stock of books available:

select sum(stock) as TotalStock 
from books;


-- 6) Find the details of the most expensive book:

select * from books Order by price desc limit 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM Orders
WHERE quantity>1;




-- 8) Retrieve all orders where the total amount exceeds $20:
select * from Orders
where total_amount>20;


-- 9) List all genres available in the Books table:

SELECT DISTINCT genre FROM Books;

-- 10) Find the book with the lowest stock:
select * from books 
order by stock limit 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders;


-- 12) Retrieve the total number of books sold for each genre:

SELECT * FROM ORDERS;

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;


-- 12) Find the average price of books in the "Fantasy" genre:
select * from books;
select avg(price) as AVERAGE_price
from books 
where genre='Fantasy';

-- 13) List customers who have placed at least 2 orders:
select * from Customers;
select * from Orders;

SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;



-- 14) Find the most frequently ordered book:
select * from orders;
select * from Books;
select book_id , count(order_id)as COUNTORDER
from orders
group by book_id
order by COUNTORDER desc;

-- 15) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 16) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;


-- 17) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;

-- 18) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;


--19) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;











