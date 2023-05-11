CREATE DATABASE Group823SpringFinal;
USE Group823SpringFinal;


--drop database Group823SpringFinal;

--CREATE TABLES
CREATE TABLE organization (
    org_id int NOT NULL PRIMARY KEY ,
    org_name varchar(40) NOT NULL,
    org_type varchar(40) NOT NULL
);

CREATE TABLE promotion (
    promo_id int NOT NULL PRIMARY KEY,
    promo_name varchar(10) NOT NULL,
    promo_type varchar(10) NOT NULL,
    discount_percentage DECIMAL(3, 2) NOT NULL,
    start_time datetime NOT NULL,
    end_time datetime NOT NULL,
    status varchar(10) NOT NULL,
    total_sales int NOT NULL,
    ad_provider varchar(10) NOT NULL
);

CREATE TABLE category (
    category_id int NOT NULL PRIMARY KEY,
    category_name varchar(10) NOT NULL,
    course_count int NOT NULL
);

CREATE TABLE payment (
	payment_id int NOT NULL PRIMARY KEY,
	payment_method varchar(50) NOT NULL
);

CREATE TABLE instructor (
    instructor_id int NOT NULL PRIMARY KEY,
    instructor_firstname varchar(40) NOT NULL,
    instructor_lastname varchar(40) NOT NULL,
    org_id int NOT NULL,
    FOREIGN KEY (org_id) REFERENCES organization(org_id)
);

CREATE TABLE course (
    course_id INT NOT NULL PRIMARY KEY,
    course_name VARCHAR(50),
    promo_id INT NOT NULL,
    price MONEY NOT NULL,
    FOREIGN KEY (promo_id) REFERENCES promotion(promo_id)
);

