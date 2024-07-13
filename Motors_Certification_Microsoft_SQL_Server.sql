CREATE DATABASE MotorsCertification;
GO

USE MotorsCertification;
GO

-- Create orderdetails table
CREATE TABLE orderdetails (
    orderNumber INT,
    productCode VARCHAR(30),
    quantityOrdered INT,
    priceEach FLOAT,
    orderLineNumber SMALLINT
);

-- Create customers table
CREATE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50),
    contactLastName VARCHAR(50),
    contactFirstName VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(15),
    country VARCHAR(50),
    salesRepEmployeeNumber INT,
    creditLimit FLOAT
);

-- Create employees table
CREATE TABLE employees (
    employeeNumber INT PRIMARY KEY,
    lastName VARCHAR(50),
    firstName VARCHAR(50),
    extension VARCHAR(10),
    email VARCHAR(100),
    officeCode VARCHAR(10),
    reportsTo INT,
    jobTitle VARCHAR(50)
);

-- Create orders table
CREATE TABLE orders (
    orderNumber INT PRIMARY KEY,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    status VARCHAR(15),
    comments TEXT,
    customerNumber INT
);

-- Create offices table
CREATE TABLE offices (
    officeCode VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    postalCode VARCHAR(15),
    territory VARCHAR(50)
);

-- Create payments table
CREATE TABLE payments (
    customerNumber INT,
    checkNumber VARCHAR(50),
    paymentDate DATE,
    amount FLOAT
);

-- Create productlines table
CREATE TABLE productlines (
    productLine VARCHAR(50) PRIMARY KEY,
    textDescription VARCHAR(4000),
    htmlDescription TEXT NULL,
    image TEXT NULL
);

-- Create products table
CREATE TABLE products (
    productCode VARCHAR(15) PRIMARY KEY,
    productName VARCHAR(70),
    productLine VARCHAR(50),
    productScale VARCHAR(10),
    productVendor VARCHAR(50),
    productDescription TEXT,
    quantityInStock SMALLINT,
    buyPrice FLOAT,
    MSRP FLOAT
);


-- Ensure columns in payments table are NOT NULL
SELECT * FROM payments WHERE customerNumber IS NULL OR checkNumber IS NULL;

-- Updating Null Values
UPDATE payments
SET customerNumber = 0 -- or some valid default value
WHERE customerNumber IS NULL;

UPDATE payments
SET checkNumber = '' -- or some valid default value
WHERE checkNumber IS NULL;

--Setting Columns to NOT NULL
ALTER TABLE payments
ALTER COLUMN customerNumber INT NOT NULL;

ALTER TABLE payments
ALTER COLUMN checkNumber VARCHAR(50) NOT NULL;

--Adding Constraints
ALTER TABLE payments
ADD CONSTRAINT PK_Payments PRIMARY KEY (customerNumber, checkNumber);

ALTER TABLE payments
ADD CONSTRAINT FK_Payments_CustomerNumber FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber);



--Increase the length of the postalCode column in the 
--target database to match or exceed the length in the source data.
ALTER TABLE customers
ALTER COLUMN postalCode VARCHAR(50);

-- Ensure that the salesRepEmployeeNumber column in both the 
--source and destination have compatible data types and lengths. 
--Typically, this column should be an integer if it represents an employee number.
-- Check the data type of the salesRepEmployeeNumber column in the target table
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customers' AND COLUMN_NAME = 'salesRepEmployeeNumber';

-- Example: if it needs to be an INT
ALTER TABLE customers
ALTER COLUMN salesRepEmployeeNumber INT;



-- Question 2 = After designing the table insert records in the following 
-- orderdetails, employees, payments, products, customers, offices and orders table.
--NB: EXCEL.CSV FILES AS BEEN CONVERTED TO TXT

