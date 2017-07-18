--------------------------------
-- RUN AGAINST SYSTEMDB DATABASE
--------------------------------

-- CHECK EML AFL COMPONENT IS INSTALLED
SELECT * FROM "SYS"."AFL_AREAS" WHERE AREA_NAME = 'EML';
SELECT * FROM "SYS"."AFL_PACKAGES" WHERE AREA_NAME = 'EML';
SELECT * FROM "SYS"."AFL_FUNCTIONS" WHERE AREA_NAME = 'EML';

-- CHECK TENANT DATABASE EXISTS AND IS STARTED
SELECT * FROM SYS.M_DATABASES;

-- START TENANT DATABASE (IF NEEDED)
ALTER SYSTEM START DATABASE SHA;

-- ADD SCRIPT SERVER TO TENANT DATABASE
ALTER DATABASE SHA ADD 'scriptserver';


------------------------------
-- RUN AGAINST TENANT DATABASE
------------------------------

-- CHECK SCRIPT SERVER
SELECT * FROM SYS.M_SERVICES;

-- CREATE USER
CREATE USER DEVUSER PASSWORD Password1;

-- AUTHORIZE EML ADMINISTRATION
GRANT MONITORING TO DEVUSER;
GRANT CREATE REMOTE SOURCE TO DEVUSER;
GRANT SELECT, UPDATE, INSERT, DELETE ON _SYS_AFL.EML_MODEL_CONFIGURATION TO DEVUSER;

-- AUTHORIZE CREATION & REMOVAL OF EML PROCEDURES
GRANT AFLPM_CREATOR_ERASER_EXECUTE TO DEVUSER;

-- AUTHORIZE EXECUTION OF EML PROCEDURES
GRANT AFL__SYS_AFL_EML_EXECUTE TO DEVUSER;