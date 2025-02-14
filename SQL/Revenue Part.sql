SELECT * FROM Apr_June_cleaned ajc;

SELECT * FROM Jan_Mar_cleaned jmc;
select * FROM Oct_Dec_cleaned odc;
SELECT * FROM July_Sep_cleaned jsc;

-- create new table to merge all data
CREATE TABLE 2024_sales_data (
	id INT AUTO_INCREMENT PRIMARY KEY,
	payment_date DATETIME,
	invoice_number VARCHAR(50),
	transaction_number INT,
	card_brand VARCHAR(50),
	card_number INT,
	currency VARCHAR(50),
	amount DOUBLE,
	customer_name VARCHAR(50),
	order_date DATETIME
);

ALTER TABLE 2024_sales_data
MODIFY COLUMN payment_date VARCHAR(50), 
MODIFY COLUMN order_date VARCHAR(50);

USE `HP Irvine Sales Analysis`;

DESCRIBE 2024_sales_data;

-- Insert data into one table
INSERT INTO 2024_sales_data (payment_date, invoice_number, transaction_number, card_brand, card_number, currency, amount, customer_name, order_date)
SELECT `Payment Date`, `Invoice Number`, `Transaction #`, `Card Brand`, `Card Number`, `Currency`, `Amount`, `Customer Name`, `Order Date`
FROM Jan_Mar_cleaned;

INSERT INTO 2024_sales_data (payment_date, invoice_number, transaction_number, card_brand, card_number, currency, amount, customer_name, order_date)
SELECT `Payment Date`, `Invoice Number`, `Transaction #`, `Card Brand`, `Card Number`, `Currency`, `Amount`, `Customer Name`, `Order Date`
FROM Apr_June_cleaned;

INSERT INTO 2024_sales_data (payment_date, invoice_number, transaction_number, card_brand, card_number, currency, amount, customer_name, order_date)
SELECT `Payment Date`, `Invoice Number`, `Transaction #`, `Card Brand`, `Card Number`, `Currency`, `Amount`, `Customer Name`, `Order Date`
FROM Oct_Dec_cleaned;

INSERT INTO 2024_sales_data (payment_date, invoice_number, transaction_number, card_brand, card_number, currency, amount, customer_name, order_date)
SELECT `Payment Date`, `Invoice Number`, `Transaction #`, `Card Brand`, `Card Number`, `Currency`, `Amount`, `Customer Name`, `Order Date`
FROM July_Sep_cleaned;

-- separate the payment date&time
ALTER TABLE `HP Irvine Sales Analysis`.`2024_sales_data` 
ADD COLUMN payment_date_only DATE AFTER payment_date,
ADD COLUMN payment_time_only TIME AFTER payment_date_only;

UPDATE `HP Irvine Sales Analysis`.`2024_sales_data` 
SET payment_date = REPLACE(payment_date, ' PST', '');

UPDATE `HP Irvine Sales Analysis`.`2024_sales_data` sd 
SET
	payment_date_only = STR_TO_DATE(payment_date, '%d-%b-%Y %h:%i %p'),
	payment_time_only = TIME(STR_TO_DATE(payment_date, '%d-%b-%Y %h:%i %p'));

UPDATE `HP Irvine Sales Analysis`.`2024_sales_data` sd 
SET payment_time_only = DATE_FORMAT(payment_time_only, '%H:%i');

-- separate order date & time
ALTER TABLE `HP Irvine Sales Analysis`.`2024_sales_data` 
ADD COLUMN order_date_only DATE AFTER order_date,
ADD COLUMN order_time_only TIME AFTER order_date_only;

UPDATE `HP Irvine Sales Analysis`.`2024_sales_data` sd 
SET order_date = REPLACE(order_date, ' PST', '');

UPDATE `HP Irvine Sales Analysis`.`2024_sales_data` sd 
SET
	order_date_only = STR_TO_DATE(order_date, '%d-%b-%Y %h:%i %p'),
	order_time_only = TIME(STR_TO_DATE(order_date, '%d-%b-%Y %h:%i %p'));

SELECT * FROM 2024_sales_data;

DESCRIBE 2024_sales_data;

-- calcuate the time_spent on each table
ALTER TABLE `HP Irvine Sales Analysis`.`2024_sales_data` 
ADD COLUMN time_spent TIME;


UPDATE `HP Irvine Sales Analysis`.`2024_sales_data` sd 
SET time_spent = 
	CASE 
		WHEN payment_date_only > order_date_only OR (payment_time_only < order_time_only) THEN 
		SEC_TO_TIME(TIME_TO_SEC(payment_time_only) + TIME_TO_SEC('24:00:00') - TIME_TO_SEC(order_time_only))
	ELSE 
		TIMEDIFF(payment_time_only, order_time_only)
	END;

