CREATE TABLE credit_feed (
	customerId varchar NOT NULL PRIMARY KEY,
	scaledCreditFeed decimal(10,2) NOT NULL
	);

INSERT INTO credit_feed (customerId, scaledCreditFeed)
VALUES
('95244263', 25.66),
('95244264', 30.00);