-- Insert data into customers table
INSERT INTO customers (
    customerNumber,
    customerName,
    contactLastName,
    contactFirstName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    salesRepEmployeeNumber,
    creditLimit
) VALUES
(103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54, rue Royale', NULL, 'Nantes', NULL, '44000', 'France', 1370, 21000),
(112, 'Signal Gift Stores', 'King', 'Jean', '7025551838', '8489 Strong St.', NULL, 'Las Vegas', 'NV', '83030', 'USA', 1166, 71800),
(114, 'Australian Collectors, Co.', 'Ferguson', 'Peter', '03 9520 4555', '636 St Kilda Road', 'Level 3', 'Melbourne', 'Victoria', '3004', 'Australia', 1611, 117300),
(119, 'La Rochelle Gifts', 'Labrune', 'Janine', '40.67.8555', '67, rue des Cinquante Otages', NULL, 'Nantes', NULL, '44000', 'France', 1370, 118200),
(121, 'Baane Mini Imports', 'Bergulfsen', 'Jonas', '07-98 9555', 'Erling Skakkes gate 78', NULL, 'Stavern', NULL, '4110', 'Norway', 1504, 81700),
(124, 'Mini Gifts Distributors Ltd.', 'Nelson', 'Susan', '4155551450', '5677 Strong St.', NULL, 'San Rafael', 'CA', '97562', 'USA', 1165, 210500),
(125, 'Havel & Zbyszek Co', 'Piestrzeniewicz', 'Zbyszek', '(26) 642-7555', 'ul. Filtrowa 68', NULL, 'Warszawa', NULL, '01-012', 'Poland', NULL, 0),
(128, 'Blauer See Auto, Co.', 'Keitel', 'Roland', '+49 69 66 90 2555', 'Lyonerstr. 34', NULL, 'Frankfurt', NULL, '60528', 'Germany', 1504, 59700),
(129, 'Mini Wheels Co.', 'Murphy', 'Julie', '6505555787', '5557 North Pendale Street', NULL, 'San Francisco', 'CA', '94217', 'USA', 1165, 64600),
(131, 'Land of Toys Inc.', 'Lee', 'Kwai', '2125557818', '897 Long Airport Avenue', NULL, 'NYC', 'NY', '10022', 'USA', 1323, 114900),
(141, 'Euro+ Shopping Channel', 'Freyre', 'Diego', '(91) 555 94 44', 'C/ Moralzarzal, 86', NULL, 'Madrid', NULL, '28034', 'Spain', 1370, 227600),
(144, 'Volvo Model Replicas, Co', 'Berglund', 'Christina', '0921-12 3555', 'Berguvsvägen  8', NULL, 'Luleå', NULL, 'S-958 22', 'Sweden', 1504, 53100),
(145, 'Danish Wholesale Imports', 'Petersen', 'Jytte', '31 12 3555', 'Vinbæltet 34', NULL, 'Kobenhavn', NULL, '1734', 'Denmark', 1401, 83400),
(146, 'Saveley & Henriot, Co.', 'Saveley', 'Mary', '78.32.5555', '2, rue du Commerce', NULL, 'Lyon', NULL, '69004', 'France', 1337, 123900),
(148, 'Dragon Souveniers, Ltd.', 'Natividad', 'Eric', '+65 221 7555', 'Bronz Sok.', 'Bronz Apt. 3/6 Tesvikiye', 'Singapore', NULL, '79903', 'Singapore', 1621, 103800),
(151, 'Muscle Machine Inc', 'Young', 'Jeff', '2125557413', '4092 Furth Circle', 'Suite 400', 'NYC', 'NY', '10022', 'USA', 1286, 138500),
(157, 'Diecast Classics Inc.', 'Leong', 'Kelvin', '2155551555', '7586 Pompton St.', NULL, 'Allentown', 'PA', '70267', 'USA', 1216, 100600),
(161, 'Technics Stores Inc.', 'Hashimoto', 'Juri', '6505556809', '9408 Furth Circle', NULL, 'Burlingame', 'CA', '94217', 'USA', 1165, 84600),
(166, 'Handji Gifts& Co', 'Victorino', 'Wendy', '+65 224 1555', '106 Linden Road Sandown', '2nd Floor', 'Singapore', NULL, '69045', 'Singapore', 1612, 97900),
(167, 'Herkku Gifts', 'Oeztan', 'Veysel', '+47 2267 3215', 'Brehmen St. 121', 'PR 334 Sentrum', 'Bergen', NULL, 'N 5804', 'Norway', 1504, 96800);

SELECT * FROM customers;

-- Insert data into orderdetails table
INSERT INTO orderdetails (
    orderNumber,
    productCode,
    quantityOrdered,
    priceEach,
    orderLineNumber
) VALUES
(10100, 'S18_1749', 30, 136, 3),
(10100, 'S18_2248', 50, 55.09, 2),
(10100, 'S18_4409', 22, 75.46, 4),
(10100, 'S24_3969', 49, 35.29, 1),
(10101, 'S18_2325', 25, 108.06, 4),
(10101, 'S18_2795', 26, 167.06, 1),
(10101, 'S24_1937', 45, 32.53, 3),
(10101, 'S24_2022', 46, 44.35, 2),
(10102, 'S18_1342', 39, 95.55, 2),
(10102, 'S18_1367', 41, 43.13, 1),
(10103, 'S10_1949', 26, 214.3, 11),
(10103, 'S10_4962', 42, 119.67, 4),
(10103, 'S12_1666', 27, 121.64, 8),
(10103, 'S18_1097', 35, 94.5, 10),
(10103, 'S18_2432', 22, 58.34, 2),
(10103, 'S18_2949', 27, 92.19, 12),
(10103, 'S18_2957', 35, 61.84, 14),
(10103, 'S18_3136', 25, 86.92, 13),
(10103, 'S18_3320', 46, 86.31, 16),
(10103, 'S18_4600', 36, 98.07, 5);

SELECT * FROM orderdetails;


-- Insert data into employees table
INSERT INTO employees (
    employeeNumber,
    lastName,
    firstName,
    extension,
    email,
    officeCode,
    reportsTo,
    jobTitle
) VALUES
(1002, 'Murphy', 'Diane', 'x5800', 'dmurphy@classicmodelcars.com', 1, NULL, 'President'),
(1056, 'Patterson', 'Mary', 'x4611', 'mpatterso@classicmodelcars.com', 1, 1002, 'VP Sales'),
(1076, 'Firrelli', 'Jeff', 'x9273', 'jfirrelli@classicmodelcars.com', 1, 1002, 'VP Marketing'),
(1088, 'Patterson', 'William', 'x4871', 'wpatterson@classicmodelcars.com', 6, 1056, 'Sales Manager (APAC)'),
(1102, 'Bondur', 'Gerard', 'x5408', 'gbondur@classicmodelcars.com', 4, 1056, 'Sale Manager (EMEA)'),
(1143, 'Bow', 'Anthony', 'x5428', 'abow@classicmodelcars.com', 1, 1056, 'Sales Manager (NA)'),
(1165, 'Jennings', 'Leslie', 'x3291', 'ljennings@classicmodelcars.com', 1, 1143, 'Sales Rep'),
(1166, 'Thompson', 'Leslie', 'x4065', 'lthompson@classicmodelcars.com', 1, 1143, 'Sales Rep'),
(1188, 'Firrelli', 'Julie', 'x2173', 'jfirrelli@classicmodelcars.com', 2, 1143, 'Sales Rep'),
(1216, 'Patterson', 'Steve', 'x4334', 'spatterson@classicmodelcars.com', 2, 1143, 'Sales Rep'),
(1286, 'Tseng', 'Foon Yue', 'x2248', 'ftseng@classicmodelcars.com', 3, 1143, 'Sales Rep'),
(1323, 'Vanauf', 'George', 'x4102', 'gvanauf@classicmodelcars.com', 3, 1143, 'Sales Rep'),
(1337, 'Bondur', 'Loui', 'x6493', 'lbondur@classicmodelcars.com', 4, 1102, 'Sales Rep'),
(1370, 'Hernandez', 'Gerard', 'x2028', 'ghernande@classicmodelcars.com', 4, 1102, 'Sales Rep'),
(1401, 'Castillo', 'Pamela', 'x2759', 'pcastillo@classicmodelcars.com', 4, 1102, 'Sales Rep'),
(1501, 'Bott', 'Larry', 'x2311', 'lbott@classicmodelcars.com', 7, 1102, 'Sales Rep'),
(1504, 'Jones', 'Barry', 'x102', 'bjones@classicmodelcars.com', 7, 1102, 'Sales Rep'),
(1611, 'Fixter', 'Andy', 'x101', 'afixter@classicmodelcars.com', 6, 1088, 'Sales Rep'),
(1612, 'Marsh', 'Peter', 'x102', 'pmarsh@classicmodelcars.com', 6, 1088, 'Sales Rep'),
(1619, 'King', 'Tom', 'x103', 'tking@classicmodelcars.com', 6, 1088, 'Sales Rep'),
(1621, 'Nishi', 'Mami', 'x101', 'mnishi@classicmodelcars.com', 5, 1056, 'Sales Rep'),
(1625, 'Kato', 'Yoshimi', 'x102', 'ykato@classicmodelcars.com', 5, 1621, 'Sales Rep'),
(1702, 'Gerard', 'Martin', 'x2312', 'mgerard@classicmodelcars.com', 4, 1102, 'Sales Rep');

SELECT * FROM employees;

-- Insert data into payments table
INSERT INTO payments (
    customerNumber,
    checkNumber,
    paymentDate,
    amount
) VALUES
(103, 'HQ336336', '2004-10-19', 6066.78),
(103, 'JM555205', '2003-06-05', 14571.44),
(103, 'OM314933', '2004-12-18', 1676.14),
(112, 'BO864823', '2004-12-17', 14191.12),
(112, 'HQ55022', '2003-06-06', 32641.98),
(112, 'ND748579', '2004-08-20', 33347.88),
(114, 'GG31455', '2003-05-20', 45864.03),
(114, 'MA765515', '2004-12-15', 82261.22),
(114, 'NP603840', '2003-05-31', 7565.08),
(114, 'NR27552', '2004-03-10', 44894.74),
(119, 'DB933704', '2004-11-14', 19501.82),
(119, 'LN373447', '2004-08-08', 47924.19),
(119, 'NG94694', '2005-02-22', 49523.67),
(121, 'DB889831', '2003-02-16', 50218.95),
(121, 'FD317790', '2003-10-28', 1491.38),
(121, 'KI831359', '2004-11-04', 17876.32),
(121, 'MA302151', '2004-11-28', 34638.14),
(124, 'AE215433', '2005-03-05', 101244.59),
(124, 'BG255406', '2004-08-28', 85410.87),
(124, 'CQ287967', '2003-04-11', 11044.3);

SELECT * FROM payments;

-- Insert data into producrs table
INSERT INTO products (
    productCode,
    productName,
    productLine,
    productScale,
    productVendor,
    productDescription,
    quantityInStock,
    buyPrice,
    MSRP
) VALUES
('S10_1678', '1969 Harley Davidson Ultimate Chopper', 'Motorcycles', '01:10', 'Min Lin Diecast', 'This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.', 7933, 48.81, 95.7),
('S10_1949', '1952 Alpine Renault 1300', 'Classic Cars', '01:10', 'Classic Metal Creations', 'Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 7305, 98.58, 214.3),
('S10_2016', '1996 Moto Guzzi 1100i', 'Motorcycles', '01:10', 'Highway 66 Mini Classics', 'Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail, rotating wheels, working kick stand, diecast metal with plastic parts and baked enamel finish.', 6625, 68.99, 118.94),
('S10_4698', '2003 Harley-Davidson Eagle Drag Bike', 'Motorcycles', '01:10', 'Red Start Diecast', 'Model features, official Harley Davidson logos and insignias, detachable rear wheelie bar, heavy diecast metal with resin parts, authentic multi-color tampo-printed graphics, separate engine drive belts, free-turning front fork, rotating tires and rear racing slick, certificate of authenticity, detailed engine, display stand, precision diecast replica, baked enamel finish, 1:10 scale model, removable fender, seat and tank cover piece for displaying the superior detail of the v-twin engine', 5582, 91.02, 193.66),
('S10_4757', '1972 Alfa Romeo GTA', 'Classic Cars', '01:10', 'Motor City Art Classics', 'Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 3252, 85.68, 136),
('S10_4962', '1962 LanciaA Delta 16V', 'Classic Cars', '01:10', 'Second Gear Diecast', 'Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 6791, 103.42, 147.74),
('S12_1099', '1968 Ford Mustang', 'Classic Cars', '01:12', 'Autoart Studio Design', 'Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color dark green.', 68, 95.34, 194.57),
('S12_1108', '2001 Ferrari Enzo', 'Classic Cars', '01:12', 'Second Gear Diecast', 'Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 3619, 95.59, 207.8),
('S12_1666', '1958 Setra Bus', 'Trucks and Buses', '01:12', 'Welly Diecast Productions', 'Model features 30 windows, skylights & glare resistant glass, working steering system, original logos', 1579, 77.9, 136.67),
('S12_2823', '2002 Suzuki XREO', 'Motorcycles', '01:12', 'Unimax Art Galleries', 'Official logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail, rotating wheels, working kick stand, diecast metal with plastic parts and baked enamel finish.', 9997, 66.27, 150.62),
('S12_3148', '1969 Corvair Monza', 'Classic Cars', '01:18', 'Welly Diecast Productions', '1:18 scale die-cast about 10 long doors open, hood opens, trunk opens and wheels roll', 6906, 60.0, 95.0),
('S12_3380', '1968 Dodge Charger', 'Classic Cars', '01:12', 'Welly Diecast Productions', '1:12 scale model of a 1968 Dodge Charger. Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color black', 9123, 75.16, 117.44),
('S12_3891', '1969 Ford Falcon', 'Classic Cars', '01:12', 'Second Gear Diecast', 'Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 1049, 83.05, 173.02),
('S12_3990', '1970 Plymouth Hemi Cuda', 'Classic Cars', '01:12', 'Studio M Art Models', 'Very detailed 1970 Plymouth Cuda model in 1:12 scale. The Cuda is generally accepted as one of the fastest original muscle cars from the 1970s. This model is a reproduction of one of the orginal 652 cars built in 1970. Red color.', 5663, 31.92, 79.8),
('S12_4473', '1957 Chevy Pickup', 'Trucks and Buses', '01:12', 'Exoto Designs', '1:12 scale die-cast about 20 long Hood opens, Rubber wheels', 6125, 55.7, 116.7),
('S12_4675', '1969 Dodge Charger', 'Classic Cars', '01:12', 'Welly Diecast Productions', 'Detailed model of the 1969 Dodge Charger. This model includes finely detailed interior and exterior features. Painted in red and white.', 7323, 58.73, 115.16),
('S18_1097', '1940 Ford Pickup Truck', 'Trucks and Buses', '01:18', 'Studio M Art Models', 'This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood, removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box', 2613, 58.33, 116.67),
('S18_1129', '1993 Mazda RX-7', 'Classic Cars', '01:18', 'Highway 66 Mini Classics', 'This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color red.', 3975, 83.51, 141.54),
('S18_1342', '1937 Lincoln Berline', 'Vintage Cars', '01:18', 'Motor City Art Classics', 'Features opening engine cover, doors, trunk, and fuel filler cap. Color black', 8693, 60.62, 102.74),
('S18_1367', '1936 Mercedes-Benz 500K Special Roadster', 'Vintage Cars', '01:18', 'Studio M Art Models', 'This 1:18 scale replica is constructed of heavy die-cast metal and has all the features of the original: working doors and rumble seat, independent spring suspension, detailed interior, working steering system, and a bifold hood that reveals an engine so accurate that it even includes the wiring. All this is topped off with a baked enamel finish. Color white.', 8635, 24.26, 53.91);

SELECT * FROM products;

-- Insert data into offices table
INSERT INTO offices (
    officeCode,
    city,
    phone,
    addressLine1,
    addressLine2,
    state,
    country,
    postalCode,
    territory
) VALUES
(1, 'San Francisco', '+1 650 219 4782', '100 Market Street', 'Suite 300', 'CA', 'USA', '94080', 'NA'),
(2, 'Boston', '+1 215 837 0825', '1550 Court Place', 'Suite 102', 'MA', 'USA', '02107', 'NA'),
(3, 'NYC', '+1 212 555 3000', '523 East 53rd Street', 'apt. 5A', 'NY', 'USA', '10022', 'NA'),
(4, 'Paris', '+33 14 723 4404', '43 Rue Jouffroy D''abbans', NULL, NULL, 'France', '75017', 'EMEA'),
(5, 'Tokyo', '+81 33 224 5000', '4-1 Kioicho', NULL, 'Chiyoda-Ku', 'Japan', '102-8578', 'Japan'),
(6, 'Sydney', '+61 2 9264 2451', '5-11 Wentworth Avenue', 'Floor #2', NULL, 'Australia', 'NSW 2010', 'APAC'),
(7, 'London', '+44 20 7877 2041', '25 Old Broad Street', 'Level 7', NULL, 'UK', 'EC2N 1HN', 'EMEA');

SELECT * FROM offices;

-- Insert data into orders table
INSERT INTO orders (
	orderNumber, 
	orderDate, 
	requiredDate, 
	shippedDate, 
	status, 
	comments, 
	customerNumber
) VALUES 
(10100, '2003-01-06', '2003-01-13', '2003-01-10', 'Shipped', NULL, 363),
(10101, '2003-01-09', '2003-01-18', '2003-01-11', 'Shipped', 'Check on availability.', 128),
(10102, '2003-01-10', '2003-01-18', '2003-01-14', 'Shipped', NULL, 181),
(10103, '2003-01-29', '2003-02-07', '2003-02-02', 'Shipped', NULL, 121),
(10104, '2003-01-31', '2003-02-09', '2003-02-01', 'Shipped', NULL, 141),
(10105, '2003-02-11', '2003-02-21', '2003-02-12', 'Shipped', NULL, 145),
(10106, '2003-02-17', '2003-02-24', '2003-02-21', 'Shipped', NULL, 278),
(10107, '2003-02-24', '2003-03-03', '2003-02-26', 'Shipped', 'Difficult to negotiate with customer. We need more marketing materials.', 131),
(10108, '2003-03-03', '2003-03-12', '2003-03-08', 'Shipped', NULL, 385),
(10109, '2003-03-10', '2003-03-19', '2003-03-11', 'Shipped', 'Customer requested that FedEx Ground is used for this shipping', 486),
(10110, '2003-03-18', '2003-03-24', '2003-03-20', 'Shipped', NULL, 187),
(10111, '2003-03-25', '2003-03-31', '2003-03-30', 'Shipped', NULL, 129),
(10112, '2003-03-24', '2003-04-03', '2003-03-29', 'Shipped', 'Customer requested that ad materials (such as posters, pamphlets) be included in the shipment', 144),
(10113, '2003-03-26', '2003-04-02', '2003-03-27', 'Shipped', NULL, 124),
(10114, '2003-04-01', '2003-04-07', '2003-04-02', 'Shipped', NULL, 172),
(10115, '2003-04-04', '2003-04-12', '2003-04-07', 'Shipped', NULL, 424),
(10116, '2003-04-11', '2003-04-19', '2003-04-13', 'Shipped', NULL, 381),
(10117, '2003-04-16', '2003-04-24', '2003-04-17', 'Shipped', NULL, 148),
(10118, '2003-04-21', '2003-04-29', '2003-04-26', 'Shipped', 'Customer has worked with some of our vendors in the past and is aware of their MSRP', 216),
(10119, '2003-04-28', '2003-05-05', '2003-05-02', 'Shipped', NULL, 382);

SELECT * FROM orders;

INSERT INTO productlines (
	productLine, 
	textDescription, 
	htmlDescription, 
	image
) VALUES
('Classic Cars', 'Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category. These replicas feature superb attention to detail and craftsmanship and offer features such as working steering system, opening forward compartment, opening rear trunk with removable spare wheel, 4-wheel independent spring suspension, and so on. The models range in size from 1:10 to 1:24 scale and include numerous limited edition and several out-of-production vehicles. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.', NULL, NULL),
('Motorcycles', 'Our motorcycles are state of the art replicas of classic as well as contemporary motorcycle legends such as Harley Davidson, Ducati and Vespa. Models contain stunning details such as official logos, rotating wheels, working kickstand, front suspension, gear-shift lever, footbrake lever, and drive chain. Materials used include diecast and plastic. The models range in size from 1:10 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. All models come fully assembled and ready for display in the home or office. Most include a certificate of authenticity.', NULL, NULL),
('Planes', 'Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, office or classroom decorations. Models contain stunning details such as official logos and insignias, rotating jet engines and propellers, retractable wheels, and so on. Most come fully assembled and with a certificate of authenticity from their manufacturers.', NULL, NULL),
('Ships', 'The perfect holiday or anniversary gift for executives, clients, friends, and family. These handcrafted model ships are unique, stunning works of art that will be treasured for generations! They come fully assembled and ready for display in the home or office. We guarantee the highest quality, and best value.', NULL, NULL),
('Trains', 'Model trains are a rewarding hobby for enthusiasts of all ages. Whether you''re looking for collectible wooden trains, electric streetcars or locomotives, you''ll find a number of great choices for any budget within this category. The interactive aspect of trains makes toy trains perfect for young children. The wooden train sets are ideal for children under the age of 5.', NULL, NULL),
('Trucks and Buses', 'The Truck and Bus models are realistic replicas of buses and specialized trucks produced from the early 1920s to present. The models range in size from 1:12 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. Materials used include tin, diecast and plastic. All models include a certificate of authenticity from their manufacturers and are a perfect ornament for the home and office.', NULL, NULL),
('Vintage Cars', 'Our Vintage Car models realistically portray automobiles produced from the early 1900s through the 1940s. Materials used include Bakelite, diecast, plastic and wood. Most of the replicas are in the 1:18 and 1:24 scale sizes, which provide the optimum in detail and accuracy. Prices range from $30.00 up to $180.00 for some special limited edition replicas. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.', NULL, NULL);

SELECT * FROM productlines;

---Question 4 => Delete the columns in productlines which are useless that do not infer anything.
SELECT * FROM productlines;

ALTER TABLE productlines
DROP COLUMN htmlDescription;

ALTER TABLE productlines
DROP COLUMN image;


--- Question 5=> Use a select statement to verify all insertions as well as updates.
-- Verify insertions and updates with select statements
SELECT * FROM orderdetails;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM orders;
SELECT * FROM offices;
SELECT * FROM payments;
SELECT * FROM productlines;
SELECT * FROM products;


---Question 6=> Find out the highest and the lowest amount.
-- Find the highest and the lowest amount
SELECT MAX(amount) AS HighestAmount, 
MIN(amount) AS LowestAmount FROM payments;



--- Question 7=> Give the unique count of customerName from customers.
--Unique count 
SELECT COUNT(DISTINCT customerName) 
AS UniqueCustomerNames FROM customers;


--- Question 8=> Create a view from customers and payments named cust_payment 
--  and select customerName, amount, contactLastName, contactFirstName who have paid.
--- Truncate and Drop the view after operation.

-- Create view cust_payment
CREATE VIEW cust_payment AS
SELECT c.customerName, p.amount, c.contactLastName, c.contactFirstName
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber;

-- Select from view
SELECT * FROM cust_payment;

-- Drop view after operation
DROP VIEW cust_payment;

--- Question 9=> Create a stored procedure on products which displays productLine for Classic Cars.

-- Create stored procedure for Classic Cars productLine

CREATE PROCEDURE GetClassicCars
AS
BEGIN
    SELECT * FROM products WHERE productLine = 'Classic Cars';
END;

-- Execute stored procedure
EXEC GetClassicCars;

---Question 10=> Create a function to get the creditLimit of customers less than 96800

-- Create function to get creditLimit of customers less than 96800

CREATE FUNCTION GetCreditLimit()
RETURNS TABLE
AS
RETURN
(
    SELECT customerNumber, customerName, creditLimit
    FROM customers
    WHERE creditLimit < 96800
);

-- Execute function
SELECT * FROM GetCreditLimit();


---Question 11=> Create Trigger to store transaction record for employee table which displays 
-- employeeNumber, lastName, FirstName and office code upon insertion

-- Create trigger for employee insert transactions

CREATE TRIGGER trg_employee_insert
ON employees
AFTER INSERT
AS
BEGIN
    SELECT employeeNumber, lastName, firstName, officeCode
    FROM inserted;
END;

--- Question 12=> Create a Trigger to display customer number if the amount is 
--  greater than 10,000

-- Create trigger to display customerNumber if amount > 10000
CREATE TRIGGER trg_payment_amount
ON payments
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE amount > 10000)
    BEGIN
        SELECT customerNumber FROM inserted WHERE amount > 10000;
    END;
END;

---Question 13=> Create Users, Roles and Logins according to 3 Roles: 
--			1. Admin, HR, and Employee. Admin can view full database and has full access, 
--			2. HR can view and access only employee and offices table. 
--			3. Employee can view all tables only.
--			Note: work from Admin role for any changes to be made for database.


-- Create Roles
CREATE ROLE Admin;
CREATE ROLE HR;
CREATE ROLE Employee;

-- Create logins
CREATE LOGIN AdminLogin WITH PASSWORD = 'StrongPassword1!';
CREATE LOGIN HRLogin WITH PASSWORD = 'StrongPassword2!';
CREATE LOGIN EmployeeLogin WITH PASSWORD = 'StrongPassword3!';


-- Create users for the logins
CREATE USER AdminUser FOR LOGIN AdminLogin;
CREATE USER HRUser FOR LOGIN HRLogin;
CREATE USER EmployeeUser FOR LOGIN EmployeeLogin;

-- Assign users to roles
EXEC sp_addrolemember 'Admin', 'AdminUser';
EXEC sp_addrolemember 'HR', 'HRUser';
EXEC sp_addrolemember 'Employee', 'EmployeeUser';

-- Grant AdminRole full access to the database
GRANT CONTROL ON DATABASE::MotorsCertification TO Admin;

-- Grant HRRole access to Employees table
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Employees TO HR;

-- Grant HRRole access to Offices table
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Offices TO HR;

-- Grant EmployeeRole read-only access to all tables
EXEC sp_msforeachtable 'GRANT SELECT ON ? TO Employee';


--- Question 14=> Schedule a Job which backups and schedule 
--			it according to developer preference.

SELECT SERVERPROPERTY('Edition')

SELECT IS_SRVROLEMEMBER('Sysadmin')


BACKUP DATABASE MotorsCertification TO DISK = 'C:\Backups\MotorsCertification.bak';


