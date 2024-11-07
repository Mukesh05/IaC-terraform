CREATE TABLE message_score_feed (
		subjectGroup varchar NOT NULL,
		campaignGoal varchar NOT NULL,
		messageScore int NOT NULL,
		campaignId varchar NOT NULL PRIMARY KEY
		);

INSERT INTO message_score_feed (subjectGroup, campaignGoal, messageScore, campaignId) 
VALUES
('Payments', 'Newsletter', 1, '190571'),
('Savings', 'Acquisitions', 20, '190572');

