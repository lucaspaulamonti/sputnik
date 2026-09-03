CREATE TABLE ATTEMPTS(
	ID UUID PRIMARY KEY DEFAULT UUID_GENERATE_V4(),
    USER_ID UUID NOT NULL REFERENCES USERS(ID) ON DELETE CASCADE,
	IDENTIFIER TEXT NOT NULL,
	IP_ADDRESS INET NOT NULL,
	USER_AGENT TEXT NOT NULL,
	SUCCESS BOOLEAN NOT NULL,
	REASON TEXT NOT NULL,
	CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE ATTEMPTS IS 'Records user authentication attempts for security monitoring, auditing, and brute-force detection.';
COMMENT ON COLUMN ATTEMPTS.ID IS 'Unique identifier of the login attempt.';
COMMENT ON COLUMN ATTEMPTS.USER_ID IS 'Identifier of the user associated with the login attempt. NULL indicates that the user could not be identified.';
COMMENT ON COLUMN ATTEMPTS.IDENTIFIER IS 'Identifier provided during authentication, such as an email address or username.';
COMMENT ON COLUMN ATTEMPTS.IP_ADDRESS IS 'IP address from which the login attempt was made.';
COMMENT ON COLUMN ATTEMPTS.USER_AGENT IS 'User-Agent of the client from which the login attempt was made.';
COMMENT ON COLUMN ATTEMPTS.SUCCESS IS 'Indicates whether the login attempt was successful.';
COMMENT ON COLUMN ATTEMPTS.REASON IS 'Reason describing the outcome of the login attempt.';
COMMENT ON COLUMN ATTEMPTS.CREATED_AT IS 'Timestamp when the login attempt occurred.';

CREATE INDEX IX_ATTEMPTS__IDENTIFIER_CREATED_AT
ON ATTEMPTS(IDENTIFIER, CREATED_AT);

CREATE INDEX IX_ATTEMPTS__USER_ID_CREATED_AT
ON ATTEMPTS(USER_ID, CREATED_AT);

CREATE INDEX IX_ATTEMPTS__IP_ADDRESS_CREATED_AT
ON ATTEMPTS(IP_ADDRESS, CREATED_AT);

COMMENT ON INDEX IX_ATTEMPTS__IDENTIFIER_CREATED_AT IS 'Improves queries filtering login attempts by identifier and creation timestamp.';
COMMENT ON INDEX IX_ATTEMPTS__USER_ID_CREATED_AT IS 'Improves queries filtering login attempts by user and creation timestamp.';
COMMENT ON INDEX IX_ATTEMPTS__IP_ADDRESS_CREATED_AT IS 'Improves queries filtering login attempts by IP address and creation timestamp.';
