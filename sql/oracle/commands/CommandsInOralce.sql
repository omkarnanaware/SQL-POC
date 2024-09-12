
DESC table_name;

--Output : -
--
--Name           Null?    Type
---------------- -------- ------------
--EMPLOYEE_ID    NOT NULL NUMBER(6)
--FIRST_NAME              VARCHAR2(20)
--LAST_NAME      NOT NULL VARCHAR2(25)
--EMAIL          NOT NULL VARCHAR2(25)
--PHONE_NUMBER            VARCHAR2(20)
--HIRE_DATE      NOT NULL DATE
--JOB_ID         NOT NULL VARCHAR2(10)
--SALARY                  NUMBER(8,2)
--COMMISSION_PCT          NUMBER(2,2)
--MANAGER_ID              NUMBER(6)
--DEPARTMENT_ID           NUMBER(4)
--
--
--Provide description of table
--return column names,nullable or not and data types
--can be used with desc or describe command
--
--other way to get info of table in sqldeveloper application is by selecting table naame and pressing Shift + F4


-----------------------------------------------------------------------------------------------------------------------
--1. Database Information
--a) Database Version
-- This query retrieves information about the Oracle database version.
SELECT * FROM v$version;

--b) Database Name
-- This query retrieves the name of the Oracle database.
SELECT name FROM v$database;


--c) Database Parameters
-- This query retrieves the current initialization parameters of the Oracle database.
SELECT name, value FROM v$parameter;

-----------------------------------------------------------------------------------------------------------------------
--2. Table Information
--a) List of Tables
-- This query retrieves the list of all tables in a specific schema. Replace 'YOUR_SCHEMA' with the actual schema name.
SELECT table_name
FROM all_tables
WHERE owner = 'YOUR_SCHEMA';

--b) Table Details (Number of Rows, Last Analyzed)
-- This query retrieves information such as the number of rows, last analyzed date, and table name.
SELECT table_name, num_rows, last_analyzed
FROM dba_tables
WHERE owner = 'YOUR_SCHEMA';


--c) Column Information of a Specific Table
-- This query retrieves information about the columns (data types, nullability) of a specific table. Replace 'YOUR_TABLE' with the actual table name.
SELECT column_name, data_type, data_length, nullable
FROM all_tab_columns
WHERE table_name = 'YOUR_TABLE';

-----------------------------------------------------------------------------------------------------------------------
--3. Session Information

--a) Current Session Information
-- This query retrieves information about the current session, including session ID (SID), serial number, username, and status.
SELECT sid, serial#, username, status
FROM v$session
WHERE username IS NOT NULL;

--b) Detailed Session Information (with SQL queries being executed)
-- This query retrieves detailed session information including the SQL text being executed.
SELECT s.sid, s.serial#, s.username, s.status, q.sql_text
FROM v$session s
JOIN v$sql q ON s.sql_address = q.address;

--c) Changing Session Information (Kill a Session)
-- To kill a session, you need the SID and SERIAL#. Use this command with caution as it terminates a session.
-- Replace 'SID' and 'SERIAL#' with actual values.
ALTER SYSTEM KILL SESSION 'SID,SERIAL#';


--d) Changing Session Parameters (Modify Parameters Temporarily)
-- This query allows you to modify session parameters temporarily, such as changing the optimizer mode for a session.
-- Replace 'YOUR_SETTING' with the actual setting (e.g., 'FIRST_ROWS').
ALTER SESSION SET optimizer_mode = 'YOUR_SETTING';

-----------------------------------------------------------------------------------------------------------------------
--4. Storage Information
--a) Tablespace Information
-- This query retrieves information about all tablespaces in the database, including their status and type of content (PERMANENT, TEMPORARY).
SELECT tablespace_name, status, contents
FROM dba_tablespaces;

--b) Datafile Information
-- This query retrieves information about data files, including file names, associated tablespaces, and size.
SELECT file_name, tablespace_name, bytes, status
FROM dba_data_files;


--c) Storage Usage for Tablespaces
-- This query retrieves storage usage details for each tablespace, including the amount of used and free space.
SELECT tablespace_name, used_space, free_space
FROM dba_tablespace_usage_metrics;

