-- Drop tables
DROP TABLE IF EXISTS card_holder;
DROP TABLE IF EXISTS credit_card;
DROP TABLE IF EXISTS merchant_category;
DROP TABLE IF EXISTS merchant;
DROP TABLE IF EXISTS transaction;

-- Create raw data for first and second normal form use cases
CREATE TABLE card_holder 
(
	id INT PRIMARY KEY,
	FOREIGN KEY (id) REFERENCES credit_card(id_card_holder),
	name VARCHAR(255)
);

-- Create first normal form table
CREATE TABLE credit_card
(
	card VARCHAR(25) PRIMARY KEY,
	FOREIGN KEY (card) REFERENCES transaction(card),
	id_card_holder VARCHAR(255)
);

-- Create second normal form `family` table
CREATE TABLE merchant_category
(
	id INT PRIMARY KEY,
	FOREIGN KEY (id) REFERENCES merchant(id_merchant_category),
	name VARCHAR(255)
);

-- Create second normal form `child` table
CREATE TABLE merchant
(
	id INT PRIMARY KEY,
	FOREIGN KEY (id) REFERENCES transaction(id_merchant),
	name VARCHAR(255),
	id_merchant_category VARCHAR(255)
);

-- Create raw data for third normal form use case
CREATE TABLE transaction
(
	id INT PRIMARY KEY,
	date timestamp without time zone DEFAULT now() NOT NULL,
	amount VARCHAR(255),
	card VARCHAR(25),
	id_merchant INT
);


/* select * from transaction */


