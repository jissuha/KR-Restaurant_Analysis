SELECT * FROM `HP Irvine Sales Analysis`.`2024_Item_Sales_pos_cleaned`; 
SELECT * FROM `HP Irvine Sales Analysis`.Doordash_item_sales_cleaned disc;
SELECT * FROM `HP Irvine Sales Analysis`.UberEats_sales_item_cleaned uesic;


-- Add 'order type' to each table
ALTER TABLE `HP Irvine Sales Analysis`.`2024_Item_Sales_pos_cleaned` 
ADD COLUMN order_type VARCHAR(50);

UPDATE `HP Irvine Sales Analysis`.`2024_Item_Sales_pos_cleaned` 
SET order_type = CASE
	WHEN Name LIKE '%(TO)%' THEN 'pick-up'
	WHEN Name LIKE '%(On)%' THEN 'pick-up'
	ELSE 'dine-in'
END;

-- standardize the product names 
UPDATE `HP Irvine Sales Analysis`.`2024_Item_Sales_pos_cleaned` 
SET Name = TRIM(REPLACE(Name, '(TO)', ''))
WHERE Name LIKE '(TO)%';

UPDATE `HP Irvine Sales Analysis`.`2024_Item_Sales_pos_cleaned` 
SET Name = CASE
	WHEN Name LIKE '%Korean Beer%' THEN 'Bottled Beer'
	WHEN Name LIKE '%Beer (맥주)%' THEN 'Bottled Beer'
	WHEN Name LIKE '%Japanese Beer%' THEN 'Bottled Beer'
	WHEN Name LIKE '%Korean Beer%' THEN 'Bottled Beer'
	ELSE Name
END;

SELECT 
    Name,
    order_type,
    SUM(`Net Sales`) AS total_net_sales,
    SUM(Sold) AS total_sold
FROM `HP Irvine Sales Analysis`.`2024_Item_Sales_pos_cleaned`
GROUP BY Name, order_type;

UPDATE `HP Irvine Sales Analysis`.`2024_Item_Sales_pos_cleaned` 
SET Name = CASE
	WHEN Name = 'Maksa(막사)' THEN 'Maksa'
	WHEN Name = 'Mak Sa(막사)' THEN 'Maksa'
	WHEN Name = 'Grape Bong Bong' THEN 'Bonbon Grape Juice'
	WHEN Name = 'Grapefruit' THEN 'Grapefuit Soju Ball'
	WHEN Name = 'Mango ' THEN 'Mango Soju Ball'
	WHEN Name LIKE '%Blueade%' THEN 'Blueade Soju Ball'
	WHEN Name = 'Peach' THEN 'Peach Soju Ball'
	WHEN Name = 'Yuzu' THEN 'Yuzu Soju Ball'
	WHEN Name = 'Peach (복숭아)' THEN 'Peach Iced Blended Makgeolli'
	WHEN Name = 'Grapefriut (자몽)' THEN 'Grapefruit Iced Blended Makgeolli'
	WHEN Name = 'Strawberry (딸기)' THEN 'Strawberry Iced Blended Makgeolli'
	WHEN Name LIKE '%Honey%' THEN 'Honey Iced Blended Makgeolli'
	WHEN Name = 'Mango(망고)' THEN 'Mango Iced Blended Makgeolli'
	WHEN Name = 'Peach (복숭아칵테일)' THEN 'Peach Iced Blended Makgeolli'
	WHEN Name LIKE '%Blueade%' THEN 'Blueade Soju Ball'
	WHEN Name LIKE '%Apple Mojito%' THEN 'Apple Mojito Soju Ball'
	WHEN Name = 'Ilpoom Jinro Set' THEN 'Premium Soju Set'
	ELSE Name
END;

UPDATE `HP Irvine Sales Analysis`.`2024_Item_Sales_pos_cleaned` 
SET Name = CONCAT(SUBSTRING_INDEX(Name, ' ', 1), ' Soju Ball')
WHERE Name LIKE '%볼%';

