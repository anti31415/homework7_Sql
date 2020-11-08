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
	name VARCHAR(255)
);

-- Create first normal form table
CREATE TABLE credit_card
(
	card VARCHAR(25) PRIMARY KEY,
	id_card_holder INT,
	FOREIGN KEY (id_card_holder) REFERENCES card_holder(id)
);

-- Create second normal form `family` table
CREATE TABLE merchant_category
(
	id INT PRIMARY KEY,
	name VARCHAR(255)
);

-- Create second normal form `child` table
CREATE TABLE merchant
(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	id_merchant_category int,
	FOREIGN KEY (id_merchant_category) REFERENCES merchant_category(id)
);

-- Create raw data for third normal form use case
CREATE TABLE transaction
(
	id INT PRIMARY KEY,
	date timestamp without time zone DEFAULT now() NOT NULL,
	amount numeric(8,2) NOT NULL,
	card VARCHAR(25),
	FOREIGN KEY (card) REFERENCES credit_card(card),
	id_merchant INT,
	FOREIGN KEY (id_merchant) REFERENCES merchant(id)
);

-- Create a new table card_info with cardholder_id and card number
/* select * from transaction*/
DROP TABLE IF EXISTS card_info;
create table card_info as select 
  a.id as cardholder_id
, a.name
, b.card
from card_holder a
left join credit_card b on a.id = b.id_card_holder;

-- Create a new table merchant_info with merchant id and merchant_category
create table merchant_info as select 
  a.id as id_merchant
, a.name
, b.id as id_merchant_cat
, b.name as merchant_category
from merchant a
left join merchant_category b on a.id_merchant_category = b.id;

select * from card_info

select b.cardholder_id, a.date, sum(amount) FROM transaction a
left join card_info b on a.card = b.card
where b.cardholder_id =2 or b.cardholder_id =18
group by b.cardholder_id, a.date
order by b.cardholder_id, a.date
;

select b.cardholder_id, a.date, sum(amount) as amount FROM transaction a
left join card_info b on a.card = b.card
where b.cardholder_id =25 and a.date < '2018-07-01'
group by b.cardholder_id, a.date
order by a.date
;