CREATE TABLE course_instructor (
    instructor_id int NOT NULL,
    course_id int NOT NULL,
    PRIMARY KEY (instructor_id, course_id),
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE course_category (
    course_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (course_id, category_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE cart (
    cart_id int NOT NULL PRIMARY KEY,
    user_id int NOT NULL,
    quantity int NOT NULL,
    total_price money NOT NULL,
);

CREATE TABLE users (
	user_id int NOT NULL PRIMARY KEY,
	user_nickname varchar(50) NOT NULL,
	user_password VARBINARY(250) NOT NULL,-- Adding the user_password column with VARBINARY(250) data type
	user_street varchar(50) NOT NULL,
	user_city varchar(50) NOT NULL,
	user_state varchar(50) NOT NULL,
	user_zipcode int NOT NULL
);

ALTER TABLE cart ADD CONSTRAINT R1 FOREIGN KEY (user_id) REFERENCES users(user_id);
ALTER TABLE cart ADD CONSTRAINT U1 UNIQUE (user_id);


CREATE TABLE orders (
	order_id int NOT NULL PRIMARY KEY,
	quantity int NOT NULL,
	order_time datetime NOT NULL,
	order_status varchar(50) NOT NULL,
	user_id int NOT NULL REFERENCES users(user_id),
    payment_id int NOT NULL REFERENCES payment(payment_id)
);


CREATE TABLE user_course (
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    rating DECIMAL(3,2) NOT NULL,
    progress DECIMAL(4,2) NOT NULL, 
    PRIMARY KEY (user_id, course_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);


CREATE TABLE course_cart(
	course_id INT NOT NULL,
	cart_id INT NOT NULL,
	PRIMARY KEY (course_id, cart_id),
	FOREIGN KEY (course_id) REFERENCES course(course_id),
	FOREIGN KEY (cart_id) REFERENCES cart(cart_id)
);


CREATE TABLE course_order (
    course_id INT NOT NULL,
    order_id INT NOT NULL,
    PRIMARY KEY (course_id, order_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

--INSERT ORGANIZATION
INSERT organization VALUES('320123089', 'Future Academy', 'Bootcamp');
INSERT organization VALUES('320123090', 'Khon Academy', 'Hybrid');
INSERT organization VALUES('320123091', 'Future Academy', 'Corporate');
INSERT organization VALUES('320123092', 'Treehouse', 'Non-profit');
INSERT organization VALUES('320123093', 'OpenLearning', 'Hybrid');
INSERT organization VALUES('320123094', 'Datatic', 'Bootcamp');
INSERT organization VALUES('320123095', 'Datacamp', 'Hybrid');
INSERT organization VALUES('320123096', 'Joey Academy', 'Corporate');
INSERT organization VALUES('320123097', 'Simple Learn', 'Non-profit');
INSERT organization VALUES('320123098', '360training', 'Hybrid');

--INSERT PROMOTION
INSERT INTO promotion (promo_id, promo_name, promo_type, discount_percentage, start_time, end_time, status, total_sales, ad_provider) 
VALUES (1, 'New Year', 'Seasonal', 0.8, '2023-01-01 00:00:00', '2023-01-07 23:59:59', 'Active', 500, 'Google Ads');

INSERT INTO promotion (promo_id, promo_name, promo_type, discount_percentage, start_time, end_time, status, total_sales, ad_provider)
VALUES (2, 'Summer', 'Seasonal', 0.7, '2023-06-01 00:00:00', '2023-06-30 23:59:59', 'Active', 300, 'Facebook');

INSERT INTO promotion (promo_id, promo_name, promo_type, discount_percentage, start_time, end_time, status, total_sales, ad_provider)
VALUES (3, 'Holiday', 'Seasonal', 0.6, '2023-09-01 00:00:00', '2023-09-15 23:59:59', 'Upcoming', 0, 'Email');

INSERT INTO promotion (promo_id, promo_name, promo_type, discount_percentage, start_time, end_time, status, total_sales, ad_provider)
VALUES (4, 'Bundle', 'Package', 0.9, '2023-04-01 00:00:00', '2023-04-30 23:59:59', 'Active', 100, 'Instagram');

INSERT INTO promotion (promo_id, promo_name, promo_type, discount_percentage, start_time, end_time, status, total_sales, ad_provider)
VALUES (5, 'Subscribe', 'Subscribe', 0.95, '2023-01-01 00:00:00', '2023-12-31 23:59:59', 'Active', 1000, 'Google Ads');

INSERT INTO promotion (promo_id, promo_name, promo_type, discount_percentage, start_time, end_time, status, total_sales, ad_provider)
VALUES (6, 'Black Fri', 'Seasonal', 0.75, '2023-11-24 00:00:00', '2023-11-27 23:59:59', 'Upcoming', 0, 'Social');

INSERT INTO promotion (promo_id, promo_name, promo_type, discount_percentage, start_time, end_time, status, total_sales, ad_provider)
VALUES (7, 'Limited', 'Limited', 0.8, '2023-03-01 00:00:00', '2023-03-31 23:59:59', 'Active', 50, 'Email');

INSERT INTO promotion (promo_id, promo_name, promo_type, discount_percentage, start_time, end_time, status, total_sales, ad_provider)
VALUES (8, 'Refer', 'Referral', 0.5, '2023-01-01 00:00:00', '2023-12-31 23:59:59', 'Active', 200, 'Social');

INSERT INTO promotion (promo_id, promo_name, promo_type,discount_percentage, start_time, end_time, status, total_sales, ad_provider)
VALUES (9, 'Holiday', 'Package', 0.85,  '2023-01-01 00:00:00', '2023-12-31 23:59:59', 'Active', 200, 'Social');

INSERT INTO promotion (promo_id, promo_name, promo_type, discount_percentage, start_time, end_time, status, total_sales, ad_provider) 
VALUES (10, 'Holiday', 'Seasonal', 0.8, '2023-01-01 00:00:00', '2023-01-07 23:59:59', 'Active', 500, 'Google Ads');

--INSERT CATEGORY
   
INSERT category VALUES (500, 'Back End', 173);
INSERT category VALUES (501, 'Front End', 17);
INSERT category VALUES (502, 'Database', 178);
INSERT category VALUES (503, 'CS', 171);
INSERT category VALUES (504, 'Math', 16);
INSERT category VALUES (505, 'Science', 13);
INSERT category VALUES (506, 'Chemistry', 2);
INSERT category VALUES (507, 'Biology', 5);
INSERT category VALUES (508, 'Physics', 33);
INSERT category VALUES (509, 'Art', 100);

--INSERT PAYMENT
INSERT payment VALUES (11111, 'creditcard');
INSERT payment VALUES (11112, 'debitcard');
INSERT payment VALUES (11113, 'debitcard');
INSERT payment VALUES (11114, 'creditcard');
INSERT payment VALUES (11115, 'creditcard');
INSERT payment VALUES (11116, 'debitcard');
INSERT payment VALUES (11117, 'creditcard');
INSERT payment VALUES (11118, 'creditcard');
INSERT payment VALUES (11119, 'debitcard');
INSERT payment VALUES (11120, 'debitcard');

--INSERT INSTRUCTOR
INSERT instructor VALUES(2111, 'Ann', 'Tomas', 320123090);
INSERT instructor VALUES(2112, 'Tim', 'Forks', 320123092);
INSERT instructor VALUES(2113, 'Sara', 'Lee', 320123096);
INSERT instructor VALUES(2114, 'Mariana', 'James', 320123093);
INSERT instructor VALUES(2115, 'Jin', 'Fu', 320123092);
INSERT instructor VALUES(2116, 'Jin', 'Simon', 320123092);
INSERT instructor VALUES(2117, 'Jung', 'Kim', 320123098);
INSERT instructor VALUES(2118, 'Bob', 'Daniel', 320123090);
INSERT instructor VALUES(2119, 'Jim', 'Cullen', 320123091);
INSERT instructor VALUES(2120, 'Marco', 'Sun', 320123097);

--INSERT COURSE
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00031, 'SQL', 3, 100);
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00032, 'React', 4, 60);
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00033, 'UX Designer', 7, 80);
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00034, 'Java Developer', 5, 75);
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00035, 'Java Programming', 1, 68);
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00036, 'Data Architect', 4, 92);
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00037, 'Cloud Developer', 6, 75);
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00038, 'Agile', 9, 80);
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00039, 'AWS Cloud', 2, 63);
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00040, 'iOS Developer', 1, 45);


