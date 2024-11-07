CREATE TABLE prioritized_interactions (
	customerId varchar NOT NULL,
	status varchar NOT NULL,
	interactionId varchar NOT NULL PRIMARY KEY,
	category varchar NOT NULL,
	skillId int NOT NULL,
	campaignName varchar NOT NULL,
	campaignId varchar NOT NULL,
	eventId varchar NOT NULL,
	expiresAt timestamp NOT NULL,
	priority decimal(10,2) NOT NULL,
	FOREIGN KEY (customerId) REFERENCES credit_feed(customerId),
	FOREIGN KEY (campaignId) REFERENCES message_score_feed(campaignId)
	);

INSERT INTO prioritized_interactions (customerId, status, interactionId, category, skillId, campaignName,campaignId, eventId, expiresAt, priority)
SELECT msd.customerId, msd.status, msd.interactionId, msd.category, msd.skillId, msd.campaignName,msd.campaignId, msd.eventId, msd.expiresAt, SUM(0.75 * msf.messageScore + 0.25 * cf.scaledCreditFeed) AS priority
FROM msd_interactions msd
JOIN message_score_feed msf
ON msd.campaignId = msf.campaignId
JOIN credit_feed cf
ON msd.customerId = cf.customerId
GROUP BY msd.customerId, msd.status, msd.interactionId, msd.category, msd.skillId, msd.campaignName,msd.campaignId, msd.eventId, msd.expiresAt;