-- remove duplicates
SELECT transaction_number, payment_date, COUNT(*) AS duplicate_count
FROM `HP Irvine Sales Analysis`.`2024_sales_data`
GROUP BY transaction_number, payment_date
HAVING COUNT(*) > 1;

DELETE t1
FROM `HP Irvine Sales Analysis`.`2024_sales_data` t1
JOIN `HP Irvine Sales Analysis`.`2024_sales_data` t2
ON t1.payment_date = t2.payment_date
   AND t1.id > t2.id
   AND t1.transaction_number IS NULL
   AND t2.transaction_number IS NULL;

-- find out the null
SELECT *
FROM `HP Irvine Sales Analysis`.`2024_sales_data`
WHERE payment_date IS NULL
   OR payment_date_only IS NULL
   OR payment_time_only IS NULL
   OR amount IS NULL;

-- 금액 소수점 두자리로 통일
UPDATE `HP Irvine Sales Analysis`.`2024_sales_data`
SET amount = ROUND(amount, 2);

-- find out the outliers
SELECT *
FROM `HP Irvine Sales Analysis`.`2024_sales_data`
WHERE amount < 0 OR amount > 10000;

-- standardize the currency to 'usd'
UPDATE `HP Irvine Sales Analysis`.`2024_sales_data`
SET currency = 'USD'
WHERE currency IS NULL OR currency = '';

-- import delivery sales & working on the UberEats data
SELECT * FROM `HP Irvine Sales Analysis`.UberEats_order_history_cleaned ueohc ;

ALTER TABLE `HP Irvine Sales Analysis`.UberEats_order_history_cleaned
ADD COLUMN time_ordered TIME AFTER `Date Ordered`;

UPDATE `HP Irvine Sales Analysis`.UberEats_order_history_cleaned 
SET time_ordered = TIME(`Time Customer Ordered`);

-- remove the cancelled order
DELETE FROM `HP Irvine Sales Analysis`.UberEats_order_history_cleaned 
WHERE `Ticket Size` = 0;

-- remove the duplicates
WITH CTE AS (
	SELECT *,
		ROW_NUMBER() OVER (PARTITION BY `Order ID`, `Date Ordered`, `Time Customer Ordered` ORDER BY `Order ID`) AS row_num
	FROM `HP Irvine Sales Analysis`.UberEats_order_history_cleaned 
)
DELETE FROM `HP Irvine Sales Analysis`.UberEats_order_history_cleaned 
WHERE `Order ID` IN (
	SELECT `Order ID`
	FROM CTE
	WHERE row_num > 1
);

ALTER TABLE `HP Irvine Sales Analysis`.UberEats_order_history_cleaned 
MODIFY COLUMN `Date Ordered` DATE;



-- cleaning doordash data
SELECT * FROM `HP Irvine Sales Analysis`.DoorDash_order_history_market_place_cleaned ddohmpc;

DESCRIBE `HP Irvine Sales Analysis`.DoorDash_order_history_market_place_cleaned;

ALTER TABLE `HP Irvine Sales Analysis`.DoorDash_order_history_market_place_cleaned 
MODIFY COLUMN `Order Placed Date` DATE,
MODIFY COLUMN `Order Placed Time` TIME;

SELECT * FROM `HP Irvine Sales Analysis`.DoorDash_sales_online_ordering_clenaed ddsooc;

ALTER TABLE `HP Irvine Sales Analysis`.DoorDash_sales_online_ordering_clenaed 
ADD COLUMN date_ordered DATE AFTER `Order Placed Time`,
ADD COLUMN time_ordered TIME AFTER `date_ordered`;

UPDATE `HP Irvine Sales Analysis`.DoorDash_sales_online_ordering_clenaed 
SET 
	date_ordered = DATE(`Order Placed Time`),
	time_ordered = TIME(`Order Placed Time`);

-- combine doordash data
CREATE TABLE `Doordash_sales_2024` AS
SELECT `Order ID`, DATE(`Order Placed Date`) AS date_ordered, TIME(`Order Placed Time`) AS time_ordered, Subtotal, Currency
FROM `HP Irvine Sales Analysis`.DoorDash_order_history_market_place_cleaned
UNION ALL
SELECT `Order ID`, date_ordered, time_ordered, Subtotal, Currency
FROM `HP Irvine Sales Analysis`.DoorDash_sales_online_ordering_clenaed;

SELECT * FROM `Doordash_sales_2024`;
DESCRIBE `Doordash_sales_2024`;

ALTER TABLE `Doordash_sales_2024`
MODIFY COLUMN Subtotal DECIMAL(10,2);