--INSERT Course_Category 
INSERT INTO course_category (category_id, course_id)
VALUES (500, 31);
INSERT INTO course_category (category_id, course_id)
VALUES (501, 32);
INSERT INTO course_category (category_id, course_id)
VALUES (502, 33);
INSERT INTO course_category (category_id, course_id)
VALUES (503, 34);
INSERT INTO course_category (category_id, course_id)
VALUES (504, 35);
INSERT INTO course_category (category_id, course_id)
VALUES (505, 36);
INSERT INTO course_category (category_id, course_id)
VALUES (506, 37);
INSERT INTO course_category (category_id, course_id)
VALUES (507, 38);
INSERT INTO course_category (category_id, course_id)
VALUES (508, 39);
INSERT INTO course_category (category_id, course_id)
VALUES (509, 40);

--INSERT Course_INSTRUCTOR
INSERT INTO course_instructor (instructor_id, course_id)
VALUES (2111, 00036);
INSERT INTO course_instructor (instructor_id, course_id)
VALUES (2112, 00031);
INSERT INTO course_instructor (instructor_id, course_id)
VALUES (2113, 00034);
INSERT INTO course_instructor (instructor_id, course_id)
VALUES (2114, 00039);
INSERT INTO course_instructor (instructor_id, course_id)
VALUES (2115, 00038);
INSERT INTO course_instructor (instructor_id, course_id)
VALUES (2116, 00032);
INSERT INTO course_instructor (instructor_id, course_id)
VALUES (2117, 00040);
INSERT INTO course_instructor (instructor_id, course_id)
VALUES (2118, 00033);
INSERT INTO course_instructor (instructor_id, course_id)
VALUES (2119, 00035);
INSERT INTO course_instructor (instructor_id, course_id)
VALUES (2120, 00037);


-----------Column Data Encryption-----------
-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Test_P@sswOrd';
-- Create certificate to protect symmetric key
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'AdventureWorks Test Certificate',
EXPIRY_DATE = '2026-10-31';
-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;
-- Open symmetric key
OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;


----INSERT USER 
----INSERT CART, AS 1-1 RELATIONSHIP
INSERT INTO users (user_id, user_nickname, user_password, user_street, user_city, user_state, user_zipcode) VALUES
(1, 'johndoe', EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,
'PassTS1')), '123 Main St', 'Anytown', 'CA', 12345);
INSERT INTO cart (cart_id, user_id, quantity, total_price) VALUES
(1, 1, 1, 100.00);

