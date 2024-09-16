CREATE TABLE datatypetesting (
    id INT,                            -- Integer type
    name STRING NOT NULL,              -- String type, cannot be NULL
    salary DECIMAL(10, 2) DEFAULT 1000,-- Decimal with default value
    birthdate DATE,                    -- Date type
    hire_time TIMESTAMP,               -- Timestamp for precise time
    active BOOLEAN,                    -- Boolean type
    email STRING,                      -- Email field
    phone CHAR(10),                    -- Fixed-length string for phone number
    profile STRING,                    -- Text data type
    picture BINARY,                    -- Binary data type
    credit_limit DECIMAL(10, 2),       -- Decimal value for financial data
    address STRING,                    -- String type for address
    status CHAR(1) DEFAULT 'A'         -- Default value for status ('A' for active)
)
TBLPROPERTIES ('transactional'='true');

--Constraints Summary in Hive
--NOT NULL constraint on the name column.
--DEFAULT values on salary and status.
--Hive doesn’t enforce primary keys, foreign keys, or unique constraints. These can be declared but are not validated or enforced.


-- Insert a row with all fields provided
INSERT INTO datatypetesting (id, name, salary, birthdate, hire_time, active, email, phone, profile, credit_limit, address, status)
VALUES (1, 'John Doe', 5000.50, '1985-12-12', current_timestamp(), TRUE, 'john.doe@example.com', '1234567890',
'Senior Software Engineer with 10+ years of experience.', 50000, '1234 Elm Street', 'A');

-- Insert a row with some default values (salary, status)
INSERT INTO datatypetesting (id, name, birthdate, hire_time, active, email, phone, profile, credit_limit, address)
VALUES (2, 'Jane Smith', '1990-05-05', current_timestamp(), TRUE, 'jane.smith@example.com', '0987654321',
'Data Scientist with 5+ years of experience.', 30000, '5678 Oak Street');

-- Insert a row with null optional fields
INSERT INTO datatypetesting (id, name, birthdate, hire_time, active, email, phone, credit_limit, picture, address)
VALUES (3, 'Mark Johnson', '1980-11-22', current_timestamp(), FALSE, 'mark.johnson@example.com', '1112223333',
20000, X'00', '7890 Pine Street');


--Explanation of Insert Statements
--First Insert:
--
--Provides all fields, including profile (STRING), and uses current_timestamp() for the hire_time.
--The DECIMAL, BOOLEAN, and BINARY types are tested with this row.
--Second Insert:
--
--Leaves out salary and status, allowing Hive to insert default values (1000 for salary and 'A' for status).
--Third Insert:
--
--Uses binary data for the picture field (X'00'), which represents an empty binary value.
--Leaves out optional fields (profile).


SELECT * FROM datatypetesting;


-- Update all records where the active status is TRUE
UPDATE datatypetesting
SET address = 'Updated Address'
WHERE active = TRUE;

-- Increase salary by 10% for records with a credit limit greater than 30000
UPDATE datatypetesting
SET salary = salary * 1.10
WHERE credit_limit > 30000;

-- Set status to 'I' (Inactive) for employees who were hired before January 1, 2020
UPDATE datatypetesting
SET status = 'I'
WHERE hire_time < '2020-01-01 00:00:00';


-- Delete records where the address is '1234 Elm Street'
DELETE FROM datatypetesting
WHERE address = '1234 Elm Street';

-- Delete records where salary is less than 2000 and status is not 'A'
DELETE FROM datatypetesting
WHERE salary < 2000 AND status <> 'A';

-- Delete all records older than January 1, 2020
DELETE FROM datatypetesting
WHERE hire_time < '2020-01-01 00:00:00';


--UPDATE Examples:
--
--Update by status: Modifies records based on a boolean field.
--Update by numeric range: Adjusts values based on a comparison with numeric fields.
--Update by date: Sets values based on a date condition.
--DELETE Examples:
--
--Delete by exact match: Removes records matching a specific value.
--Delete by range and condition: Deletes records that meet multiple conditions.
--Delete by date: Removes records older than a specific date.