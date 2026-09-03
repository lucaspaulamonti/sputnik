CREATE TABLE LOCKS(
	ID UUID PRIMARY KEY DEFAULT UUID_GENERATE_V4(),
    USER_ID UUID NOT NULL REFERENCES USERS(ID) ON DELETE CASCADE,
	REASON TEXT NOT NULL,
	CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	EXPIRES_AT TIMESTAMPTZ,
	RELEASED_AT TIMESTAMPTZ,
	RELEASED_BY BIGINT
);

COMMENT ON TABLE LOCKS IS 'Manages user account locks, including their reason, expiration, and release information.';
COMMENT ON COLUMN LOCKS.ID IS 'Unique identifier of the user lock.';
COMMENT ON COLUMN LOCKS.USER_ID IS 'Identifier of the user whose account is locked.';
COMMENT ON COLUMN LOCKS.REASON IS 'Reason for the user account lock.';
COMMENT ON COLUMN LOCKS.CREATED_AT IS 'Timestamp when the user account lock was created.';
COMMENT ON COLUMN LOCKS.EXPIRES_AT IS 'Timestamp after which the user account lock automatically expires. NULL indicates that the lock does not expire automatically.';
COMMENT ON COLUMN LOCKS.RELEASED_AT IS 'Timestamp when the user account lock was manually released. NULL indicates that the lock has not been manually released.';
COMMENT ON COLUMN LOCKS.RELEASED_BY IS 'Identifier of the user who manually released the account lock. NULL indicates that the lock has not been manually released.';

CREATE INDEX IX_LOCKS__USER_ID_RELEASED_AT
ON LOCKS(USER_ID)
WHERE RELEASED_AT IS NULL;

COMMENT ON INDEX IX_LOCKS__USER_ID_RELEASED_AT IS 'Improves queries for active user locks that have not been released.';