INSERT INTO users (user_id, user_nickname, user_password, user_street, user_city, user_state, user_zipcode) VALUES
(2, 'janedoe', EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,
'PassTS2')), '456 Oak St', 'Otherville', 'NY', 67890);
INSERT INTO cart (cart_id, user_id, quantity, total_price) VALUES
(2, 2, 1, 60.00);

INSERT INTO users (user_id, user_nickname, user_password, user_street, user_city, user_state, user_zipcode) VALUES
(3, 'bobsmith', EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,
'PassTS3')), '789 Maple St', 'Smalltown', 'TX', 23456);
INSERT INTO cart (cart_id, user_id, quantity, total_price) VALUES
(3, 3, 1, 80.00);

INSERT INTO users (user_id, user_nickname, user_password, user_street, user_city, user_state, user_zipcode) VALUES
(4, 'maryjones', EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,
'PassTS4')), '101 Elm St', 'Bigcity', 'IL', 34567);
INSERT INTO cart (cart_id, user_id, quantity, total_price) VALUES
(4, 4, 1, 75.00);

INSERT INTO users (user_id, user_nickname, user_password, user_street, user_city, user_state, user_zipcode) VALUES
(5, 'samsam', EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,
'PassTS5')), '456 High St', 'Anytown', 'CA', 12345);
INSERT INTO cart (cart_id, user_id, quantity, total_price) VALUES
(5, 5, 1, 68.00);

INSERT INTO users (user_id, user_nickname, user_password, user_street, user_city, user_state, user_zipcode) VALUES
(6, 'peterparker', EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,
'PassTS6')), '789 Main St', 'Otherville', 'NY', 67890);
INSERT INTO cart (cart_id, user_id, quantity, total_price) VALUES
(6, 6, 1, 92.00);

INSERT INTO users (user_id, user_nickname, user_password, user_street, user_city, user_state, user_zipcode) VALUES
(7, 'clarakent', EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,
'PassTS7')), '101 Oak St', 'Smalltown', 'TX', 23456);
INSERT INTO cart (cart_id, user_id, quantity, total_price) VALUES
(7, 7, 1, 75.00);

INSERT INTO users (user_id, user_nickname, user_password, user_street, user_city, user_state, user_zipcode) VALUES
(8, 'davidsmith', EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,
'PassTS8')), '456 Maple St', 'Bigcity', 'IL', 34567);
INSERT INTO cart (cart_id, user_id, quantity, total_price) VALUES
(8, 8, 1, 80.00);