-- combine all the delivery data
CREATE TABLE delivery_sales_2024 (
	platform_name VARCHAR(50),
	date_ordered DATE,
	time_ordered TIME,
	amount DECIMAL(10,2),
	currency VARCHAR(50)
);

INSERT INTO delivery_sales_2024
SELECT 
	'DoorDash' AS platform_name,
	date_ordered, 
	time_ordered,
	Subtotal,
	Currency
FROM `Doordash_sales_2024`;

SELECT * FROM delivery_sales_2024;
USE 

INSERT INTO delivery_sales_2024
SELECT
	'UberEats' AS platform_name,
	`Date Ordered`,
	time_ordered,
	`Ticket Size`,
	`Currency Code`
FROM `HP Irvine Sales Analysis`.UberEats_order_history_cleaned;

SELECT TABLE_SCHEMA, TABLE_NAME
FROM information_schema.TABLES
WHERE TABLE_NAME = 'delivery_sales_2024';

USE `HP Irvine Sales Analysis`;

-- for the visualization, merge both delivery & direct sales into the same table
CREATE TABLE direct_delivery_sales_2024_fin(
	id INT AUTO_INCREMENT PRIMARY KEY,
	platform_name VARCHAR(50),
	transaction_id VARCHAR(50),
	order_date DATE,
	order_time TIME,
	amount DECIMAL(10,2)
);

USE `HP Irvine Sales Analysis`;

DESCRIBE direct_delivery_sales_2024_fin;
SELECT * FROM direct_delivery_sales_2024_fin;

INSERT INTO direct_delivery_sales_2024_fin(platform_name, transaction_id, order_date, order_time, amount)
SELECT 
	platform_name,
	NULL AS transaction_id,
	date_ordered AS order_date,
	time_ordered order_time,
	amount
FROM `HP Irvine Sales Analysis`.delivery_sales_2024 ds;

INSERT INTO direct_delivery_sales_2024_fin(platform_name, transaction_id, order_date, order_time, amount)
SELECT 
	'Direct Sales' AS platform_name,
	transaction_number AS transaction_id,
	order_date_only AS order_date,
	order_time_only AS order_time,
	amount
FROM `HP Irvine Sales Analysis`.`2024_sales_data` sd;

-- remove the duplicates
WITH ranked_data AS (
	SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY transaction_id, platform_name, order_date, amount
			ORDER BY id
		) AS row_num
	FROM direct_delivery_sales_2024_fin
)
DELETE FROM direct_delivery_sales_2024_fin
WHERE id IN (
	SELECT id
	FROM ranked_data
	WHERE row_num > 1
);

-- calculate the revenue contribution of each platform
SELECT platform_name,
	COUNT(*) AS total_orders,
	SUM(amount) AS total_revenue,
	ROUND(SUM(amount) / (SELECT SUM(amount) FROM direct_delivery_sales_2024_fin) * 100, 2) AS revenue_share
FROM direct_delivery_sales_2024_fin
GROUP BY platform_name
ORDER BY total_revenue DESC;

USE `HP Irvine Sales Analysis`;

-- analyze the monthly changes in revenue
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
	platform_name,
	SUM(amount) AS monthly_revenue
FROM direct_delivery_sales_2024_fin
GROUP BY month, platform_name
ORDER BY month;

-- analyze revnue distribution by hour of the day
SELECT HOUR(order_time) AS hour,
	platform_name,
	SUM(amount) AS revenue_by_hour
FROM direct_delivery_sales_2024_fin
GROUP BY hour, platform_name
ORDER BY hour;

SELECT * FROM direct_delivery_sales_2024_fin;
-- calculate the avg. ticket count per day
SELECT 
	DAYNAME(order_date) AS day_of_week,
	ROUND(COUNT(id) / COUNT(DISTINCT DATE(order_date)),0) AS avg_ticket_per_day,
	SUM(amount)
FROM 
	direct_delivery_sales_2024_fin
GROUP BY DAYNAME(order_date)
ORDER BY DAYNAME(order_date)

SELECT * FROM direct_delivery_sales_2024_fin;

-- calculate AOV of delivery & direct sales
SELECT 
	CASE 
		WHEN platform_name IN ('DoorDash', 'UberEats') THEN 'Delivery'
		ELSE platform_name
	END AS platform_group,
	ROUND(AVG(amount), 2) AS AOV
FROM direct_delivery_sales_2024_fin
GROUP BY platform_group;

-- calculate AOC of delivery & direct sales
SELECT
	DATE_FORMAT(order_date, '%Y-%m') AS month,
	platform_name,
	COUNT(id) AS total_orders,
	ROUND(COUNT(id) / COUNT(DISTINCT order_date),1) AS avg_orders_per_day
FROM direct_delivery_sales_2024_fin
GROUP BY month, platform_name
ORDER BY month, platform_name;
	

