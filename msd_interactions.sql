CREATE TABLE msd_interactions (
	customerId varchar NOT NULL,
	status varchar NOT NULL,
	interactionId varchar NOT NULL PRIMARY KEY,
	category varchar NOT NULL,
	skillId int NOT NULL,
	campaignName varchar NOT NULL,
	campaignId varchar NOT NULL,
	eventId varchar NOT NULL,
	expiresAt timestamp NOT NULL
	);

INSERT INTO msd_interactions (customerId, status, interactionId, category, skillId, campaignName, campaignId, eventId, expiresAt)
VALUES
('95244263', 'OPEN', 'PHO-1020020', 'Postman Testing Create', 12345, 'Zelf Beleggende inactieve klanten','190571', 'EVT-123', '2025-01-01 00:00:00');