SELECT DISTINCT Name, `Net Sales`, order_type
FROM `HP Irvine Sales Analysis`.`2024_Item_Sales_pos_cleaned` 
WHERE Name LIKE '%볼%';

-- add the order types to delivery item sales as well

ALTER TABLE `HP Irvine Sales Analysis`.Doordash_item_sales_cleaned
ADD COLUMN order_type VARCHAR(50);

UPDATE `HP Irvine Sales Analysis`.Doordash_item_sales_cleaned
SET order_type = 'delivery';

ALTER TABLE `HP Irvine Sales Analysis`.UberEats_sales_item_cleaned
ADD COLUMN order_type VARCHAR(50);
	
UPDATE `HP Irvine Sales Analysis`.UberEats_sales_item_cleaned
SET order_type = 'delivery';
	

-- create the new table to combine th edata
CREATE TABLE 2024_item_sales (
	name VARCHAR(50),
	net_sales DOUBLE(10,2),
	qty INT,
	order_type VARCHAR(10)
);

-- inser the data into the new table

INSERT INTO 2024_item_sales (name, net_sales, qty, order_type)
SELECT `Item Name`, `Gross Item Sales`, `Item Volume`, order_type
FROM `HP Irvine Sales Analysis`.Doordash_item_sales_cleaned disc;

INSERT INTO 2024_item_sales (name, net_sales, qty, order_type)
SELECT `Item`, `Sales`, `Items Sold`, order_type
FROM `HP Irvine Sales Analysis`.UberEats_sales_item_cleaned;

ALTER TABLE 2024_item_sales
ADD COLUMN modifier_name VARCHAR(55),
ADD COLUMN modifier_sold INT,
ADD COLUMN modifier_sales DOUBLE(10,2);

INSERT INTO 2024_item_sales (name, net_sales, qty, order_type, modifier_name, modifier_sold, modifier_sales)
SELECT `Name`, `Net Sales`, `sold`, order_type, `Modifier Name`, `Modifier Sold`, `Modifier Amount`
FROM `HP Irvine Sales Analysis`.`2024_Item_Sales_pos_cleaned`;

UPDATE 2024_item_sales
SET name = TRIM(name);

