--Tables

CREATE TABLE Users
(
username VARCHAR(20) PRIMARY KEY,
password VARCHAR(20),
first_name VARCHAR(20),
last_name VARCHAR(20),
email VARCHAR(50)
)


CREATE TABLE User_mobile_numbers
(
mobile_number VARCHAR(20),
username VARCHAR(20),
PRIMARY KEY(mobile_number,username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE User_addresses
(
address VARCHAR(100),
username VARCHAR(20),
PRIMARY KEY(address,username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE 
)

CREATE TABLE Customer
(
username VARCHAR(20) PRIMARY KEY,
points DECIMAL(10,2),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Admins
(
username VARCHAR(20) PRIMARY KEY,
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Vendor
(
username VARCHAR(20) PRIMARY KEY,
activated BIT,
company_name VARCHAR(20),
bank_acc_no VARCHAR(20),
admin_username VARCHAR(20),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE NO ACTION ON UPDATE NO ACTION   -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
)

CREATE TABLE Delivery_Person
(
username VARCHAR(20) PRIMARY KEY,
is_activated BIT,
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Credit_Card
(
number VARCHAR(20) PRIMARY KEY,
expiry_date DATE,
cvv_code VARCHAR(4)
)

CREATE TABLE Delivery
(
id INT PRIMARY KEY IDENTITY,
type VARCHAR(20),
time_duration INT,
fees DECIMAL(5,3),
username VARCHAR(20),
FOREIGN KEY(username) REFERENCES Admins ON DELETE SET NULL ON UPDATE CASCADE
)

CREATE TABLE Orders
(
order_no INT PRIMARY KEY IDENTITY,
order_date DATETIME,
total_amount DECIMAL(10,2),
cash_amount DECIMAL(10,2),
credit_amount DECIMAL(10,2),
payment_type VARCHAR(10),
order_status VARCHAR(20),
remaining_days INT,
time_limit INT,
giftcard_code_used VARCHAR(10),
customer_name VARCHAR(20),
delivery_id INT,
creditCard_number VARCHAR(20),
FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(delivery_id) REFERENCES Delivery ON DELETE NO ACTION ON UPDATE NO ACTION,   -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
FOREIGN KEY(creditCard_number) REFERENCES Credit_Card ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(giftcard_code_used) REFERENCES Giftcard ON DELETE NO ACTION ON UPDATE NO ACTION  -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
)

CREATE TABLE Product
(
serial_no INT PRIMARY KEY IDENTITY,
product_name VARCHAR(20),
category VARCHAR(20),
product_description VARCHAR(MAX),
price DECIMAL(10,2),
final_price DECIMAL(10,2),
color VARCHAR(20),
available BIT,
rate INT,
vendor_username VARCHAR(20),
customer_username VARCHAR(20),
customer_order_id INT,
FOREIGN KEY(vendor_username) REFERENCES Vendor ON DELETE NO ACTION ON UPDATE NO ACTION,   -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
FOREIGN KEY(customer_username) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION,   -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
FOREIGN KEY(customer_order_id) REFERENCES Orders ON DELETE SET NULL ON UPDATE CASCADE
)

CREATE TABLE CustomerAddstoCartProduct
(
serial_no INT,
customer_name VARCHAR(20),
PRIMARY KEY(serial_no,customer_name),
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION  -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
)

CREATE TABLE Todays_Deals
(
deal_id INT PRIMARY KEY IDENTITY,
deal_amount DECIMAL(10,2),
expiry_date DATETIME,
admin_username VARCHAR(20),
FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE SET NULL ON UPDATE CASCADE
)

CREATE TABLE Todays_Deals_Product
(
deal_id INT,
serial_no INT,
PRIMARY KEY(deal_id,serial_no),
FOREIGN KEY(deal_id) REFERENCES Todays_Deals ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE NO ACTION ON UPDATE NO ACTION  -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
)

CREATE TABLE offer
(
offer_id INT PRIMARY KEY IDENTITY,
offer_amount DECIMAL(10,2),
expiry_date DATETIME,
)

CREATE TABLE offersOnProduct
(
offer_id INT,
serial_no INT,
PRIMARY KEY(offer_id,serial_no),
FOREIGN KEY(offer_id) REFERENCES offer ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Customer_Question_Product
(
serial_no INT,
customer_name VARCHAR(20),
question VARCHAR(50),
answer TEXT,
PRIMARY KEY(serial_no,customer_name),
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION   -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
)

CREATE TABLE Wishlist
(
username VARCHAR(20),
name VARCHAR(20),
PRIMARY KEY(username,name),
FOREIGN KEY(username) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE,
)

CREATE TABLE Giftcard
(
code VARCHAR(10) PRIMARY KEY,
expiry_date DATETIME,
amount DECIMAL(10,2),
username VARCHAR(20),
FOREIGN KEY(username) REFERENCES Admins ON DELETE SET NULL ON UPDATE CASCADE
)

CREATE TABLE Wishlist_Product
(
username VARCHAR(20),
wish_name VARCHAR(20),
serial_no INT,
PRIMARY KEY(username,wish_name,serial_no),
FOREIGN KEY(username,wish_name) REFERENCES Wishlist ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE NO ACTION ON UPDATE NO ACTION   -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
)

CREATE TABLE Admin_Customer_Giftcard
(
code VARCHAR(10),
customer_name VARCHAR(20),
admin_username VARCHAR(20),
remainingPoints DECIMAL(10,2),
PRIMARY KEY(code,customer_name,admin_username),
FOREIGN KEY(code) REFERENCES Giftcard ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION,  -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE NO ACTION ON UPDATE NO ACTION  -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
)

CREATE TABLE Admin_Delivery_Order
(
delivery_username VARCHAR(20),
order_no INT, 
admin_username VARCHAR(20), 
delivery_window VARCHAR(50),
PRIMARY KEY(delivery_username,order_no),
FOREIGN KEY(delivery_username) REFERENCES Delivery_Person ON DELETE NO ACTION ON UPDATE NO ACTION,   -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
FOREIGN KEY(order_no) REFERENCES Orders ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE NO ACTION ON UPDATE NO ACTION   -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
)

CREATE TABLE Customer_CreditCard
(
customer_name VARCHAR(20),
cc_number VARCHAR(20),
PRIMARY KEY(customer_name,cc_number),
FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(cc_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE
)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customer

GO
CREATE PROC customerRegister
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)
AS
INSERT INTO Users(username, first_name, last_name, password, email)
VALUES(@username, @first_name, @last_name, @password, @email)
INSERT INTO Customer(username,points)
VALUES(@username,0)


GO
CREATE PROC vendorRegister
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50),
@company_name VARCHAR(20),
@bank_acc_no VARCHAR(20)
AS
INSERT INTO Users(username, first_name, last_name, password, email)
VALUES(@username, @first_name, @last_name, @password, @email)
INSERT INTO Vendor(username, company_name, bank_acc_no, activated)
VALUES(@username, @company_name, @bank_acc_no, 0)


GO
CREATE PROC checkUsernameExist
@username VARCHAR(20),
@output BIT OUTPUT
AS
IF EXISTS (SELECT username FROM Users WHERE username = @username)
SET @output = 1
ELSE
SET @output = 0

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC userLogin
@username VARCHAR(20),
@password VARCHAR(20),
@success BIT OUTPUT,
@type INT OUTPUT
AS
IF EXISTS (SELECT username FROM Users WHERE (username = @username) AND (password = @password))
BEGIN
SET @success = 'True'
IF EXISTS (SELECT username FROM Customer WHERE (username = @username))
SET @type = 0
IF EXISTS (SELECT username FROM Vendor WHERE (username = @username))
SET @type = 1
IF EXISTS (SELECT username FROM Admins WHERE (username = @username))
SET @type = 2
IF EXISTS (SELECT username FROM Delivery_Person WHERE (username = @username))
SET @type = 3
END
ELSE
BEGIN
SET @success = 'False'
SET @type = -1
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Added

GO
CREATE PROC mobileExist
@username VARCHAR(20),
@mobile VARCHAR(20),
@output BIT OUTPUT
AS
IF EXISTS(SELECT * FROM User_mobile_numbers WHERE (username = @username) AND (mobile_number = @mobile))
SET @output = 1
ELSE
SET @output = 0

GO
CREATE PROC itemsCount
@username VARCHAR(20),
@count INT OUTPUT
AS
SELECT @count = COUNT(*)
FROM CustomerAddstoCartProduct
WHERE customer_name = @username

GO
CREATE PROC returnPoints
@username VARCHAR(20),
@points DECIMAL(10,2) OUTPUT
AS
SELECT @points = points
FROM Customer
WHERE username = @username

GO
CREATE PROC getOrderId
@username VARCHAR(20),
@orderId INT OUTPUT
AS
SELECT TOP 1 @orderId = order_no
FROM Orders 
WHERE customer_name = @username
ORDER BY order_no DESC

GO
CREATE PROC checkNotPayOrder
@username VARCHAR(20),
@output BIT OUTPUT
AS
IF EXISTS(SELECT * FROM Orders WHERE (customer_name = @username) AND (payment_type IS NULL))
SET @output = 1
ELSE 
SET @output = 0

GO
CREATE PROC getOrdersOfCustomer
@username VARCHAR(20)
AS
SELECT order_no
FROM Orders
WHERE (customer_name = @username) AND (payment_type IS NULL)

GO
CREATE PROC checkPayAmountValid
@username VARCHAR(20),
@orderId INT,
@amount DECIMAL(10,2),
@valid BIT OUTPUT,
@pointsCanBeUsed DECIMAL(10,2) OUTPUT,
@pointsUsed DECIMAL(10,2) OUTPUT, 
@totalAmount DECIMAL(10,2) OUTPUT
AS
SELECT @totalAmount = total_amount
FROM Orders
WHERE order_no = @orderId

DECLARE @customerPoints DECIMAL(10,2)
SELECT @customerPoints = points
FROM Customer
WHERE username = @username

SET @pointsUsed = @totalAmount - @amount
IF (@customerPoints > @totalAmount)
SET @pointsCanBeUsed = @totalAmount
ELSE
SET @pointsCanBeUsed = @customerPoints

IF ((@amount <= @totalAmount) AND (@amount >= 0))
BEGIN
IF(@pointsUsed > @pointsCanBeUsed)
SET @valid = 0
ELSE
SET @valid = 1
END
ELSE
SET @valid = 0

GO
CREATE PROC CustomerHasCredit
@username VARCHAR(20),
@output BIT OUTPUT
AS
IF EXISTS (SELECT * FROM Customer_CreditCard WHERE customer_name = @username)
SET @output = 1
ELSE 
SET @output = 0

GO
CREATE PROC getCustomerCredit
@username VARCHAR(20)
AS
SELECT cc_number
FROM Customer_CreditCard
WHERE customer_name = @username

GO
CREATE PROC OrderToBeCanceledExist
@username VARCHAR(20),
@output BIT OUTPUT
AS
IF EXISTS (SELECT * FROM Orders WHERE (customer_name = @username) AND ((order_status = 'not processed') OR (order_status = 'in process')))
SET @output = 1
ELSE 
SET @output = 0

GO
CREATE PROC getOrdersToBeCanceled
@username VARCHAR(20)
AS
SELECT order_no
FROM Orders
WHERE (customer_name = @username) AND ((order_status = 'not processed') OR (order_status = 'in process'))

insert into Product(final_price)
values(55.55)

exec addToCart 'customer1',50

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC addMobile
@username VARCHAR(20),
@mobile_number VARCHAR(20)
AS
INSERT INTO User_mobile_numbers(username, mobile_number)
VALUES(@username, @mobile_number)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC addAddress
@username VARCHAR(20),
@address VARCHAR(100)
AS
INSERT INTO User_addresses(username, address)
VALUES(@username, @address)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC showProducts
AS
SELECT product_name,product_description,price,final_price,color
FROM Product

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC ShowProductsbyPrice
AS
SELECT product_name,product_description,price,color
FROM Product
ORDER BY price

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC searchbyname
@text VARCHAR(20)
AS
SELECT product_name,product_description,price,final_price,color
FROM Product
WHERE product_name LIKE @text + '%'

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC AddQuestion
@serial INT,
@customer VARCHAR(20),
@Question VARCHAR(50)
AS
INSERT INTO Customer_Question_Product(serial_no, customer_name, question)
VALUES(@serial, @customer, @Question)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC addToCart
@customername VARCHAR(20),
@serial INT
AS
INSERT INTO CustomerAddstoCartProduct(customer_name, serial_no)
VALUES(@customername, @serial)


GO
CREATE PROC removefromCart
@customername VARCHAR(20),
@serial INT
AS
DELETE FROM CustomerAddstoCartProduct WHERE (customer_name = @customername) AND (serial_no = @serial)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC createWishlist
@customername VARCHAR(20),
@name VARCHAR(20)
AS
INSERT INTO Wishlist(username, name)
VALUES(@customername, @name)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC AddtoWishlist
@customername VARCHAR(20),
@wishlistname VARCHAR(20),
@serial INT
AS
INSERT INTO Wishlist_Product(username, wish_name, serial_no)
VALUES(@customername, @wishlistname, @serial)


GO
CREATE PROC removefromWishlist
@customername VARCHAR(20),
@wishlistname VARCHAR(20),
@serial INT
AS
DELETE FROM Wishlist_Product WHERE (username = @customername) AND (wish_name = @wishlistname) AND (serial_no = @serial)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC showWishlistProduct
@customername VARCHAR(20),
@name VARCHAR(20)
AS
SELECT P.product_name,product_description,price,final_price,color
FROM Wishlist_Product WP INNER JOIN Product P ON WP.serial_no = P.serial_no
WHERE (WP.username = @customername) AND (WP.wish_name = @name)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC viewMyCart
@customer VARCHAR(20)
AS
SELECT P.product_name,product_description,price,final_price,color
FROM CustomerAddstoCartProduct C INNER JOIN Product P ON C.serial_no = P.serial_no
WHERE (C.customer_name = @customer)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC calculatepriceOrder
@customername VARCHAR(20),
@sum DECIMAL(10,2) OUTPUT
AS
SELECT @sum = SUM(P.final_price)
FROM CustomerAddstoCartProduct C INNER JOIN Product P ON C.serial_no = P.serial_no
WHERE C.customer_name = @customername


GO
CREATE PROC productsinorder
@customername VARCHAR(20), 
@orderID INT
AS
UPDATE P
SET P.available = 'False' , P.customer_username = @customername , P.customer_order_id = @orderID
FROM CustomerAddstoCartProduct C INNER JOIN Product P ON C.serial_no = P.serial_no
WHERE C.customer_name = @customername

DELETE C
FROM CustomerAddstoCartProduct C INNER JOIN Product P ON C.serial_no = P.serial_no
WHERE (C.customer_name <> @customername) AND (P.customer_order_id = @orderID)

SELECT *
FROM Product
WHERE customer_order_id = @orderID


GO
CREATE PROC emptyCart
@customername VARCHAR(20)
AS
DELETE FROM CustomerAddstoCartProduct WHERE customer_name = @customername


GO
CREATE PROC makeOrder
@customername VARCHAR(20)
AS
DECLARE @sum DECIMAL(10,2)
EXEC calculatepriceOrder @customername,@sum OUTPUT

INSERT INTO Orders(order_date, total_amount, order_status, customer_name)
VALUES(CURRENT_TIMESTAMP, @sum, 'not processed', @customername)

DECLARE @order_no INT
SELECT TOP 1 @order_no = order_no
FROM Orders 
ORDER BY order_no DESC

EXEC productsinorder @customername,@order_no

EXEC emptyCart @customername

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC cancelOrder
@orderid INT
AS
IF EXISTS (SELECT order_no FROM Orders WHERE (order_no = @orderid) AND ((order_status = 'not processed') OR (order_status = 'in process')))
BEGIN
DECLARE @totalAmount DECIMAL(10,2)
DECLARE @cash DECIMAL(10,2)
DECLARE @credit DECIMAL(10,2)
DECLARE @paymentType VARCHAR(10)
DECLARE @customername VARCHAR(20)
DECLARE @pointsUsed DECIMAL(10,2)
DECLARE @giftCard VARCHAR(10)
DECLARE @expirydate DATETIME

SELECT @totalAmount = total_amount , @cash = cash_amount , @credit = credit_amount , @paymentType = payment_type , @customername = customer_name , @giftCard = giftcard_code_used
FROM Orders
WHERE order_no = @orderid

IF(@paymentType = 'cash')  -- Start
BEGIN
IF(@cash IS NOT NULL)
BEGIN
SET @pointsUsed = @totalAmount - @cash
END

ELSE
BEGIN
SET @pointsUsed = @totalAmount
END

IF(@pointsUsed > 0)
BEGIN
SELECT @expirydate = expiry_date
FROM Giftcard
WHERE code = @giftCard

IF(CURRENT_TIMESTAMP <= @expirydate)
BEGIN
UPDATE Admin_Customer_Giftcard
SET remainingPoints = remainingPoints + @pointsUsed
WHERE (customer_name = @customername) AND (code = @giftCard)

UPDATE Customer
SET points = points + @pointsUsed
WHERE username = @customername
END
END
END  -- End

ELSE  -- Start
BEGIN
IF(@paymentType = 'credit')
BEGIN
IF(@credit IS NOT NULL)
BEGIN
SET @pointsUsed = @totalAmount - @credit
END

ELSE
BEGIN
SET @pointsUsed = @totalAmount
END

IF(@pointsUsed > 0)
BEGIN
SELECT @expirydate = expiry_date
FROM Giftcard
WHERE code = @giftCard

IF(CURRENT_TIMESTAMP <= @expirydate)
BEGIN
UPDATE Admin_Customer_Giftcard
SET remainingPoints = remainingPoints + @pointsUsed
WHERE (customer_name = @customername) AND (code = @giftCard)

UPDATE Customer
SET points = points + @pointsUsed
WHERE username = @customername
END
END
END
END  -- End

UPDATE Product
SET rate = NULL , customer_username = NULL , customer_order_id = NULL , available = 'True'
WHERE customer_order_id = @orderid

DELETE FROM Orders WHERE order_no = @orderid
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC returnProduct
@serialno INT,
@orderid INT
AS
DECLARE @finalPrice DECIMAL(10,2)
DECLARE @totalAmount DECIMAL(10,2)
DECLARE @pointsUsed DECIMAL(10,2)
DECLARE @paymentType VARCHAR(10)
DECLARE @cash DECIMAL(10,2)
DECLARE @credit DECIMAL(10,2)
DECLARE @giftCard VARCHAR(10)
DECLARE @expirydate DATETIME
DECLARE @customername VARCHAR(20)

SELECT @finalPrice = final_price
FROM Product
WHERE serial_no = @serialno

SELECT @totalAmount = total_amount , @paymentType = payment_type , @cash = cash_amount , @credit = credit_amount , @giftCard = giftcard_code_used , @customername = customer_name
FROM Orders
WHERE order_no = @orderid

SELECT @expirydate = expiry_date
FROM Giftcard
WHERE code = @giftCard

IF EXISTS (SELECT order_no FROM Orders WHERE order_no = @orderid)
BEGIN
DECLARE @countProductsInOrder INT
SELECT @countProductsInOrder = COUNT(*)
FROM Product
WHERE customer_order_id = @orderid

IF(@countProductsInOrder > 1)
BEGIN
DECLARE @totalAmountSubtracted DECIMAL(10,2)
SET @totalAmountSubtracted = @totalAmount - @finalPrice

UPDATE Orders
SET total_amount = @totalAmountSubtracted
WHERE order_no = @orderid
END

ELSE  -- if products count = 1
BEGIN --1
IF(@paymentType = 'cash')
BEGIN  --2
IF(@cash = @totalAmount)
BEGIN  --3
UPDATE Orders
SET total_amount = 0
WHERE order_no = @orderid
END  --3

ELSE
BEGIN  --4
IF(@cash IS NULL)
SET @pointsUsed = @totalAmount

ELSE
BEGIN
SET @pointsUsed = @totalAmount - @cash
END

IF(CURRENT_TIMESTAMP <= @expirydate)
BEGIN
UPDATE Admin_Customer_Giftcard
SET remainingPoints = remainingPoints + @pointsUsed
WHERE (customer_name = @customername) AND (code = @giftCard)

UPDATE Customer
SET points = points + @pointsUsed
WHERE username = @customername
END

UPDATE Orders
SET total_amount = 0
WHERE order_no = @orderid
END  --4
END  --2

ELSE
BEGIN
IF(@paymentType = 'credit')
BEGIN  --2
IF(@credit = @totalAmount)
BEGIN  --3
UPDATE Orders
SET total_amount = 0
WHERE order_no = @orderid
END  --3

ELSE
BEGIN  --4
IF(@credit IS NULL)
SET @pointsUsed = @totalAmount

ELSE
BEGIN
SET @pointsUsed = @totalAmount - @credit
END

IF(CURRENT_TIMESTAMP <= @expirydate)
BEGIN
UPDATE Admin_Customer_Giftcard
SET remainingPoints = remainingPoints + @pointsUsed
WHERE (customer_name = @customername) AND (code = @giftCard)

UPDATE Customer
SET points = points + @pointsUsed
WHERE username = @customername
END

UPDATE Orders
SET total_amount = 0
WHERE order_no = @orderid
END  --4
END  --2
END  --end of else (payment type is not cash)

END  --1
END  --end of (if order exists)

ELSE
BEGIN
INSERT INTO Orders(total_amount,cash_amount,payment_type)
VALUES(0,@finalPrice,'cash')
END

UPDATE Product
SET rate = NULL , customer_username = NULL , customer_order_id = NULL , available = 'True'
WHERE serial_no = @serialno

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO 
CREATE PROC ShowproductsIbought
@customername VARCHAR(20)
AS
SELECT product_name,product_description,price,final_price,color
FROM Product
WHERE customer_username = @customername

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC rate
@serialno INT,
@rate INT,
@customername VARCHAR(20)
AS
IF EXISTS (SELECT serial_no FROM Product WHERE (serial_no = @serialno) AND (customer_username = @customername))
BEGIN
UPDATE Product
SET rate = @rate
WHERE (serial_no = @serialno) AND (customer_username = @customername)
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO 
CREATE PROC SpecifyAmount
@customername VARCHAR(20),
@orderID INT,
@cash DECIMAL(10,2),
@credit DECIMAL(10,2),
@creditCard VARCHAR(20)
AS
DECLARE @orderTotalAmount DECIMAL(10,2)
SELECT @orderTotalAmount = total_amount
FROM Orders
WHERE order_no = @orderID

DECLARE @giftCard VARCHAR(10)
DECLARE @pointsUsed DECIMAL(10,2)

IF((@credit IS NULL) OR (@credit = 0))   -- Then he is paying with cash
BEGIN
IF(@cash = @orderTotalAmount)   -- Then no points are used
BEGIN
UPDATE Orders
SET payment_type = 'cash' , cash_amount = @cash , credit_amount = @credit
WHERE order_no = @orderID
END

ELSE
BEGIN
IF(@cash IS NOT NULL)
SET @pointsUsed = @orderTotalAmount - @cash

ELSE 
SET @pointsUsed = @orderTotalAmount

SELECT TOP 1 @giftCard = ACG.code
FROM Admin_Customer_Giftcard ACG INNER JOIN Giftcard G ON ACG.code = G.code
WHERE (ACG.customer_name = @customername) AND (CURRENT_TIMESTAMP <= G.expiry_date) AND (ACG.remainingPoints >= @pointsUsed) 

UPDATE Admin_Customer_Giftcard
SET remainingPoints = remainingPoints - @pointsUsed
WHERE (customer_name = @customername) AND (code = @giftCard)

UPDATE Customer
SET points = points - @pointsUsed
WHERE username = @customername

UPDATE Orders
SET payment_type = 'cash' , cash_amount = @cash , credit_amount = @credit , giftcard_code_used = @giftCard
WHERE order_no = @orderID
END
END

ELSE
BEGIN
IF((@cash IS NULL) OR (@cash = 0))   -- Then he is paying with credit card
BEGIN
IF(@credit = @orderTotalAmount)   -- Then no points are used
BEGIN
UPDATE Orders
SET payment_type = 'credit' , cash_amount = @cash , credit_amount = @credit , creditCard_number = @creditCard --HERE !!!!
WHERE order_no = @orderID
END

ELSE
BEGIN
SET @pointsUsed = @orderTotalAmount - @credit

SELECT TOP 1 @giftCard = ACG.code
FROM Admin_Customer_Giftcard ACG INNER JOIN Giftcard G ON ACG.code = G.code
WHERE (ACG.customer_name = @customername) AND (CURRENT_TIMESTAMP <= G.expiry_date) AND (ACG.remainingPoints >= @pointsUsed) 

UPDATE Admin_Customer_Giftcard
SET remainingPoints = remainingPoints - @pointsUsed
WHERE (customer_name = @customername) AND (code = @giftCard)

UPDATE Customer
SET points = points - @pointsUsed
WHERE username = @customername

UPDATE Orders
SET payment_type = 'credit' , cash_amount = @cash , credit_amount = @credit , giftcard_code_used = @giftCard , creditCard_number = @creditCard --HERE !!!!
WHERE order_no = @orderID
END
END
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC AddCreditCard
@creditcardnumber VARCHAR(20),
@expirydate DATE,
@cvv VARCHAR(4),
@customername VARCHAR(20)
AS
INSERT INTO Credit_Card(number,expiry_date,cvv_code)
VALUES(@creditcardnumber,@expirydate,@cvv)

INSERT INTO Customer_CreditCard(customer_name,cc_number)
VALUES(@customername,@creditcardnumber)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC ChooseCreditCard
@creditcard VARCHAR(20),
@orderid INT
AS
UPDATE Orders
SET creditCard_number = @creditcard
WHERE order_no = @orderid

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC viewDeliveryTypes
AS
SELECT type,time_duration,fees
FROM Delivery

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO 
CREATE PROC specifydeliverytype
@orderID INT,
@deliveryID INT
AS
DECLARE @deliveryTimeduration INT
DECLARE @orderDate DATETIME
DECLARE @dateIncremented DATETIME
DECLARE @remainingdays INT

SELECT @deliveryTimeduration = time_duration
FROM Delivery
WHERE id = @deliveryID

SELECT @orderDate = order_date
FROM Orders
WHERE order_no = @orderID

SET @dateIncremented = @orderDate + @deliveryTimeduration
SET @remainingdays = DATEDIFF(DAY,CURRENT_TIMESTAMP,@dateIncremented)

IF(@remainingdays < 0)
SET @remainingdays = 0

UPDATE Orders
SET delivery_id = @deliveryID , remaining_days = @remainingdays
WHERE order_no = @orderID

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC trackRemainingDays
@orderid INT,
@customername VARCHAR(20),
@days INT OUTPUT
AS
DECLARE @orderDate DATETIME
DECLARE @deliveryID INT
DECLARE @deliveryTimeduration INT
DECLARE @dateIncremented DATETIME
DECLARE @remainingdays INT

SELECT @orderDate = order_date , @deliveryID = delivery_id
FROM Orders
WHERE order_no = @orderID

SELECT @deliveryTimeduration = time_duration
FROM Delivery
WHERE id = @deliveryID

SET @dateIncremented = @orderDate + @deliveryTimeduration
SET @remainingdays = DATEDIFF(DAY,CURRENT_TIMESTAMP,@dateIncremented)


IF(@remainingdays < 0)
SET @remainingdays = 0

UPDATE Orders
SET remaining_days = @remainingdays
WHERE order_no = @orderID

SET @days = @remainingdays
 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC recommmend
@customername VARCHAR(20)
AS
WITH Top_Categories AS(
SELECT TOP 3 P.category
FROM CustomerAddstoCartProduct CC INNER JOIN Product P ON CC.serial_no = P.serial_no
WHERE CC.customer_name = @customername
GROUP BY category
ORDER BY COUNT(*) DESC
)
, Wished_Products_In_Top_Categories AS(
SELECT P.*
FROM Wishlist_Product WP INNER JOIN Product P ON (WP.serial_no = P.serial_no) AND (WP.username <> @customername) INNER JOIN Top_Categories T On P.category = T.category
)
, Top_3_Serial_No AS(
SELECT TOP 3 serial_no
FROM Wished_Products_In_Top_Categories
GROUP BY serial_no
ORDER BY COUNT(*) DESC
)
, Serial_No_With_Product_Joined AS(   --Here we have Top 3 wished products based on categories
SELECT P.serial_no,product_name,category,product_description,price,final_price,color
FROM Top_3_Serial_No T INNER JOIN Product P ON T.serial_no = P.serial_no
)
, Items_In_My_Cart AS(
SELECT serial_no
FROM CustomerAddstoCartProduct
WHERE customer_name = @customername
)
, Cart_Of_Others AS(
SELECT *
FROM CustomerAddstoCartProduct
WHERE customer_name <> @customername
)
, Users_Similar_To_Me AS(
SELECT CO.customer_name
FROM Cart_Of_Others CO INNER JOIN Items_In_My_Cart IC ON CO.serial_no = IC.serial_no
)
, Top_Wished_Products_Of_Users_Similar_To_Me AS(
SELECT TOP 3 WP.serial_no
FROM Users_Similar_To_Me USM INNER JOIN Wishlist_Product WP ON USM.customer_name = WP.username
GROUP BY WP.serial_no
ORDER BY COUNT(*) DESC
)
, ProductsInfo AS(   --Here we have top 3 wished products based on users similar to me 
SELECT P.serial_no,product_name,category,product_description,price,final_price,color
FROM Product P INNER JOIN Top_Wished_Products_Of_Users_Similar_To_Me T ON P.serial_no = T.serial_no
)
SELECT *
FROM Serial_No_With_Product_Joined
UNION
SELECT *
FROM ProductsInfo

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--vendor

GO
CREATE PROC postProduct
@vendorUsername VARCHAR(20),
@product_name VARCHAR(20) ,
@category VARCHAR(20), 
@product_description VARCHAR(MAX) ,
@price DECIMAL(10,2),
@color VARCHAR(20)
AS
INSERT INTO Product(available,final_price,vendor_username,product_name,category,product_description,price,color)
VALUES('1',@price,@vendorUsername,@product_name,@category,@product_description,@price,@color)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC vendorviewProducts
@vendorname VARCHAR(20)
AS
SELECT *
FROM Product
WHERE @vendorname = vendor_username

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC EditProduct
@vendorname VARCHAR(20),
@serialnumber INT,
@product_name VARCHAR(20) ,
@category VARCHAR(20),
@product_description VARCHAR(MAX) ,
@price DECIMAL(10,2),
@color VARCHAR(20)
AS
UPDATE Product
SET product_name = @product_name,category = @category,product_description = @product_description,price = @price,final_price = @price,color = @color
WHERE vendor_username = @vendorname AND serial_no = @serialnumber

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC deleteProduct
@vendorname VARCHAR(20),
@serialnumber INT
AS
DELETE FROM Product WHERE vendor_username = @vendorname AND serial_no = @serialnumber
DELETE FROM Todays_Deals_Product WHERE serial_no = @serialnumber
DELETE FROM Wishlist_Product WHERE serial_no = @serialnumber

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC viewQuestions
@vendorname VARCHAR(20)
AS
SELECT cqp.serial_no ,cqp.customer_name ,cqp.question ,cqp.answer
FROM Product p INNER JOIN Customer_Question_Product cqp ON p.serial_no = cqp.serial_no
WHERE vendor_username = @vendorname AND question IS NOT NULL   --???????????????????????????????????????

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC answerQuestions
@vendorname VARCHAR(20),
@serialno INT,
@customername VARCHAR(20),
@answer text
AS
UPDATE cqp
SET cqp.answer = @answer
FROM Customer_Question_Product cqp INNER JOIN Product p ON cqp.serial_no = p.serial_no   --?????????????????
WHERE p.vendor_username = @vendorname AND p.serial_no = @serialno

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC addOffer
@offeramount INT,
@expiry_date DATETIME
AS
INSERT INTO offer(offer_amount,expiry_date) VALUES(@offeramount,@expiry_date)


GO 
CREATE PROC checkOfferonProduct
@serial INT,
@activeoffer BIT OUTPUT
AS
IF EXISTS (SELECT serial_no FROM offersOnProduct WHERE serial_no = @serial)
BEGIN
SET @activeoffer = '1'
END
ELSE
SET @activeoffer = '0'


GO 
CREATE PROC checkandremoveExpiredoffer
@offerid INT
AS
DECLARE @expiryOffer DATETIME
SELECT @expiryOffer = expiry_date FROM offer WHERE offer_id = @offerid
IF(@expiryOffer <= CURRENT_TIMESTAMP)
BEGIN
UPDATE p
SET p.final_price = p.price 
FROM offersOnProduct op INNER JOIN Product p ON op.serial_no = p.serial_no
WHERE op.offer_id = @offerid
DELETE FROM offer WHERE offer_id = @offerid
END


GO
CREATE PROC applyOffer
@vendorname VARCHAR(20),
@offerid INT,
@serial INT
AS
DECLARE @checkP BIT
EXEC checkOfferonProduct @serial, @checkP OUTPUT
IF (@checkP = '0')
BEGIN
IF ((SELECT expiry_date FROM offer WHERE offer_id = @offerid) > CURRENT_TIMESTAMP)
INSERT INTO offersOnProduct(offer_id,serial_no) VALUES(@offerid,@serial)
UPDATE p
SET p.final_price = p.price - o.offer_amount
FROM offersOnProduct op INNER JOIN Product p ON op.serial_no = p.serial_no INNER JOIN offer o ON o.offer_id = op.offer_id
WHERE p.serial_no = @serial AND o.offer_id = @offerid
END
ELSE
PRINT 'The product has an active offer'

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Admin

GO
CREATE PROC activateVendors
@admin_username varchar(20),
@vendor_username varchar(20)
AS 
update Vendor
SET activated = 'True' , admin_username = @admin_username
WHERE username = @vendor_username

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC inviteDeliveryPerson 
@delivery_username varchar(20),
@delivery_email varchar(50) 
AS
INSERT INTO Users(username,email)
VALUES(@delivery_username,@delivery_email)
INSERT INTO Delivery_Person(username)
VALUES(@delivery_username)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC reviewOrders
AS
SELECT *
FROM Orders

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC updateOrderStatusInProcess
@order_no int 
AS
UPDATE Orders
SET order_status = 'in processs'
WHERE order_no = @order_no

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC addDelivery 
@delivery_type varchar(20),
@time_duration int,
@fees decimal(5,3),
@admin_username varchar(20) 
AS
INSERT INTO Delivery(type,time_duration,fees,username)  -- username not admin_username
VALUES(@delivery_type,@time_duration,@fees,@admin_username)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC assignOrdertoDelivery
@delivery_username varchar(20),
@order_no int,
@admin_username varchar(20)
AS
INSERT INTO Admin_Delivery_Order(delivery_username,order_no,admin_username) VALUES (@delivery_username,@order_no,@admin_username)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC createTodaysDeal
@deal_amount int,
@admin_username varchar(20),
@expiry_date datetime
AS
INSERT INTO Todays_Deals VALUES (@deal_amount,@admin_username,@expiry_date)


GO
CREATE PROC checkTodaysDealOnProduct
@serial_no INT,
@activeDeal BIT OUTPUT
AS
IF EXISTS (SELECT serial_no FROM Todays_Deals_Product WHERE (serial_no = @serial_no))
BEGIN 
SET @activeDeal = '1'
END
ELSE 
SET @activeDeal = '0'


GO
CREATE PROC addTodaysDealOnProduct
@deal_id int, 
@serial_no int
AS

DECLARE @hasActive BIT
EXEC checkTodaysDealOnProduct @serial_no ,
@hasActive 

IF (@hasActive = '0')
BEGIN
INSERT INTO Todays_Deals_Product VALUES (@deal_id,@serial_no)

UPDATE p
SET p.final_price = p.price - td.deal_amount
FROM Product p INNER JOIN Todays_Deals_Product tdp ON p.serial_no = tdp.serial_no INNER JOIN Todays_Deals td ON tdp.deal_id = td.deal_id
WHERE p.serial_no = @serial_no
END
ELSE
BEGIN
EXEC removeExpiredDeal @deal_id
END


GO
CREATE PROC removeExpiredDeal
@deal_iD INT
AS
DECLARE @expiryDeal DATETIME
SELECT @expiryDeal = expiry_date FROM Todays_Deals WHERE deal_id = @deal_iD
IF (@expiryDeal <= CURRENT_TIMESTAMP)
BEGIN
UPDATE p
SET p.final_price = p.price
FROM Product p INNER JOIN Todays_Deals_Product tdp ON p.serial_no = tdp.serial_no
WHERE tdp.deal_id = @deal_iD

DELETE FROM Todays_Deals WHERE deal_id = @deal_iD
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC createGiftCard
@code VARCHAR(10),
@expiry_date DATETIME,
@amount INT,
@admin_username VARCHAR(20)
AS
INSERT INTO Giftcard VALUES (@code,@expiry_date,@amount,@admin_username)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC removeExpiredGiftCard
@code VARCHAR(10)
AS
DECLARE @expiryGC DATETIME
SELECT @expiryGC = expiry_date FROM Giftcard WHERE code = @code
IF (@expiryGC <= CURRENT_TIMESTAMP)
BEGIN
UPDATE c
SET c.points = c.points - acg.remainingpoints
FROM Customer c INNER JOIN Admin_Customer_Giftcard acg ON c.username = acg.customer_name 
WHERE acg.code = @code 

DELETE FROM Admin_Customer_Giftcard WHERE code = @code
DELETE FROM Giftcard WHERE code = @code
END


GO
CREATE PROC checkGiftCardOnCustomer
@code VARCHAR(10),
@activeGiftCard BIT OUTPUT
AS
IF EXISTS (SELECT code FROM Admin_Customer_Giftcard WHERE code = @code)
BEGIN
SET @activeGiftCard = '1'
END
ELSE 
SET @activeGiftCard = '0' 


GO
CREATE PROC giveGiftCardtoCustomer
@code varchar(10),
@customer_name varchar(20),
@admin_username varchar(20)
AS
DECLARE @pointsValid DECIMAL(10,2)
SELECT @pointsValid = SUM(AG.remainingPoints)
FROM Admin_Customer_Giftcard AG INNER JOIN Giftcard G on AG.code = G.code
WHERE (AG.customer_name = @customer_name) AND (CURRENT_TIMESTAMP <= G.expiry_date)

IF(@pointsValid IS NOT NULL)
BEGIN 
UPDATE Customer
SET points = @pointsValid
WHERE username = @customer_name
END

ELSE
BEGIN
UPDATE Customer
SET points = 0
WHERE username = @customer_name
END
DECLARE @expiry DATETIME
SELECT @expiry = expiry_date FROM Giftcard WHERE code = @code
IF (@expiry > CURRENT_TIMESTAMP)
BEGIN
DECLARE @GCamount DECIMAL 
SELECT @GCamount = amount FROM Giftcard WHERE code = @code
INSERT INTO Admin_Customer_Giftcard(admin_username,customer_name,code,remainingPoints) VALUES (@admin_username,@customer_name,@code,@GCamount)
UPDATE C
SET C.points = GC.remaining_points + C.points
FROM Customer C INNER JOIN Admin_Customer_Giftcard ACG ON C.username = ACG.customer_name INNER JOIN Giftcard GC ON GC.code = ACG.code
WHERE C.username = @customer_name AND GC.code = @code
END
ELSE
BEGIN
EXEC removeExpiredGiftCard @code
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Delivery person

GO
CREATE PROC acceptAdminInvitation
@delivery_username varchar(20) 
AS
UPDATE Delivery_Person
SET is_activated = 1
WHERE username = @delivery_username

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC deliveryPersonUpdateInfo
@username  varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password  varchar(20),
@email     varchar(50)
AS
UPDATE Users
SET first_name = @first_name , last_name = @last_name , password = @password , email = @email
WHERE username = @username

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC viewmyorders
@deliveryperson varchar(20)
AS
select O.*
from Orders O INNER JOIN Admin_Delivery_Order D ON O.order_no = D.order_no
where @deliveryperson = D.delivery_username

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC specifyDeliveryWindow
@delivery_username varchar(20),
@order_no int,
@delivery_window varchar(50) 
AS
UPDATE Admin_Delivery_Order
SET delivery_window = @delivery_window
WHERE (delivery_username = @delivery_username) AND (order_no = @order_no)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC updateOrderStatusOutforDelivery
@order_no int 
AS
UPDATE Orders
SET order_status = 'Out for delivery'
WHERE order_no = @order_no 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO
CREATE PROC updateOrderStatusDelivered
@order_no int 
AS
UPDATE Orders 
SET order_status = 'Delivered'
WHERE order_no = @order_no 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