--d) Storage Information for Specific Table (Segment Information)
-- This query retrieves storage details of a specific table, including the size allocated and used.
-- Replace 'YOUR_TABLE' with the actual table name.
SELECT segment_name, segment_type, tablespace_name, bytes
FROM dba_segments
WHERE segment_name = 'YOUR_TABLE';

-----------------------------------------------------------------------------------------------------------------------

--5. User and Schema Information
--a) Current User
-- This query retrieves the name of the current user.
SELECT user FROM dual;


--b) All Users in the Database
-- This query retrieves a list of all users created in the Oracle database.
SELECT username
FROM dba_users;

-----------------------------------------------------------------------------------------------------------------------

--6. Additional Queries for Monitoring
--a) Monitoring Blocked Sessions

-- This query helps in identifying blocked sessions, which are waiting for some resource.
SELECT s1.username || '@' || s1.machine || ' ( SID=' || s1.sid || ' ) is blocking ' || s2.username || '@' || s2.machine || ' ( SID=' || s2.sid || ' ) ' AS blocking_status
FROM v$lock l1
JOIN v$session s1 ON s1.sid = l1.sid
JOIN v$lock l2 ON l1.block = 1 AND l2.request > 0 AND l1.id1 = l2.id1 AND l1.id2 = l2.id2
JOIN v$session s2 ON s2.sid = l2.sid;
These commands provide a full set of information gathering for database status, table structures, session management, and storage monitoring. You can run them based on your need to monitor or gather data in Oracle.

-----------------------------------------------------------------------------------------------------------------------
-- 7) NLS SETTINGS

-- NLS settings control various language and territory-dependent behavior in Oracle databases,
-- such as date formats, numeric formats, and language used for error messages.

-- The NLS settings can be changed at the following levels:
-- 1. **Instance Level (Database-wide)**: Affects all sessions in the instance.
-- 2. **Session Level**: Affects only the current session and can override the instance-level settings.

-- ALTER SESSION allows you to change NLS parameters for the current session.
-- This command is often used when you need to work with a specific language or formatting within a session.

-- Example of altering the NLS settings for a session:

-- Setting the NLS_DATE_FORMAT to a specific format (e.g., 'DD-MM-YYYY').
-- This changes how dates are formatted in queries and outputs within this session only.
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

-- Use case: If you are running a report or working with a specific date format and need it for only your session,
-- this command will help without changing the database-wide settings.

-- Setting the NLS_NUMERIC_CHARACTERS to specify decimal and group separators.
-- In this example, a comma (,) is used as the decimal separator and a period (.) is used as the group separator.
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ',.';

-- Use case: This is useful when you need to work with number formats that are different from the default settings.
-- For example, European countries often use commas as decimal separators and periods for grouping digits.

-- Setting the NLS_TERRITORY to a specific region (e.g., 'AMERICA').
-- This controls things like the default date format, currency symbols, and first day of the week for the session.
ALTER SESSION SET NLS_TERRITORY = 'AMERICA';

-- Use case: If you're working with date formats or currency symbols that differ by region,
-- this command ensures that the session's behavior matches the conventions of the specified territory.

-- Setting the NLS_LANGUAGE to a specific language (e.g., 'FRENCH').
-- This changes the language used for error messages and day/month names in the session.
ALTER SESSION SET NLS_LANGUAGE = 'FRENCH';

-- Use case: This command is useful when working with multi-language systems or generating reports in different languages.
-- It ensures that error messages and other language-specific outputs appear in the desired language.

-- To check the current NLS settings for the session:
SELECT * FROM NLS_SESSION_PARAMETERS;

-- If you need to revert back to the database's default NLS settings, you can issue the following command:
-- This resets all NLS parameters for the current session to their defaults.
ALTER SESSION RESET NLS_PARAMETERS;

-- Instance-level changes can be made via the initialization parameter file (PFILE or SPFILE), but
-- ALTER SYSTEM is not supported for changing NLS settings at the system level.
-- Any session-level changes will not affect other users or the entire database.

-- NLS settings are crucial in international applications, where formatting and language requirements vary based on region or user preferences.