UPDATE 2024_item_sales
SET name = CASE 
	WHEN name = 'Soju (소주)' THEN 'Soju'
	WHEN name LIKE '%Dakbal%' THEN 'Hanshin Dakbal'
	WHEN name LIKE '%Kimchi Jeongol%' THEN 'Kimchi Jeongol'
	WHEN name LIKE '%beef%' AND name LIKE '%jeongol%' THEN 'Spicy Soft Tofu Jeongol with Beef'
	WHEN name = '차돌순두부 짬뽕전골 Spicy Soft Tofu Jeongol' THEN 'Spicy Soft Tofu Jeongol with Beef'
	WHEN name LIKE '%whole%' AND name LIKE '%chicken%' THEN 'Fried Whole Chicken'
	WHEN name = 'Sweet & Spicy Fried Chicken' THEN 'Yangnyeom Chicken'
	WHEN name = '양념치킨 Yangnyeom Chicken' THEN 'Yangnyeom Chicken'
	WHEN name = 'Pepper & Garlic Fried Chicken' THEN 'Gochu Maneul Chicken'
	WHEN name = '고추마늘 Gochu Maneul Chicken' THEN 'Gochu Maneul Chicken'
	WHEN name = '고추마늘치킨 Gochu Maneul Chicken' THEN 'Gochu Maneul Chicken'
	WHEN name LIKE '%gesal%' THEN 'Gesal-Gyeran Tang'
	WHEN name LIKE '%boneless%' THEN 'Boneless Fried Chicken'
	WHEN name LIKE '%홍합%' THEN 'Spicy Mussel Soup'
	WHEN name = '계란탕 Egg Soup' THEN 'Egg Soup'
	WHEN name = 'Steamed Eggs' THEN 'Egg Soup'
	WHEN name LIKE '%tomato sauce%' THEN 'Tomato Sauce Gyeran-Mari'
	WHEN name = 'Cheese "Gyeran-Mari"' THEN 'Cheese Gyeran-Mari'
	WHEN name = 'Seafood Soft Tofu Stew' THEN 'Seafood Soft Tofu Jjigae'
	WHEN name = '해물순두부 찌개 Seafood Soft Tofu Jjigae' THEN 'Seafood Soft Tofu Jjigae'
	WHEN name LIKE '%stir%' AND name LIKE '%udon%' THEN 'Stir-fried Udon with Brisket'
	WHEN name = 'Beef Brisket Tofu Stew' THEN 'Beef Soft Tofu Jjigae'
	WHEN name = '차돌순두부찌개 Beef Soft Tofu Jjigae' THEN 'Beef Soft Tofu Jjigae'
	WHEN name LIKE '%butter%' THEN 'Grilled Soy & Butter Squid'
	WHEN name LIKE '%pork%' THEN 'Pork Mozzarella Cheese Fondue'
	WHEN name LIKE '%gambas%' THEN 'Gambas al Ajillo "Garlic Shrimp"'
	WHEN name LIKE '%tteok%' THEN 'Beef Belly Tteokbokki'
	WHEN name = '닭똥집구이 Grilled Chicken Gizzards' THEN 'Grilled Chicken Gizzards'
	WHEN name = '닭똥집튀김 Fried Chicken Gizzards' THEN 'Fried Chicken Gizzards'
	WHEN name LIKE '%계%' THEN 'Cheese Gyeran-Mari'
	WHEN name LIKE '%김치%' THEN 'Kimchi Fried Rice'
	WHEN name LIKE '%해물%' THEN 'Stir-Fried Seafood'
	WHEN name = '오징어볶음 Stir-Fried Squid' THEN 'Stir-Fried Squid'
	WHEN name = '통오징어튀김 Fried Whole Squid' THEN 'Fried Whole Squid'
	WHEN name = '통오징어구이 Grilled Whole Suid' THEN 'Grilled Whole Squid'
	WHEN name LIKE '%fries%' THEN 'French Fries'
	WHEN name LIKE '%튀김%' THEN 'Fried Mandu'
	WHEN name LIKE '%onion%' THEN 'Chicken & Green Onion Muchim'
	WHEN name LIKE '%golb%' THEN 'Golbaengi Muchim'
	WHEN name LIKE '%maksa%' THEN 'Maksa'
	WHEN name LIKE '%oden%' THEN 'Oden-tang'
	WHEN name LIKE '%치킨%' THEN 'Chicken Mozzarella Cheese Fondue'
	WHEN name LIKE '%donk%' THEN 'Donkatsu'
	WHEN name LIKE '%bon%' THEN 'Bonbon Grape Juice'
	WHEN name LIKE '%pear%' THEN 'Korean Pear Juice'
	WHEN name LIKE '%sang%' THEN 'Sang Makgeolli'
	WHEN name LIKE '%Cheese Topping%' THEN 'Extra cheese'
	WHEN name = 'Extra cheese 치즈추가' THEN 'Extra cheese'
	WHEN name LIKE '%mandu with%' THEN 'Mandu with Cheese'
	WHEN name LIKE '%diy%' THEN 'DIY Rice Ball'
	WHEN name = '공기밥 A bowl of Rice' THEN 'White Rice'
	WHEN name LIKE '%ramyeon%' THEN 'Ramyeon Noodles'
	WHEN name = '우동사리 Udon Noodles' THEN 'Udon Noodles'
	WHEN name = 'Cass Beer' THEN 'Bottled Beer'
	WHEN name = 'Terra Beer' THEN 'Bottled Beer'
	WHEN name = 'Yogurt Soju' THEN 'Flavor Soju'
	WHEN name LIKE '%chamisul%' OR name LIKE '%jinro%' OR name LIKE '%saero%' THEN 'Soju'
	WHEN name LIKE '%소주%' OR name LIKE '%자두%' OR name LIKE '%사과%' THEN 'Flavor Soju'
	ELSE name 
