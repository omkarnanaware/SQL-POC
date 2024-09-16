--1. What is a Database?
--A database is an organized collection of structured information, or data, typically stored electronically in a computer system. It allows users to store, retrieve, and manage data efficiently. A database management system (DBMS) is software that interacts with the database and provides tools for managing the data.
--	• Examples of databases: Oracle, PostgreSQL, MySQL, Hive, etc.
--
--2. What is a Schema?
--A schema in a database is a logical collection of database objects, such as tables, views, indexes, stored procedures, etc. A schema organizes the objects in a database. In relational databases, a schema also defines the structure of data, including the relationships between different tables.
--	• A schema can be thought of as a namespace or a logical container in which objects are stored.
--	• A single database can contain multiple schemas.
--
--3. What is a User?
--A user in a database refers to an account that can log in to the database and has certain privileges, such as reading or modifying data. Each user has a unique identity and specific roles or permissions to interact with the database.
--	• Privileges: Users can be granted privileges like SELECT, INSERT, UPDATE, and DELETE on database objects.
--
--How to Create Database, Schema, and User in Oracle, PostgreSQL, and Hive
--
--Oracle
--1. Creating a Database in Oracle
--Oracle databases are generally created at the time of the installation. However, to create a new Pluggable Database (PDB) in an existing Container Database (CDB), you can use the following commands.

CREATE PLUGGABLE DATABASE pdb_name
ADMIN USER pdb_admin IDENTIFIED BY password
ROLES = (DBA);

--2. Creating a User in Oracle
--In Oracle, a user and schema are often linked. When you create a user, it also creates a schema with the same name.

-- Create a user with a schema
CREATE USER username IDENTIFIED BY password;
-- Grant basic privileges to the user
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO username;
-- Grant specific privileges (optional)
GRANT SELECT, INSERT, UPDATE, DELETE ON schema_name.table_name TO username;

--3. Creating a Schema in Oracle
--In Oracle, creating a schema is done implicitly when you create a user. The schema’s name is the same as the user’s name.

-- Schema is automatically created when the user is created
CREATE USER schema_name IDENTIFIED BY password;
-- Grant privileges to the schema
GRANT CREATE SESSION, CREATE TABLE TO schema_name;

--Example for Oracle

-- Create a user and schema
CREATE USER sales_user IDENTIFIED BY sales_pass;
-- Grant basic privileges
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO sales_user;
-- Grant additional privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON sales_schema.sales_table TO sales_user;

--PostgreSQL
--1. Creating a Database in PostgreSQL
--
---- Create a new database
--CREATE DATABASE db_name;
--2. Creating a User in PostgreSQL

-- Create a new user with a password
CREATE USER username WITH PASSWORD 'password';
-- Grant privileges to the user
GRANT ALL PRIVILEGES ON DATABASE db_name TO username;

--
--3. Creating a Schema in PostgreSQL
--In PostgreSQL, schemas are independent of users. You can create a schema and specify which user owns it.

-- Create a schema
CREATE SCHEMA schema_name AUTHORIZATION username;
-- Grant privileges to the schema
GRANT ALL ON SCHEMA schema_name TO username;
Example for PostgreSQL

-- Create a database
CREATE DATABASE sales_db;
-- Create a user
CREATE USER sales_user WITH PASSWORD 'sales_pass';
-- Grant privileges to the user on the database
GRANT ALL PRIVILEGES ON DATABASE sales_db TO sales_user;
-- Create a schema owned by the user
CREATE SCHEMA sales_schema AUTHORIZATION sales_user;
-- Grant privileges to the user on the schema
GRANT ALL ON SCHEMA sales_schema TO sales_user;

--Hive
--In Hive, the concept of a database is used to group tables, and the schema is implicit in the tables created under a database. Users in Hive are managed via the underlying Hadoop or RDBMS system (such as MySQL or PostgreSQL), and role-based access control (RBAC) is often used for managing privileges.
--1. Creating a Database in Hive

-- Create a new database in Hive
CREATE DATABASE db_name;
-- Switch to the database
USE db_name;

--2. Creating a User in Hive
--Hive does not directly manage users. User permissions are typically handled through Hadoop's HDFS or Hive's metastore database (e.g., MySQL). A user in Hive can be managed by granting roles or policies via systems like Ranger or Sentry.
--To grant privileges in Hive, you might configure them using the HDFS file system permissions or security tools like Apache Ranger or Apache Sentry.
--3. Creating a Schema in Hive
--A schema in Hive is synonymous with a database, and it is automatically created when you create a database.
--Example for Hive

-- Create a database
CREATE DATABASE sales_db;
-- Use the database
USE sales_db;
-- Create a table in the sales_db schema
CREATE TABLE sales_table (
    id INT,
    name STRING,
    amount DOUBLE
);
-- Grant privileges (if using Ranger/Sentry, otherwise handled via HDFS permissions)
GRANT ALL ON TABLE sales_table TO USER sales_user;

--Summary of Examples
--Database	Create Database	Create User	Create Schema
--Oracle	Pluggable databases are created using the CREATE PLUGGABLE DATABASE command	Users are created with CREATE USER which also creates a schema	Schema is created implicitly when a user is created
--PostgreSQL	Use CREATE DATABASE	Use CREATE USER	Use CREATE SCHEMA and assign it to a user
--Hive	Use CREATE DATABASE	Hive uses external systems for user management	Schema is equivalent to a database in Hive

--Additional Notes:
--	• In Oracle, when you create a user, a schema with the same name is automatically created.
--	• In PostgreSQL, databases, users, and schemas are all created independently.
--	• In Hive, a database acts as a schema, and user management is often done via Hadoop's underlying user authentication and authorization systems, or via Apache Ranger/Sentry.
--These examples should help you create and manage databases, users, and schemas across Oracle, PostgreSQL, and Hive environments.
