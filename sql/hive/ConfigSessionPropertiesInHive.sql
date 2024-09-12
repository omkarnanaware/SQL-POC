--Apache Hive also provides mechanisms for setting and customizing certain behaviors at both the session level and global level, though it doesn’t have an exact equivalent to Oracle's NLS settings. Instead, Hive has a series of configuration parameters that control language, date formatting, numeric formatting, and other behaviors. These can be set using the SET command in Hive.

--Here’s how you can configure settings in Hive:

1. Session-Level Settings in Hive
You can use the SET command to modify configuration properties at the session level. These settings only apply to the current Hive session and will not affect other users.


-- To view all current Hive configuration settings in the session
SET;

-- To view the value of a specific property (e.g., the date format)
SET hive.cli.print.header;

-- To set a session-level configuration property (e.g., changing date format)
SET hive.cli.print.header=true;

-- To change the default timestamp format in the session:
SET hive.timestamp.format = 'yyyy-MM-dd HH:mm:ss';


2. Global Settings (hive-site.xml)
For global-level changes (which apply to all users and sessions), you can modify the hive-site.xml configuration file, located in the Hive configuration directory.

Example: Modify Date Format Globally
Open hive-site.xml.

Add or modify the following property to set the global date format:

xml
Copy code
<property>
  <name>hive.timestamp.format</name>
  <value>yyyy-MM-dd HH:mm:ss</value>
  <description>Default timestamp format for all Hive queries</description>
</property>
Restart the Hive server for changes to take effect.

Key Configuration Parameters in Hive
Here are some common configuration properties similar to Oracle’s NLS settings:

a) Date and Time Formatting
hive.timestamp.format: Sets the format for timestamps in queries.
hive.cli.print.header: Controls whether to print column headers when running queries in the Hive CLI.
b) Locale and Language
Hive doesn’t have a direct mechanism to change the language for error messages or day/month names like Oracle’s NLS_LANGUAGE, but you can modify certain locale-related settings in the JVM that Hive runs on. However, it’s less common to customize Hive for multi-language environments directly.

c) Decimal and Numeric Formatting
hive.default.decimal.scale: Defines the default number of decimal places for DECIMAL type columns.
hive.resultset.use.unique.column.names: Determines if unique column names should be used when returning query results.
d) Handling NULL Values
hive.resultset.null.format: Specifies how NULL values are displayed in query results (e.g., set to NULL, or \N).
e) Timezone Settings
hive.exec.local.time.zone: Configures the timezone to be used for the local machine where Hive is running.
hive.execution.engine.timezone: Configures the timezone for query execution.
Example of Session-Level Settings in Hive

-- Changing the timestamp format for the current session
SET hive.timestamp.format = 'dd/MM/yyyy HH:mm:ss';

-- Changing the default NULL format to display \N instead of NULL
SET hive.resultset.null.format=\N;

-- Enabling unique column names in the session (important for self-joins)
SET hive.resultset.use.unique.column.names=true;
When to Use Hive Settings
Session-level settings are useful when you need temporary configurations for specific query executions, without affecting other users.
Global-level settings (via hive-site.xml) are more appropriate when you need consistency across all Hive queries and users.