END;

SELECT * FROM 2024_item_sales;

SELECT 
	name,
	order_type,
	SUM(net_sales) AS total_net_sales,
	SUM(qty) AS total_qty
FROM 2024_item_sales
GROUP BY name, order_type
ORDER BY total_net_sales DESC;

SELECT 
	name,
	SUM(net_sales) AS total_net_sales,
	SUM(qty) AS total_qty
FROM 2024_item_sales
GROUP BY name
ORDER BY total_net_sales DESC;

SELECT DISTINCT name, category FROM 2024_item_sales;

SELECT DISTINCT name 
FROM 2024_item_sales
WHERE category IS NULL;

-- Add catogory column
ALTER TABLE 2024_item_sales
ADD COLUMN category VARCHAR(20);

UPDATE 2024_item_sales
SET category = CASE
	WHEN name LIKE '%soju%' OR name LIKE '%beer%' OR name LIKE '%mak%' THEN 'alcohol'
	WHEN name LIKE '%백세주%' OR name LIKE '%복분자%' OR name LIKE '%chung%' OR name LIKE '%wine%' THEN 'alcohol'
	WHEN name LIKE '%hway%' OR name LIKE '%dok%' OR name LIKE '%sake%' THEN 'alcohol'
	WHEN name LIKE '%soup%' OR name LIKE '%tang%' OR name LIKE '%jjigae%' OR name LIKE '%jeongol%' THEN 'soup & jeongol'
	WHEN name LIKE '%juice%' OR name LIKE '%water%' OR name LIKE '%coke%' OR name LIKE '%spr%' OR name LIKE '%mil%' THEN 'non-alcohol'
	WHEN name LIKE '%fan%' OR name LIKE 'orange%' OR name LIKE '%pine%' OR name LIKE '%tea%' THEN 'non-alcohol'
	WHEN name LIKE '%combo%' THEN 'combo'
	WHEN name LIKE '%hwach%' OR name LIKE '%DIY%' OR name LIKE '%white%' OR name LIKE '%fried rice%' THEN 'sides'
	WHEN name LIKE '%fried mandu%' OR name LIKE '%fries%' OR name LIKE '%noodles%' OR name LIKE '%extra%' OR name LIKE '%jeon%' THEN 'sides'
	WHEN name = 'Tofu' OR name = 'Spam' OR name = 'Sausages' OR name = 'Soft Tofu' OR name = 'Boiled Egg' OR name = 'Kimchi' THEN 'sides'
	WHEN name = 'Fried Whole Chicken' OR name LIKE '%Gochu%' OR name LIKE '%boneless%' OR name LIKE '%yangnyeom%' THEN 'fried chicken'
	ELSE 'entree'
END;

-- calculate commission fee for delivery platforms

UPDATE 2024_item_sales
SET net_sales = net_sales * 0.75
WHERE order_type = 'delivery';

SELECT 
	name,
	category, 
	SUM(net_sales) AS total_net_sales, 
	SUM(qty) AS total_qty,
	order_type
FROM 2024_item_sales
GROUP BY name, category, order_type
ORDER BY total_net_sales DESC;

SELECT 
	category, 
	SUM(net_sales) AS total_net_sales, 
	SUM(qty) AS total_qty,
	ROUND((SUM(net_sales) / (SELECT SUM(net_sales) FROM 2024_item_sales) * 100), 1) AS percentage
FROM 2024_item_sales
GROUP BY category
ORDER BY percentage DESC;



