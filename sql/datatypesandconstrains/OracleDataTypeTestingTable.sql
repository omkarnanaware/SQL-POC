CREATE TABLE datatypetesting (
    id NUMBER(5) PRIMARY KEY,           -- Primary key constraint (ID must be unique and non-null)
    name VARCHAR2(50) NOT NULL,         -- String type, cannot be NULL
    salary NUMBER(10, 2) DEFAULT 1000,  -- Numeric type with default value
    birthdate DATE,                     -- Date type
    hire_time TIMESTAMP,                -- Timestamp for precise time
    active BOOLEAN CHECK (active IN (0, 1)), -- Boolean (must be either 0 or 1)
    email VARCHAR2(100) UNIQUE,         -- Email must be unique
    phone CHAR(10),                     -- Fixed-length string for phone number
    profile CLOB,                       -- Character large object for storing text
    picture BLOB,                       -- Binary large object for storing binary data
    credit_limit DECIMAL(10, 2),        -- Decimal value for storing financial data
    address VARCHAR2(200),              -- Address field with a variable length
    status CHAR(1) DEFAULT 'A'          -- Default value for status (A for active)
);

--Constraints Summary
--Primary Key on id.
--NOT NULL constraint on name.
--DEFAULT values on salary and status.
--CHECK constraint on active (must be 0 or 1).
--UNIQUE constraint on email.




-- Insert a row with all fields provided
INSERT INTO datatypetesting (id, name, salary, birthdate, hire_time, active, email, phone, profile, credit_limit, address, status)
VALUES (1, 'John Doe', 5000.50, TO_DATE('1985-12-12', 'YYYY-MM-DD'), SYSTIMESTAMP, 1, 'john.doe@example.com', '1234567890',
'Senior Software Engineer with 10+ years of experience.', 50000, '1234 Elm Street', 'A');

-- Insert a row with some default values (salary, status)
INSERT INTO datatypetesting (id, name, birthdate, hire_time, active, email, phone, profile, credit_limit, address)
VALUES (2, 'Jane Smith', TO_DATE('1990-05-05', 'YYYY-MM-DD'), SYSTIMESTAMP, 1, 'jane.smith@example.com', '0987654321',
'Data Scientist with 5+ years of experience.', 30000, '5678 Oak Street');

-- Insert a row with null optional fields and BLOB field
INSERT INTO datatypetesting (id, name, birthdate, hire_time, active, email, phone, credit_limit, picture, address)
VALUES (3, 'Mark Johnson', TO_DATE('1980-11-22', 'YYYY-MM-DD'), SYSTIMESTAMP, 0, 'mark.johnson@example.com', '1112223333',
20000, EMPTY_BLOB(), '7890 Pine Street');


--Explanation of Insert Statements
--First Insert:
--
--Inserts all fields including CLOB, BLOB, and default values for salary and status.
--Uses TO_DATE to convert a string into a DATE datatype and SYSTIMESTAMP for the current timestamp.
--Second Insert:
--
--Inserts a row where the salary and status fields are not specified, so default values will be used (1000 and 'A' respectively).
--Third Insert:
--
--Inserts a row with an empty BLOB (EMPTY_BLOB()) and a few optional fields (profile and salary) left out.


SELECT * FROM datatypetesting;


-- Update all records where the active status is 1
UPDATE datatypetesting
SET address = 'Updated Address'
WHERE active = 1;

-- Increase salary by 10% for employees with a credit limit greater than 30000
UPDATE datatypetesting
SET salary = salary * 1.10
WHERE credit_limit > 30000;

-- Set status to 'I' (Inactive) for employees who have not been hired in the last 5 years
UPDATE datatypetesting
SET status = 'I'
WHERE hire_time < SYSDATE - INTERVAL '5' YEAR;


DELETE FROM datatypetesting
WHERE address = '1234 Elm Street';

-- Delete records where salary is less than 2000 and status is not 'A'
DELETE FROM datatypetesting
WHERE salary < 2000 AND status <> 'A';

-- Delete all records older than a specific date (e.g., 2020-01-01)
DELETE FROM datatypetesting
WHERE hire_time < TO_DATE('2020-01-01', 'YYYY-MM-DD');


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