INSERT INTO users (user_id, user_nickname, user_password, user_street, user_city, user_state, user_zipcode) VALUES
(9, 'janedoe', EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassJD9')), '456 Oak Ave', 'Sometown', 'NY', 54321);
INSERT INTO cart (cart_id, user_id, quantity, total_price) VALUES
(9, 9, 1, 63.00);

INSERT INTO users (user_id, user_nickname, user_password, user_street, user_city, user_state, user_zipcode) VALUES
(10, 'bobsmith', EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassBS10')), '789 Maple Blvd', 'Othertown', 'TX', 67890);
INSERT INTO cart (cart_id, user_id, quantity, total_price) VALUES
(10, 10, 2, 90.00);

--TEST DecryptByKey
select * from users;
select user_id, DecryptByKey(user_password)
from users;

--INSERT ORDERS:
INSERT INTO orders (order_id, user_id, quantity, order_time, payment_id, order_status)
VALUES (5001, 3, 2, '2023-01-06 07:05:00', 11117, 'Pending');
INSERT INTO orders (order_id, user_id, quantity, order_time, payment_id, order_status)
VALUES (5002, 1, 1, '2023-02-10 13:25:30', 11113, 'Completed');
INSERT INTO orders (order_id, user_id, quantity, order_time, payment_id, order_status)
VALUES (5003, 7, 3, '2023-02-24 09:46:08', 11112, 'Completed');
INSERT INTO orders (order_id, user_id, quantity, order_time, payment_id, order_status)
VALUES (5004, 9, 1, '2023-03-01 12:54:20', 11118, 'Canceled');
INSERT INTO orders (order_id, user_id, quantity, order_time, payment_id, order_status)
VALUES (5005, 2, 2, '2023-03-10 08:44:00', 11115, 'Pending');
INSERT INTO orders (order_id, user_id, quantity, order_time, payment_id, order_status)
VALUES (5006, 4, 1, '2023-03-19 21:32:16', 11111, 'Completed');
INSERT INTO orders (order_id, user_id, quantity, order_time, payment_id, order_status)
VALUES (5007, 8, 3, '2023-03-27 02:14:37', 11114, 'Completed');
INSERT INTO orders (order_id, user_id, quantity, order_time, payment_id, order_status)
VALUES (5008, 5, 2, '2023-03-31 16:48:03', 11120, 'Pending');
INSERT INTO orders (order_id, user_id, quantity, order_time, payment_id, order_status)
VALUES (5009, 6, 1, '2023-04-02 23:17:20', 11119, 'Pending');
INSERT INTO orders (order_id, user_id, quantity, order_time, payment_id, order_status)
VALUES (5010, 10, 1, '2023-04-05 14:58:09', 11116, 'Canceled');


--INSERT INTO COURSE_CART
INSERT INTO course_cart (course_id, cart_id)
VALUES (31, 1);

INSERT INTO course_cart (course_id, cart_id)
VALUES (32, 2);

INSERT INTO course_cart (course_id, cart_id)
VALUES (33, 3);

INSERT INTO course_cart (course_id, cart_id)
VALUES (34, 4);

INSERT INTO course_cart (course_id, cart_id)
VALUES (35, 5);

INSERT INTO course_cart (course_id, cart_id)
VALUES (36, 6);

INSERT INTO course_cart (course_id, cart_id)
VALUES (37, 7);

INSERT INTO course_cart (course_id, cart_id)
VALUES (38, 8);

INSERT INTO course_cart (course_id, cart_id)
VALUES (39, 9);

INSERT INTO course_cart (course_id, cart_id)
VALUES (40, 10);

--INSER COURSE ORDER:
INSERT INTO course_order (course_id, order_id)
VALUES (00031, 5009);
INSERT INTO course_order (course_id, order_id)
VALUES (00034, 5001);
INSERT INTO course_order (course_id, order_id)
VALUES (00032, 5001);
INSERT INTO course_order (course_id, order_id)
VALUES (00033, 5005);
INSERT INTO course_order (course_id, order_id)
VALUES (00037, 5005);
INSERT INTO course_order (course_id, order_id)
VALUES (00034, 5008);
INSERT INTO course_order (course_id, order_id)
VALUES (00032, 5008);
INSERT INTO course_order (course_id, order_id)
VALUES (00035, 5010);
INSERT INTO course_order (course_id, order_id)
VALUES (00036, 5002);
INSERT INTO course_order (course_id, order_id)
VALUES (00037, 5006);
INSERT INTO course_order (course_id, order_id)
VALUES (00035, 5003);
INSERT INTO course_order (course_id, order_id)
VALUES (00038, 5003);
INSERT INTO course_order (course_id, order_id)
VALUES (00039, 5003);
INSERT INTO course_order (course_id, order_id)
VALUES (00039, 5007);
INSERT INTO course_order (course_id, order_id)
VALUES (00031, 5007);
INSERT INTO course_order (course_id, order_id)
VALUES (00034, 5007);
INSERT INTO course_order (course_id, order_id)
VALUES (00040, 5004);

--INSERT USER COURSE:
INSERT INTO user_course (user_id, course_id, rating, progress)
VALUES (1, 31, 9.9, 89.99);
INSERT INTO user_course (user_id, course_id, rating, progress)
VALUES (2, 32, 8.9, 79.99);
INSERT INTO user_course (user_id, course_id, rating, progress)
VALUES (3, 33, 7.9, 99.99);
INSERT INTO user_course (user_id, course_id, rating, progress)
VALUES (4, 34, 6.9, 69.99);
INSERT INTO user_course (user_id, course_id, rating, progress)
VALUES (5, 35, 5.9, 79.99);
INSERT INTO user_course (user_id, course_id, rating, progress)
VALUES (6, 36, 3.9, 99.99);
INSERT INTO user_course (user_id, course_id, rating, progress)
VALUES (7, 37, 2.9, 39.99);
INSERT INTO user_course (user_id, course_id, rating, progress)
VALUES (8, 38, 1.9, 29.99);
INSERT INTO user_course (user_id, course_id, rating, progress)
VALUES (9, 39, 2.9, 19.99);
INSERT INTO user_course (user_id, course_id, rating, progress)
VALUES (10, 40, 5.9, 9.99);


--------VIEW (used for reporting purposes)-------------
--views
--1. view1_course_info: This view displays the information of the courses 
--available in the database, along with their instructors and categories.
CREATE VIEW view_course_info 
AS
SELECT c.course_id, c.course_name, i.instructor_firstname, 
i.instructor_lastname, cat.category_name
FROM course c
INNER JOIN course_instructor ci ON c.course_id = ci.course_id
INNER JOIN instructor i ON ci.instructor_id = i.instructor_id
INNER JOIN course_category cc ON c.course_id = cc.course_id
INNER JOIN category cat ON cc.category_id = cat.category_id;

--test
SELECT * 
FROM view_course_info;

--clean up
DROP VIEW view_course_info;

--2. view_user_course_info: This view shows the courses taken by each user and their progress.
/*
 Create a view to include the encryption option. Encryption protects the
 view query definition. So it is not visible to users who don't have the necessary permissions to view the encrypted object.
*/
CREATE VIEW view_user_course_info 
WITH ENCRYPTION
AS
SELECT u.user_id, u.user_nickname, c.course_name, uc.progress
FROM users u
INNER JOIN user_course uc ON u.user_id = uc.user_id
INNER JOIN course c ON uc.course_id = c.course_id;

--test1
SELECT * 
FROM view_user_course_info;
--test2
--select only certain columns from a view 
SELECT user_nickname, course_name,progress
FROM view_user_course_info;

--clean up
DROP VIEW view_user_course_info;

--3. view_orders_details: This View shows the details of all orders with the corresponding user and course information.
--the view is bound to the schema of the underlying tables. This means that if any of the underlying tables are modified, the view definition is invalidated
CREATE VIEW view_orders_details 
WITH ENCRYPTION, SCHEMABINDING
AS
SELECT o.order_id, o.quantity, o.order_time, o.order_status,
       u.user_nickname, c.course_name, c.price
FROM dbo.orders o
JOIN dbo.users u ON o.user_id = u.user_id
JOIN dbo.course_order co ON o.order_id = co.order_id
JOIN dbo.course c ON co.course_id = c.course_id;

--test view
SELECT * 
FROM view_orders_details;

--test schemabinding
--drop unrelated column of one underlying table
ALTER TABLE users
DROP COLUMN user_city;
--drop related column of one underlying table
ALTER TABLE users
DROP COLUMN user_nickname;

--clean up
DROP VIEW view_orders_details;

---Table-level CHECK Constraints based on a function-----
--Function:
--use func_check_maxprice function in a table-level CHECK constraint on the course table
--This will enforce the constraint that the maximum price for a course is $？, and the maximum price can be simply changed when using this function
CREATE FUNCTION func_check_maxprice (@price MONEY, @maxPrice MONEY)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @errorMsg VARCHAR(100);
    IF @price > @maxPrice
        SET @errorMsg = 'The maximum price for a course is ' + CONVERT(VARCHAR, @maxPrice) + '.';
    ELSE
        SET @errorMsg = '';
    RETURN @errorMsg;
END;

ALTER TABLE course ADD CONSTRAINT check_maxprice CHECK (dbo.func_check_maxprice(price, 100) = '');
--test case 1, can insert, because price <= maxPrice
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00041, 'Database Design', 1, 99);

--test case 2, can not insert, because price > maxPrice
INSERT INTO course (course_id, course_name, promo_id, price)
VALUES (00042, 'Intro to python', 1, 120);

--clean up
ALTER TABLE course DROP CONSTRAINT check_maxprice;
drop function func_check_maxprice;
DELETE FROM course WHERE course_id = '00041';
DELETE FROM course WHERE course_id = '00042';

--------Computed Columns based on a function-----------------------
CREATE FUNCTION fn_CalcDiscountedPrice(@PromPer MONEY, @Price MONEY)RETURNS MONEYASBEGINDECLARE @discountedprice MONEY = @Price * @PromPerSET @discountedprice = @discountedprice;RETURN @discountedprice;ENDSELECT course.course_id, course.price, promotion.discount_percentage,        dbo.fn_CalcDiscountedPrice(1-promotion.discount_percentage, course.price) AS DiscountedPriceFROM courseJOIN promotion ON promotion.promo_id = course.promo_id;

--clean up database
--DROP DATABASE Group823SpringFinal;


