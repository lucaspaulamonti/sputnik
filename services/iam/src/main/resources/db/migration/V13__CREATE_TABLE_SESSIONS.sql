CREATE TABLE SESSIONS(
    ID UUID PRIMARY KEY DEFAULT UUID_GENERATE_V4(),
    USER_ID UUID NOT NULL REFERENCES USERS(ID) ON DELETE CASCADE,
    IP_ADDRESS INET NOT NULL,
	USER_AGENT TEXT NOT NULL,
	TOKEN TEXT NOT NULL UNIQUE,
    CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	EXPIRES_AT TIMESTAMPTZ NOT NULL,
	REVOKED_AT TIMESTAMPTZ
);

COMMENT ON TABLE SESSIONS IS 'Stores active and historical user authentication sessions.';
COMMENT ON COLUMN SESSIONS.ID IS 'Unique auto-incrementing session identifier (Primary Key).';
COMMENT ON COLUMN SESSIONS.USER_ID IS 'Identifier of the user associated with the session (Foreign Key).';
COMMENT ON COLUMN SESSIONS.IP_ADDRESS IS 'Origin IP address of the client when the session was created.';
COMMENT ON COLUMN SESSIONS.USER_AGENT IS 'Client browser/device User-Agent string.';
COMMENT ON COLUMN SESSIONS.TOKEN IS 'Unique session/authentication token (e.g., JWT hash or UUID).';
COMMENT ON COLUMN SESSIONS.CREATED_AT IS 'Timestamp when the session was created.';
COMMENT ON COLUMN SESSIONS.UPDATED_AT IS 'Timestamp when the session record was last updated.';
COMMENT ON COLUMN SESSIONS.EXPIRES_AT IS 'Timestamp when the session automatically expires.';
COMMENT ON COLUMN SESSIONS.REVOKED_AT IS 'Timestamp when the session was manually revoked/terminated (NULL if active).';

CREATE TRIGGER SESSIONS_BU_SET_UPDATED_AT
BEFORE UPDATE ON SESSIONS
FOR EACH ROW
EXECUTE FUNCTION GLOBAL_SET_UPDATED_AT();

COMMENT ON TRIGGER SESSIONS_BU_SET_UPDATED_AT ON SESSIONS IS 'Automatically updates the UPDATED_AT column with the current timestamp before any UPDATE.';
