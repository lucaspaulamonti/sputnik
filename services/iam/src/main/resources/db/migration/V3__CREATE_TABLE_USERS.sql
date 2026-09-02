CREATE TABLE USERS(
	ID UUID PRIMARY KEY DEFAULT UUID_GENERATE_V4(),
	FIRST_NAME TEXT NOT NULL,
	LAST_NAME TEXT,
	EMAIL TEXT NOT NULL,
	CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	DELETED_AT TIMESTAMPTZ
);

COMMENT ON TABLE USERS IS 'Stores core application user account records.';
COMMENT ON COLUMN USERS.ID IS 'Unique primary key identifier for the user.';
COMMENT ON COLUMN USERS.FIRST_NAME IS 'User''s given/first name. Must not be empty.';
COMMENT ON COLUMN USERS.LAST_NAME IS 'User''s family/surname (optional).';
COMMENT ON COLUMN USERS.EMAIL IS 'Unique email address used for authentication. Must not be empty.';
COMMENT ON COLUMN USERS.CREATED_AT IS 'Timestamp with time zone indicating when the user record was created.';
COMMENT ON COLUMN USERS.UPDATED_AT IS 'Timestamp with time zone indicating when the user record was last modified.';
COMMENT ON COLUMN USERS.DELETED_AT IS 'Timestamp with time zone for soft deletes. NULL indicates an active account.';

CREATE UNIQUE INDEX UQ_USERS__EMAIL
ON USERS(EMAIL) 
WHERE DELETED_AT IS NULL;

COMMENT ON INDEX UQ_USERS__EMAIL IS 'Partial unique index ensuring email uniqueness only among active accounts (where DELETED_AT IS NULL). Allows re-registration using emails from soft-deleted accounts.';

CREATE TRIGGER USERS_BU_SET_UPDATED_AT
BEFORE UPDATE ON USERS
FOR EACH ROW
EXECUTE FUNCTION GLOBAL_SET_UPDATED_AT();

COMMENT ON TRIGGER USERS_BU_SET_UPDATED_AT ON USERS IS 'Fires before any UPDATE on the USERS table to automatically update the UPDATED_AT column using GLOBAL_SET_UPDATED_AT().';
