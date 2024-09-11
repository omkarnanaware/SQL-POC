CREATE TABLE datatypetesting (
    id SERIAL PRIMARY KEY,             -- Primary key constraint, auto-increment
    name VARCHAR(50) NOT NULL,         -- String type, cannot be NULL
    salary NUMERIC(10, 2) DEFAULT 1000,-- Numeric type with default value
    birthdate DATE,                    -- Date type
    hire_time TIMESTAMP,               -- Timestamp for precise time
    active BOOLEAN CHECK (active IN (TRUE, FALSE)), -- Boolean with check constraint
    email VARCHAR(100) UNIQUE,         -- Email must be unique
    phone CHAR(10),                    -- Fixed-length string for phone number
    profile TEXT,                      -- Text data type for storing large text
    picture BYTEA,                     -- Binary data type for storing binary data
    credit_limit NUMERIC(10, 2),       -- Numeric for financial data
    address VARCHAR(200),              -- Variable length string for address
    status CHAR(1) DEFAULT 'A'         -- Default value for status ('A' for active)
);

--Constraints Summary in PostgreSQL
--SERIAL PRIMARY KEY: Auto-incremented primary key, unique and not null.
--NOT NULL: Ensures a column cannot contain NULL values.
--DEFAULT: Provides a default value when none is supplied.
--CHECK: Ensures that values in the active column are either TRUE or FALSE.
--UNIQUE: Ensures unique values in the email column.


-- Insert a row with all fields provided
INSERT INTO datatypetesting (name, salary, birthdate, hire_time, active, email, phone, profile, credit_limit, address, status)
VALUES ('John Doe', 5000.50, '1985-12-12', current_timestamp, TRUE, 'john.doe@example.com', '1234567890',
'Senior Software Engineer with 10+ years of experience.', 50000, '1234 Elm Street', 'A');

-- Insert a row with some default values (salary, status)
INSERT INTO datatypetesting (name, birthdate, hire_time, active, email, phone, profile, credit_limit, address)
VALUES ('Jane Smith', '1990-05-05', current_timestamp, TRUE, 'jane.smith@example.com', '0987654321',
'Data Scientist with 5+ years of experience.', 30000, '5678 Oak Street');

-- Insert a row with binary data (BYTEA) and NULL fields
INSERT INTO datatypetesting (name, birthdate, hire_time, active, email, phone, credit_limit, picture, address)
VALUES ('Mark Johnson', '1980-11-22', current_timestamp, FALSE, 'mark.johnson@example.com', '1112223333',
20000, decode('00', 'hex'), '7890 Pine Street');


--Explanation of Insert Statements
--First Insert:
--
--All fields are explicitly provided, including profile (TEXT) and picture (BYTEA for binary data).
--The CHECK constraint for the active field ensures it only accepts TRUE or FALSE.
--Second Insert:
--
--Defaults are used for salary (1000) and status ('A'), leaving those fields out of the insert.
--The birthdate, hire_time, and boolean active fields are explicitly provided.
--Third Insert:
--
--Binary data is inserted in the picture column using decode('00', 'hex') (a way to insert a byte array).
--Some optional fields like profile are left out, and PostgreSQL handles the missing fields.

SELECT * FROM datatypetesting;

-- Update all records where the active status is TRUE
UPDATE datatypetesting
SET address = 'Updated Address'
WHERE active = TRUE;

-- Increase salary by 10% for employees with a credit limit greater than 30000
UPDATE datatypetesting
SET salary = salary * 1.10
WHERE credit_limit > 30000;

-- Set status to 'I' (Inactive) for employees hired before January 1, 2020
UPDATE datatypetesting
SET status = 'I'
WHERE hire_time < '2020-01-01 00:00:00';

-- Delete records where the address is '1234 Elm Street'
DELETE FROM datatypetesting
WHERE address = '1234 Elm Street';

-- Delete records where salary is less than 2000 and status is not 'A'
DELETE FROM datatypetesting
WHERE salary < 2000 AND status <> 'A';

-- Delete all records with a hire time older than January 1, 2020
DELETE FROM datatypetesting
WHERE hire_time < '2020-01-01 00:00:00';