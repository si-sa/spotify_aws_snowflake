# aws s3 to snowflake
Trasfer spotify data from AWS S3 to Snowflake
1. Upload data into a S3 folder
2. Create a role `snowflake_s3_access` of full s3 access for a s3 bucket and give permissions to snowflake
3. Create a database, table & it's schema in snowflake
4. Create a storage integration for s3 and add details of AWS role ARN & S3 location
5. Extract external_id of the integration and add it in trusted entitiy of the `snowflake_s3_access` role
6. Create a file format explaining the csv format to be imported from s3 to snowflake DB
7. Create a stage to get data from s3 url (including the storage integration and the file format)
8. Run, get the data into Snowflake and do analysis.
