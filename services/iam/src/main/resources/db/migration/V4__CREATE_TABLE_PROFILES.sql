CREATE TABLE PROFILES(
	USER_ID UUID PRIMARY KEY REFERENCES USERS(ID) ON DELETE CASCADE,
	DISPLAY_NAME TEXT,
	BIRTH DATE,
	GENDER TEXT,
	PHONE TEXT,
	BIO TEXT,
	TIMEZONE TEXT,
	URL TEXT,
	CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE PROFILES IS 'Stores additional personal and presentation information associated with a user.';
COMMENT ON COLUMN PROFILES.USER_ID IS 'Identifier of the user associated with the profile.';
COMMENT ON COLUMN PROFILES.DISPLAY_NAME IS 'Name displayed to other users and throughout the application.';
COMMENT ON COLUMN PROFILES.BIRTH IS 'Birth date of the user.';
COMMENT ON COLUMN PROFILES.GENDER IS 'Gender information provided by the user.';
COMMENT ON COLUMN PROFILES.PHONE IS 'Phone number associated with the user profile.';
COMMENT ON COLUMN PROFILES.BIO IS 'Short biographical description provided by the user.';
COMMENT ON COLUMN PROFILES.TIMEZONE IS 'IANA time zone identifier used for user-specific date and time representation.';
COMMENT ON COLUMN PROFILES.URL IS 'Stores the URL of the user''s profile avatar image.';
COMMENT ON COLUMN PROFILES.CREATED_AT IS 'Timestamp when the user profile was created.';
COMMENT ON COLUMN PROFILES.UPDATED_AT IS 'Timestamp when the user profile was last updated.';

CREATE TRIGGER PROFILES_BU_SET_UPDATED_AT
BEFORE UPDATE ON PROFILES
FOR EACH ROW
EXECUTE FUNCTION GLOBAL_SET_UPDATED_AT();

COMMENT ON TRIGGER PROFILES_BU_SET_UPDATED_AT ON PROFILES IS 'Automatically updates UPDATED_AT whenever the user profile is modified.';
