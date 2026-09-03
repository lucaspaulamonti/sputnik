CREATE TABLE RESETS(
	ID UUID PRIMARY KEY DEFAULT UUID_GENERATE_V4(),
    USER_ID UUID NOT NULL REFERENCES USERS(ID) ON DELETE CASCADE,
	IP_ADDRESS INET NOT NULL,
	USER_AGENT TEXT NOT NULL,
	TOKEN TEXT NOT NULL UNIQUE,
	USED_AT TIMESTAMPTZ,
	CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	EXPIRES_AT TIMESTAMPTZ NOT NULL,
	REVOKED_AT TIMESTAMPTZ
);

COMMENT ON TABLE RESETS IS 'Manages password reset requests for users.';
COMMENT ON COLUMN RESETS.ID IS 'Unique identifier of the password reset request.';
COMMENT ON COLUMN RESETS.ID_USER IS 'Identifier of the user requesting the password reset.';
COMMENT ON COLUMN RESETS.IP_ADDRESS IS 'IP address from which the password reset request was made.';
COMMENT ON COLUMN RESETS.USER_AGENT IS 'User-Agent of the client from which the password reset request was made.';
COMMENT ON COLUMN RESETS.TOKEN IS 'Unique token used to authenticate and authorize the password reset request.';
COMMENT ON COLUMN RESETS.USED_AT IS 'Timestamp when the password reset token was successfully used. NULL indicates that the token has not been used.';
COMMENT ON COLUMN RESETS.CREATED_AT IS 'Timestamp when the password reset request was created.';
COMMENT ON COLUMN RESETS.EXPIRES_AT IS 'Timestamp after which the password reset token is no longer valid.';
COMMENT ON COLUMN RESETS.REVOKED_AT IS 'Timestamp when the password reset token was revoked. NULL indicates that the token has not been revoked.';
