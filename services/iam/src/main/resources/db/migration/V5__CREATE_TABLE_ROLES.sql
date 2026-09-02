CREATE TABLE ROLES(
    ID UUID PRIMARY KEY DEFAULT UUID_GENERATE_V4(),
    NAME TEXT NOT NULL UNIQUE,
    DESCRIPTION TEXT,
    CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE ROLES IS 'Defines system roles or groups (e.g., ADMIN, MANAGER, USER) assigned to users.';
COMMENT ON COLUMN ROLES.ID IS 'Unique primary key identifier for the role.';
COMMENT ON COLUMN ROLES.NAME IS 'Unique name of the role (e.g., ADMIN, CUSTOMER). Must be uppercase or normalized by application.';
COMMENT ON COLUMN ROLES.DESCRIPTION IS 'Brief description of the role responsibilities.';
COMMENT ON COLUMN ROLES.CREATED_AT IS 'Timestamp with time zone indicating when the role record was created.';
COMMENT ON COLUMN ROLES.UPDATED_AT IS 'Timestamp with time zone indicating when the role record was last modified.';

CREATE TRIGGER ROLES_BU_SET_UPDATED_AT
BEFORE UPDATE ON ROLES
FOR EACH ROW
EXECUTE FUNCTION GLOBAL_SET_UPDATED_AT();

COMMENT ON TRIGGER ROLES_BU_SET_UPDATED_AT ON ROLES IS 'Fires before any UPDATE on the ROLES table to automatically update the UPDATED_AT column using GLOBAL_SET_UPDATED_AT().';
