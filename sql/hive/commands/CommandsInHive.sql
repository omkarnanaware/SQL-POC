
--Author : - Omkar Nanaware
--Email : omkarnanaware1998@gmail.com
--file : CommandsInHive.sql
--Date/Time : 09/13/2024 1:30AM


--Key Explanations:
--Table Information Commands: Use these to list, describe, and get metadata about tables. These are essential for understanding the structure and storage of data within your tables.
--Column Information Commands: Focused on understanding the fields of a table and their data types.
--Schema Information Commands: These commands deal with managing databases (schemas) and understanding the current working environment in Hive.
--Session Information Commands: These commands are used to view and change session-level configurations, like memory settings or execution engine settings.

-- ****************************************************************
-- ** Hive Commands for Table Information **
-- ****************************************************************

-- Get a list of all tables in the current database
SHOW TABLES;

-- Describe the structure of a specific table (replace `your_table` with the table name)
DESCRIBE FORMATTED your_table;

-- Detailed description of the table including storage information
DESCRIBE EXTENDED your_table;

-- List all partitions for a partitioned table (replace `your_table` with the table name)
SHOW PARTITIONS your_table;

-- Check if the table exists (returns the name if the table exists)
SHOW TABLES LIKE 'your_table';

-- Get the creation details of a specific table (replace `your_table` with the table name)
SHOW CREATE TABLE your_table;

-- Comment:
-- Use SHOW TABLES to list all tables in a database.
-- DESCRIBE FORMATTED and DESCRIBE EXTENDED are useful for checking the structure, storage format, and other metadata of a table.
-- SHOW PARTITIONS is specific for partitioned tables, used to list the available partitions.
-- SHOW CREATE TABLE displays the DDL for recreating the table.

-- ****************************************************************
-- ** Hive Commands for Column Information **
-- ****************************************************************

-- Describe column details of a table (replace `your_table` with the table name)
DESCRIBE your_table;

-- Fetch column names and types for a given table using a query (replace `your_table` with the table name)
SELECT * FROM your_table LIMIT 1;

-- Comment:
-- DESCRIBE provides information about columns in the table such as their names, data types, and comments if available.
-- SELECT * can be used in combination with LIMIT 1 to get the first row and view the column names and data types in the result.

-- ****************************************************************
-- ** Hive Commands for Schema Information **
-- ****************************************************************

-- Show the current database/schema in use
SELECT current_database();

-- List all databases in the Hive instance
SHOW DATABASES;

-- Switch to another database (replace `your_database` with the database name)
USE your_database;

-- Show tables in the selected database (replace `your_database` with the database name)
SHOW TABLES IN your_database;

-- Comment:
-- The SELECT current_database() command helps you to identify which schema you are currently working in.
-- SHOW DATABASES lists all the available databases in Hive.
-- USE your_database switches the active schema, useful when you're working across multiple databases.

-- ****************************************************************
-- ** Hive Commands for Session Information **
-- ****************************************************************

-- Get the current session properties
SET;

-- Set a specific property in the session (replace `property_name` and `value` as needed)
SET property_name=value;

-- Reset a session property to its default value
RESET property_name;

-- Comment:
-- The SET command without any arguments lists all the current session properties.
-- SET property_name=value allows you to set or override a session-specific configuration, e.g., changing the execution engine from MR to Tez.
-- RESET property_name reverts any modified property back to its default value.

-- ****************************************************************
-- ** Additional Useful Commands **
-- ****************************************************************

-- Show user-defined functions (UDFs)
SHOW FUNCTIONS;

-- Detailed description of a function (replace `function_name` with the function name)
DESCRIBE FUNCTION function_name;

-- Get the current user's privileges on a specific table (replace `your_table` with the table name)
SHOW GRANT USER current_user() ON TABLE your_table;

-- Comment:
-- SHOW FUNCTIONS lists all available Hive functions.
-- DESCRIBE FUNCTION gives details about how to use a specific function.
-- SHOW GRANT displays the privileges a user has on a particular table, which is helpful when troubleshooting permission issues.